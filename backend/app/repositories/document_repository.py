from sqlalchemy.orm import Session, joinedload
from typing import List, Optional
from app.models.document import Document
from app.models.company import Company


class DocumentRepository:
    def __init__(self, db: Session):
        self.db = db
    
    def get_all(self, skip: int = 0, limit: int = 100) -> List[Document]:
        """Get all documents with pagination"""
        return self.db.query(Document).offset(skip).limit(limit).all()
    
    def get_by_id(self, document_id: int) -> Optional[Document]:
        """Get document by ID with all relationships loaded"""
        return self.db.query(Document).options(
            joinedload(Document.company)
        ).filter(Document.id == document_id).first()
    
    def get_by_type(self, doc_type: str, skip: int = 0, limit: int = 100) -> List[Document]:
        """Get documents by type"""
        return self.db.query(Document).filter(
            Document.type == doc_type
        ).offset(skip).limit(limit).all()
    
    def get_by_company(self, company_id: int, skip: int = 0, limit: int = 100) -> List[Document]:
        """Get documents by company ID"""
        return self.db.query(Document).filter(
            Document.company_id == company_id
        ).offset(skip).limit(limit).all()
    
    def get_with_company_info(self, skip: int = 0, limit: int = 100):
        """Get documents with company information"""
        return self.db.query(Document).join(Company).offset(skip).limit(limit).all()
    
    def get_total_count(self, doc_type: Optional[str] = None, company_id: Optional[int] = None) -> int:
        """Get total count of documents with optional filters"""
        query = self.db.query(Document)
        
        if doc_type:
            query = query.filter(Document.type == doc_type)
        if company_id:
            query = query.filter(Document.company_id == company_id)
        
        return query.count()

    def create(self, document_data: dict) -> Document:
        """Create a new document"""
        if not document_data.get('document_number'):
            document_data['document_number'] = self.generate_document_number(document_data.get('type', 'GEN'))
            
        db_document = Document(**document_data)
        self.db.add(db_document)
        self.db.commit()
        self.db.refresh(db_document)
        return db_document

    def generate_document_number(self, doc_type: str) -> str:
        """Generate a unique document number"""
        import datetime
        import random
        prefix = doc_type[:3].upper()
        year = datetime.datetime.now().year
        rand = random.randint(1000, 9999)
        return f"{prefix}/{year}/{rand}"
