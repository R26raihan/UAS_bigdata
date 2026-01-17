from sqlalchemy.orm import Session
from typing import Optional
from app.repositories.document_repository import DocumentRepository
from app.repositories.financial_repository import FinancialRepository
from app.models.document import Document
from app.schemas.document import DocumentResponse, DocumentListResponse
from app.schemas.financial import (
    FinancialDocumentDetail, FinancialSummaryResponse,
    FinancialBreakdownResponse, FinancialCashFlowResponse, FinancialTrendResponse
)


class DocumentService:
    def __init__(self, db: Session):
        self.db = db
        self.document_repo = DocumentRepository(db)
        self.financial_repo = FinancialRepository(db)
    
    def create_document(self, document_in: any) -> dict:
        """Create a new document and auto-seed data if available"""
        # 1. Create the document record
        doc_data = document_in.model_dump() if hasattr(document_in, 'model_dump') else document_in
        new_doc = self.document_repo.create(doc_data)
        
        if new_doc.type == 'financial':
            from app.models.financial import FinancialSummary
            last_doc_with_data = self.db.query(Document).join(FinancialSummary).filter(
                Document.company_id == new_doc.company_id,
                Document.type == new_doc.type,
                Document.id != new_doc.id
            ).order_by(Document.created_at.desc()).first()
            if last_doc_with_data:
                self._clone_financial_data(last_doc_with_data.id, new_doc.id)
        
        elif new_doc.type == 'operational':
            from app.models.operational import OperationalKPI
            last_doc_with_data = self.db.query(Document).join(OperationalKPI).filter(
                Document.company_id == new_doc.company_id,
                Document.type == new_doc.type,
                Document.id != new_doc.id
            ).order_by(Document.created_at.desc()).first()
            if last_doc_with_data:
                self._clone_operational_data(last_doc_with_data.id, new_doc.id)

        elif new_doc.type == 'management':
            from app.models.management import ManagementSummary
            last_doc_with_data = self.db.query(Document).join(ManagementSummary).filter(
                Document.company_id == new_doc.company_id,
                Document.type == new_doc.type,
                Document.id != new_doc.id
            ).order_by(Document.created_at.desc()).first()
            if last_doc_with_data:
                self._clone_management_data(last_doc_with_data.id, new_doc.id)
                
        return new_doc

    def _clone_operational_data(self, source_doc_id: int, target_doc_id: int):
        """Clone all operational records from one document to another"""
        from app.models.operational import OperationalKPI, DepartmentPerformance, InventoryStatusModel, OperationalRisk
        
        # Clone KPI
        kpi = self.db.query(OperationalKPI).filter(OperationalKPI.document_id == source_doc_id).first()
        if kpi:
            self.db.add(OperationalKPI(
                document_id=target_doc_id,
                productivity_score=kpi.productivity_score,
                efficiency_score=kpi.efficiency_score,
                quality_score=kpi.quality_score,
                on_time_delivery_score=kpi.on_time_delivery_score
            ))
            
        # Clone Performance
        perf = self.db.query(DepartmentPerformance).filter(DepartmentPerformance.document_id == source_doc_id).all()
        for p in perf:
            self.db.add(DepartmentPerformance(
                document_id=target_doc_id,
                department_name=p.department_name,
                target_value=p.target_value,
                actual_value=p.actual_value,
                achievement_rate=p.achievement_rate
            ))
            
        # Clone Inventory
        inv = self.db.query(InventoryStatusModel).filter(InventoryStatusModel.document_id == source_doc_id).all()
        for i in inv:
            self.db.add(InventoryStatusModel(
                document_id=target_doc_id,
                item_name=i.item_name,
                current_stock=i.current_stock,
                status=i.status,
                restock_date=i.restock_date
            ))
            
        # Clone Risks
        risks = self.db.query(OperationalRisk).filter(OperationalRisk.document_id == source_doc_id).all()
        for r in risks:
            self.db.add(OperationalRisk(
                document_id=target_doc_id,
                category=r.category,
                risk_issue=r.risk_issue,
                impact_level=r.impact_level,
                probability_level=r.probability_level,
                mitigation_plan=r.mitigation_plan
            ))
        self.db.commit()

    def _clone_management_data(self, source_doc_id: int, target_doc_id: int):
        """Clone all management records from one document to another"""
        from app.models.management import ManagementSummary, StrategicGoal, SWOTAnalysis, Stakeholder
        
        # Clone Summary
        summary = self.db.query(ManagementSummary).filter(ManagementSummary.document_id == source_doc_id).first()
        if summary:
            self.db.add(ManagementSummary(
                document_id=target_doc_id,
                executive_summary=summary.executive_summary,
                challenges=summary.challenges,
                next_steps=summary.next_steps,
                achievements=summary.achievements
            ))
            
        # Clone Goals
        goals = self.db.query(StrategicGoal).filter(StrategicGoal.document_id == source_doc_id).all()
        for g in goals:
            self.db.add(StrategicGoal(
                document_id=target_doc_id,
                goal_name=g.goal_name,
                progress_percentage=g.progress_percentage,
                status=g.status,
                deadline=g.deadline
            ))
            
        # Clone SWOT
        swot = self.db.query(SWOTAnalysis).filter(SWOTAnalysis.document_id == source_doc_id).all()
        for s in swot:
            self.db.add(SWOTAnalysis(
                document_id=target_doc_id,
                analysis_type=s.analysis_type,
                content=s.content
            ))
            
        # Clone Stakeholders
        sh = self.db.query(Stakeholder).filter(Stakeholder.document_id == source_doc_id).all()
        for s in sh:
            self.db.add(Stakeholder(
                document_id=target_doc_id,
                name=s.name,
                role=s.role,
                involvement_level=s.involvement_level
            ))
        self.db.commit()

    def _clone_financial_data(self, source_doc_id: int, target_doc_id: int):
        """Clone all financial records from one document to another"""
        from app.models.financial import FinancialSummary, FinancialBreakdown, FinancialCashFlow, FinancialTrend
        
        # Clone Summary
        summary = self.financial_repo.get_summary_by_document(source_doc_id)
        if summary:
            new_summary = FinancialSummary(
                document_id=target_doc_id,
                revenue=summary.revenue,
                revenue_last_year=summary.revenue_last_year,
                expenses=summary.expenses,
                expenses_last_year=summary.expenses_last_year,
                net_profit=summary.net_profit,
                net_profit_last_year=summary.net_profit_last_year,
                profit_margin=summary.profit_margin,
                profit_margin_last_year=summary.profit_margin_last_year
            )
            self.db.add(new_summary)
            
        # Clone Breakdowns
        breakdowns = self.financial_repo.get_breakdowns_by_document(source_doc_id)
        for b in breakdowns:
            new_b = FinancialBreakdown(
                document_id=target_doc_id,
                category=b.category,
                amount=b.amount,
                previous_amount=b.previous_amount,
                percentage=b.percentage,
                type=b.type
            )
            self.db.add(new_b)
            
        # Clone Cash Flow
        cash_flow = self.financial_repo.get_cash_flow_by_document(source_doc_id)
        if cash_flow:
            new_cf = FinancialCashFlow(
                document_id=target_doc_id,
                operating_cash=cash_flow.operating_cash,
                investing_cash=cash_flow.investing_cash,
                financing_cash=cash_flow.financing_cash,
                beginning_cash=cash_flow.beginning_cash,
                ending_cash=cash_flow.ending_cash
            )
            self.db.add(new_cf)
            
        # Clone Trends
        trends = self.financial_repo.get_trends_by_document(source_doc_id)
        for t in trends:
            new_t = FinancialTrend(
                document_id=target_doc_id,
                period_label=t.period_label,
                revenue=t.revenue,
                profit=t.profit,
                sort_order=t.sort_order
            )
            self.db.add(new_t)
            
        self.db.commit()
    
    def get_all_documents(self, skip: int = 0, limit: int = 100, doc_type: Optional[str] = None) -> dict:
        """Get all documents with optional type filter"""
        if doc_type:
            documents = self.document_repo.get_by_type(doc_type, skip=skip, limit=limit)
            total = self.document_repo.get_total_count(doc_type=doc_type)
        else:
            documents = self.document_repo.get_with_company_info(skip=skip, limit=limit)
            total = self.document_repo.get_total_count()
        
        # Convert to response schema with company name
        doc_list = []
        for doc in documents:
            doc_dict = DocumentResponse.model_validate(doc).model_dump()
            doc_dict['company_name'] = doc.company.name if doc.company else None
            doc_list.append(DocumentListResponse(**doc_dict))
        
        return {
            "total": total,
            "skip": skip,
            "limit": limit,
            "data": doc_list
        }
    
    def get_document_by_id(self, document_id: int):
        """Get document by ID with full details based on type"""
        document = self.document_repo.get_by_id(document_id)
        if not document:
            return None
        
        # Convert SQLAlchemy object to dict to avoid Pydantic validation issues
        doc_dict = {
            "id": document.id,
            "company_id": document.company_id,
            "document_number": document.document_number,
            "type": document.type,
            "title": document.title,
            "period": document.period,
            "date": document.date,  # Keep as date object
            "notes": document.notes,
            "created_at": document.created_at
        }
        
        doc_response = DocumentResponse(**doc_dict)
        result = {
            "document": doc_response,
            "company_name": document.company.name if document.company else None
        }
        
        # Add type-specific data
        if document.type == "financial":
            result["financial_data"] = self._get_financial_data(document_id)
        elif document.type == "operational":
            result["operational_data"] = self._get_operational_data(document_id)
        elif document.type == "management":
            result["management_data"] = self._get_management_data(document_id)
        
        return result
    
    def get_documents_by_company(self, company_id: int, skip: int = 0, limit: int = 100) -> dict:
        """Get all documents for a specific company"""
        documents = self.document_repo.get_by_company(company_id, skip=skip, limit=limit)
        total = self.document_repo.get_total_count(company_id=company_id)
        
        return {
            "total": total,
            "skip": skip,
            "limit": limit,
            "data": [DocumentResponse.model_validate(doc) for doc in documents]
        }
    
    def _get_financial_data(self, document_id: int) -> FinancialDocumentDetail:
        """Get all financial data for a document"""
        summary = self.financial_repo.get_summary_by_document(document_id)
        breakdowns = self.financial_repo.get_breakdowns_by_document(document_id)
        cash_flow = self.financial_repo.get_cash_flow_by_document(document_id)
        trends = self.financial_repo.get_trends_by_document(document_id)
        
        return FinancialDocumentDetail(
            summary=FinancialSummaryResponse.model_validate(summary) if summary else None,
            breakdowns=[FinancialBreakdownResponse.model_validate(b) for b in breakdowns],
            cash_flow=FinancialCashFlowResponse.model_validate(cash_flow) if cash_flow else None,
            trends=[FinancialTrendResponse.model_validate(t) for t in trends]
        )

    def _get_operational_data(self, document_id: int) -> dict:
        """Get mock operational data for demonstration"""
        return {
            "kpi": {
                "productivity_score": 92,
                "efficiency_score": 88,
                "quality_score": 96,
                "on_time_delivery_score": 94
            },
            "performance": [
                {"department": "Produksi - Lini Utama", "target": 1000, "actual": 1050, "achievement": 105},
                {"department": "Logistik & Gudang", "target": 500, "actual": 480, "achievement": 96},
                {"department": "Quality Control", "target": 100, "actual": 98, "achievement": 98}
            ],
            "inventory": [
                {"item": "Bahan Baku A", "stock": "500 kg", "status": "Aman", "restockDate": "2024-03-01"},
                {"item": "Bahan Baku B", "stock": "50 kg", "status": "Kritis", "restockDate": "2024-02-15"}
            ],
            "risks": [
                {"category": "Suplai", "risk": "Keterlambatan Impor", "impact": "Tinggi", "probability": "Sedang", "mitigation": "Cari supplier alternatif lokal"}
            ],
            "achievements": [
                "Nol kecelakaan kerja dalam 100 hari terakhir",
                "Sertifikasi ISO 9001:2015 diperbarui"
            ],
            "issues": [
                "Kenaikan harga bahan bakar solar",
                "Kerusakan minor pada mesin conveyor lini 2"
            ],
            "recommendations": [
                "Pelatihan operator baru untuk meningkatkan efisiensi",
                "Audit energi berkala"
            ]
        }

    def _get_management_data(self, document_id: int) -> dict:
        """Get mock management data for demonstration"""
        return {
            "executiveSummary": "Performa perusahaan pada periode ini menunjukkan tren positif di seluruh lini bisnis utama.",
            "swot": {
                "strengths": ["Brand awareness kuat", "Tim inti berpengalaman"],
                "weaknesses": ["Ketergantungan pada vendor tunggal"],
                "opportunities": ["Ekspansi pasar ke luar pulau"],
                "threats": ["Kenaikan suku bunga bank"]
            },
            "stakeholders": [
                {"name": "Ir. Ahmad", "role": "Komisaris", "involvement": "Strategis"},
                {"name": "Budi Santoso", "role": "CEO", "involvement": "Operasional"}
            ],
            "strategicGoals": [
                {"goal": "Target Revenue 2024", "progress": 45, "status": "On Track", "deadline": "Des 2024"},
                {"goal": "Efisiensi Biaya 10%", "progress": 80, "status": "Ahead", "deadline": "Jun 2024"}
            ],
            "achievements": ["Meraih penghargaan inovasi bisnis", "Penyelesaian audit tahunan tanpa temuan"],
            "challenges": ["Fluktuasi nilai tukar rupiah", "Retensi talenta digital"],
            "nextSteps": ["Akuisisi startup teknologi", "Peluncuran produk kategori baru"]
        }
