from sqlalchemy.orm import Session
from typing import List, Optional
from app.models.company import Company
from app.models.document import Document


class CompanyRepository:
    def __init__(self, db: Session):
        self.db = db
    
    def get_all(self, skip: int = 0, limit: int = 100) -> List[Company]:
        """Get all companies with pagination"""
        return self.db.query(Company).offset(skip).limit(limit).all()
    
    def get_by_id(self, company_id: int) -> Optional[Company]:
        """Get company by ID"""
        return self.db.query(Company).filter(Company.id == company_id).first()
    
    def get_total_count(self) -> int:
        """Get total number of companies"""
        return self.db.query(Company).count()
    
    def get_with_document_count(self, skip: int = 0, limit: int = 100):
        """Get companies with their document count"""
        from sqlalchemy import func
        
        result = self.db.query(
            Company,
            func.count(Document.id).label('document_count')
        ).outerjoin(Document).group_by(Company.id).offset(skip).limit(limit).all()
        
        return result
