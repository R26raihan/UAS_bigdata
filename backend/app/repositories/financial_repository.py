from sqlalchemy.orm import Session
from typing import Optional
from app.models.financial import (
    FinancialSummary, FinancialBreakdown, FinancialCashFlow, FinancialTrend
)


class FinancialRepository:
    def __init__(self, db: Session):
        self.db = db
    
    def get_summary_by_document(self, document_id: int) -> Optional[FinancialSummary]:
        """Get financial summary for a document"""
        return self.db.query(FinancialSummary).filter(
            FinancialSummary.document_id == document_id
        ).first()
    
    def get_breakdowns_by_document(self, document_id: int):
        """Get all financial breakdowns for a document"""
        return self.db.query(FinancialBreakdown).filter(
            FinancialBreakdown.document_id == document_id
        ).all()
    
    def get_cash_flow_by_document(self, document_id: int) -> Optional[FinancialCashFlow]:
        """Get cash flow for a document"""
        return self.db.query(FinancialCashFlow).filter(
            FinancialCashFlow.document_id == document_id
        ).first()
    
    def get_trends_by_document(self, document_id: int):
        """Get financial trends for a document"""
        return self.db.query(FinancialTrend).filter(
            FinancialTrend.document_id == document_id
        ).order_by(FinancialTrend.sort_order).all()
