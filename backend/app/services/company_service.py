from sqlalchemy.orm import Session
from typing import List
from app.repositories.company_repository import CompanyRepository
from app.schemas.company import CompanyResponse, CompanyWithDocumentCount


class CompanyService:
    def __init__(self, db: Session):
        self.repository = CompanyRepository(db)
    
    def get_all_companies(self, skip: int = 0, limit: int = 100) -> dict:
        """Get all companies with pagination"""
        companies = self.repository.get_all(skip=skip, limit=limit)
        total = self.repository.get_total_count()
        
        return {
            "total": total,
            "skip": skip,
            "limit": limit,
            "data": [CompanyResponse.model_validate(company) for company in companies]
        }
    
    def get_company_by_id(self, company_id: int):
        """Get company by ID"""
        company = self.repository.get_by_id(company_id)
        if not company:
            return None
        return CompanyResponse.model_validate(company)
    
    def get_companies_with_document_count(self, skip: int = 0, limit: int = 100) -> dict:
        """Get companies with their document count"""
        result = self.repository.get_with_document_count(skip=skip, limit=limit)
        total = self.repository.get_total_count()
        
        companies_with_count = []
        for company, doc_count in result:
            company_dict = CompanyResponse.model_validate(company).model_dump()
            company_dict['document_count'] = doc_count
            companies_with_count.append(CompanyWithDocumentCount(**company_dict))
        
        return {
            "total": total,
            "skip": skip,
            "limit": limit,
            "data": companies_with_count
        }
