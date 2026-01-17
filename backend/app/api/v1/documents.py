from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy.orm import Session
from typing import Optional
from app.core.database import get_db
from app.services.document_service import DocumentService
from app.schemas.document import DocumentResponse, DocumentCreate

router = APIRouter(prefix="/documents", tags=["Documents"])


@router.get("/", response_model=dict)
def get_documents(
    skip: int = Query(0, ge=0, description="Number of records to skip"),
    limit: int = Query(100, ge=1, le=1000, description="Maximum number of records to return"),
    type: Optional[str] = Query(None, description="Filter by document type (financial, operational, management, custom)"),
    db: Session = Depends(get_db)
):
    """
    Get all documents with optional filtering.
    
    - **skip**: Number of records to skip (for pagination)
    - **limit**: Maximum number of records to return
    - **type**: Optional filter by document type
    """
    service = DocumentService(db)
    
    # Validate document type if provided
    if type and type not in ["financial", "operational", "management", "custom"]:
        raise HTTPException(
            status_code=400,
            detail="Invalid document type. Must be one of: financial, operational, management, custom"
        )
    
    return service.get_all_documents(skip=skip, limit=limit, doc_type=type)


@router.post("/", response_model=DocumentResponse)
def create_document(
    document_in: DocumentCreate,
    db: Session = Depends(get_db)
):
    """
    Create a new document.
    
    If it's a financial/operational/management document, the system will
    automatically seed it with data from the company's latest document of the same type.
    """
    service = DocumentService(db)
    return service.create_document(document_in)


@router.get("/{document_id}", response_model=dict)
def get_document(
    document_id: int,
    db: Session = Depends(get_db)
):
    """
    Get a specific document by ID with full details.
    
    For financial documents, includes:
    - Financial summary (revenue, expenses, profit, margins)
    - Financial breakdowns (revenue/expense categories)
    - Cash flow statement
    - Financial trends
    
    - **document_id**: The ID of the document to retrieve
    """
    service = DocumentService(db)
    document = service.get_document_by_id(document_id)
    
    if not document:
        raise HTTPException(status_code=404, detail=f"Document with ID {document_id} not found")
    
    return document


@router.get("/type/{doc_type}", response_model=dict)
def get_documents_by_type(
    doc_type: str,
    skip: int = Query(0, ge=0),
    limit: int = Query(100, ge=1, le=1000),
    db: Session = Depends(get_db)
):
    """
    Get all documents of a specific type.
    
    - **doc_type**: Document type (financial, operational, management, custom)
    - **skip**: Number of records to skip
    - **limit**: Maximum number of records to return
    """
    if doc_type not in ["financial", "operational", "management", "custom"]:
        raise HTTPException(
            status_code=400,
            detail="Invalid document type. Must be one of: financial, operational, management, custom"
        )
    
    service = DocumentService(db)
    return service.get_all_documents(skip=skip, limit=limit, doc_type=doc_type)
