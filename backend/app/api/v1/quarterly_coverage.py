from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import func, extract
from typing import Dict, List, Any
from app.core.database import get_db
from app.models.document import Document
import logging

router = APIRouter()
logger = logging.getLogger(__name__)


@router.get("/companies/{company_id}/quarterly-coverage")
async def get_quarterly_coverage(
    company_id: int,
    db: Session = Depends(get_db)
) -> Dict[str, Any]:
    """
    Check quarterly data coverage for a company from 2023-2025
    
    Returns which quarters have data and which are missing
    """
    # Define years and quarters to check
    years = [2023, 2024, 2025]
    quarters = ['Q1', 'Q2', 'Q3', 'Q4']
    
    # Get all documents for this company with quarterly periods
    documents = db.query(Document).filter(
        Document.company_id == company_id,
        Document.period.like('%Q%')
    ).all()
    
    # Build coverage map
    coverage = {}
    for year in years:
        coverage[str(year)] = {
            'Q1': {'exists': False, 'documents': []},
            'Q2': {'exists': False, 'documents': []},
            'Q3': {'exists': False, 'documents': []},
            'Q4': {'exists': False, 'documents': []}
        }
    
    # Populate coverage data
    for doc in documents:
        period = doc.period
        
        # Extract year and quarter from period
        for year in years:
            year_str = str(year)
            if year_str in period:
                for quarter in quarters:
                    if quarter in period:
                        coverage[year_str][quarter]['exists'] = True
                        coverage[year_str][quarter]['documents'].append({
                            'id': doc.id,
                            'document_number': doc.document_number,
                            'type': doc.type,
                            'title': doc.title,
                            'period': doc.period,
                            'date': doc.date.isoformat() if doc.date else None
                        })
                        break
                break
    
    # Calculate statistics
    total_quarters = len(years) * len(quarters)  # 12 quarters (2023-2025)
    existing_quarters = sum(
        1 for year_data in coverage.values()
        for quarter_data in year_data.values()
        if quarter_data['exists']
    )
    
    missing_quarters = []
    for year, year_data in coverage.items():
        for quarter, quarter_data in year_data.items():
            if not quarter_data['exists']:
                missing_quarters.append(f"{quarter} {year}")
    
    return {
        "company_id": company_id,
        "coverage": coverage,
        "statistics": {
            "total_quarters": total_quarters,
            "existing_quarters": existing_quarters,
            "missing_quarters_count": len(missing_quarters),
            "coverage_percentage": round((existing_quarters / total_quarters) * 100, 2),
            "missing_quarters": missing_quarters
        }
    }


@router.get("/companies/quarterly-coverage/summary")
async def get_all_companies_quarterly_coverage(
    db: Session = Depends(get_db)
) -> List[Dict[str, Any]]:
    """
    Get quarterly coverage summary for all companies
    
    Returns a summary of data completeness for each company
    """
    # Get all companies
    from app.models.company import Company
    companies = db.query(Company).all()
    
    results = []
    years = [2023, 2024, 2025]
    quarters = ['Q1', 'Q2', 'Q3', 'Q4']
    total_quarters = len(years) * len(quarters)
    
    for company in companies:
        # Get quarterly documents for this company
        documents = db.query(Document).filter(
            Document.company_id == company.id,
            Document.period.like('%Q%')
        ).all()
        
        # Count existing quarters
        existing_quarters_set = set()
        for doc in documents:
            period = doc.period
            for year in years:
                year_str = str(year)
                if year_str in period:
                    for quarter in quarters:
                        if quarter in period:
                            existing_quarters_set.add(f"{quarter} {year}")
                            break
                    break
        
        existing_count = len(existing_quarters_set)
        missing_count = total_quarters - existing_count
        
        results.append({
            "company_id": company.id,
            "company_name": company.name,
            "total_quarters": total_quarters,
            "existing_quarters": existing_count,
            "missing_quarters": missing_count,
            "coverage_percentage": round((existing_count / total_quarters) * 100, 2),
            "status": "complete" if existing_count == total_quarters else "incomplete"
        })
    
    return results


@router.get("/companies/{company_id}/quarterly-coverage/by-type")
async def get_quarterly_coverage_by_type(
    company_id: int,
    doc_type: str,
    db: Session = Depends(get_db)
) -> Dict[str, Any]:
    """
    Check quarterly data coverage for a specific document type
    
    Args:
        company_id: Company ID
        doc_type: Document type (financial, operational, management)
    
    Returns coverage data filtered by document type
    """
    years = [2023, 2024, 2025]
    quarters = ['Q1', 'Q2', 'Q3', 'Q4']
    
    # Get quarterly documents for this company and type
    documents = db.query(Document).filter(
        Document.company_id == company_id,
        Document.type == doc_type,
        Document.period.like('%Q%')
    ).all()
    
    # Build coverage map
    coverage = {}
    for year in years:
        coverage[str(year)] = {
            'Q1': {'exists': False, 'document_id': None, 'document_number': None},
            'Q2': {'exists': False, 'document_id': None, 'document_number': None},
            'Q3': {'exists': False, 'document_id': None, 'document_number': None},
            'Q4': {'exists': False, 'document_id': None, 'document_number': None}
        }
    
    # Populate coverage data
    for doc in documents:
        period = doc.period
        
        for year in years:
            year_str = str(year)
            if year_str in period:
                for quarter in quarters:
                    if quarter in period:
                        coverage[year_str][quarter] = {
                            'exists': True,
                            'document_id': doc.id,
                            'document_number': doc.document_number,
                            'title': doc.title,
                            'date': doc.date.isoformat() if doc.date else None
                        }
                        break
                break
    
    # Calculate statistics
    total_quarters = len(years) * len(quarters)
    existing_quarters = sum(
        1 for year_data in coverage.values()
        for quarter_data in year_data.values()
        if quarter_data['exists']
    )
    
    return {
        "company_id": company_id,
        "document_type": doc_type,
        "coverage": coverage,
        "statistics": {
            "total_quarters": total_quarters,
            "existing_quarters": existing_quarters,
            "missing_quarters": total_quarters - existing_quarters,
            "coverage_percentage": round((existing_quarters / total_quarters) * 100, 2)
        }
    }
