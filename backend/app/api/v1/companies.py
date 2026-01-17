from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy.orm import Session
from typing import Optional
from app.core.database import get_db
from app.services.company_service import CompanyService
from app.schemas.company import CompanyResponse, CompanyWithDocumentCount

router = APIRouter(prefix="/companies", tags=["Companies"])


@router.get("/", response_model=dict)
def get_companies(
    skip: int = Query(0, ge=0, description="Number of records to skip"),
    limit: int = Query(100, ge=1, le=1000, description="Maximum number of records to return"),
    with_count: bool = Query(False, description="Include document count for each company"),
    db: Session = Depends(get_db)
):
    """
    Get all companies with pagination.
    
    - **skip**: Number of records to skip (for pagination)
    - **limit**: Maximum number of records to return
    - **with_count**: If true, include document count for each company
    """
    service = CompanyService(db)
    
    if with_count:
        return service.get_companies_with_document_count(skip=skip, limit=limit)
    else:
        return service.get_all_companies(skip=skip, limit=limit)


@router.get("/{company_id}", response_model=CompanyResponse)
def get_company(
    company_id: int,
    db: Session = Depends(get_db)
):
    """
    Get a specific company by ID.
    
    - **company_id**: The ID of the company to retrieve
    """
    service = CompanyService(db)
    company = service.get_company_by_id(company_id)
    
    if not company:
        raise HTTPException(status_code=404, detail=f"Company with ID {company_id} not found")
    
    return company


@router.get("/{company_id}/documents", response_model=dict)
def get_company_documents(
    company_id: int,
    skip: int = Query(0, ge=0),
    limit: int = Query(100, ge=1, le=1000),
    db: Session = Depends(get_db)
):
    """
    Get all documents for a specific company.
    
    - **company_id**: The ID of the company
    - **skip**: Number of records to skip
    - **limit**: Maximum number of records to return
    """
    # First check if company exists
    company_service = CompanyService(db)
    company = company_service.get_company_by_id(company_id)
    if not company:
        raise HTTPException(status_code=404, detail=f"Company with ID {company_id} not found")
    
    # Get documents
    from app.services.document_service import DocumentService
    service = DocumentService(db)
    return service.get_documents_by_company(company_id, skip=skip, limit=limit)
