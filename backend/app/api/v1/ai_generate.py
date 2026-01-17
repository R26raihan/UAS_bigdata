from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.core.database import get_db
from app.services.document_service import DocumentService
from app.services.ai_service import ai_service
from typing import Dict
import logging

logger = logging.getLogger(__name__)

router = APIRouter(prefix="/ai", tags=["AI Generation"])


@router.post("/generate/financial/{document_id}")
async def generate_financial_narrative(
    document_id: int,
    db: Session = Depends(get_db)
) -> Dict[str, str]:
    """
    Generate AI narrative for financial document
    
    Uses micro-call approach:
    - Intro (2-3 sentences)
    - Analysis (3-4 sentences)
    - Conclusion (2-3 sentences)
    
    Implements 5-model fallback if rate limited
    """
    # Get document data
    doc_service = DocumentService(db)
    document = doc_service.get_document_by_id(document_id)
    
    if not document:
        raise HTTPException(status_code=404, detail="Document not found")
    
    if document["document"].type != "financial":
        raise HTTPException(status_code=400, detail="Document is not financial type")
    
    # Get financial data
    financial_data = document.get("financial_data")
    if not financial_data:
        raise HTTPException(status_code=404, detail="Financial data not found")
    
    # Convert Pydantic model to dict
    if hasattr(financial_data, 'model_dump'):
        financial_dict = financial_data.model_dump()
    elif hasattr(financial_data, 'dict'):
        financial_dict = financial_data.dict()
    else:
        financial_dict = financial_data
    
    # Generate narrative using AI (micro-call approach)
    try:
        narrative = await ai_service.generate_financial_narrative(financial_dict)
        return narrative
    except Exception as e:
        logger.error(f"AI generation failed: {str(e)}")
        raise HTTPException(status_code=500, detail=f"AI generation failed: {str(e)}")


@router.post("/generate/operational/{document_id}")
async def generate_operational_narrative(
    document_id: int,
    db: Session = Depends(get_db)
) -> Dict[str, str]:
    """Generate AI narrative for operational document"""
    doc_service = DocumentService(db)
    document = doc_service.get_document_by_id(document_id)
    
    if not document:
        raise HTTPException(status_code=404, detail="Document not found")
    
    if document["document"].type != "operational":
        raise HTTPException(status_code=400, detail="Document is not operational type")
    
    # Get operational data
    operational_data = document.get("operational_data")
    if not operational_data:
        # Default structure if not found
        operational_data = {"kpi": {}}
        
    try:
        narrative = await ai_service.generate_operational_narrative(operational_data)
        return narrative
    except Exception as e:
        logger.error(f"AI generation failed: {str(e)}")
        raise HTTPException(status_code=500, detail=f"AI generation failed: {str(e)}")


@router.post("/generate/management/{document_id}")
async def generate_management_narrative(
    document_id: int,
    db: Session = Depends(get_db)
) -> Dict[str, str]:
    """Generate AI narrative for management document"""
    doc_service = DocumentService(db)
    document = doc_service.get_document_by_id(document_id)
    
    if not document:
        raise HTTPException(status_code=404, detail="Document not found")
    
    if document["document"].type != "management":
        raise HTTPException(status_code=400, detail="Document is not management type")
    
    # Get management data
    management_data = document.get("management_data")
    if not management_data:
        # Default empty structure if not found
        management_data = {"strategic_goals": [], "executive_summary": ""}
        
    try:
        narrative = await ai_service.generate_management_narrative(management_data)
        return narrative
    except Exception as e:
        logger.error(f"AI generation failed: {str(e)}")
        raise HTTPException(status_code=500, detail=f"AI generation failed: {str(e)}")


@router.get("/models/status")
async def get_models_status():
    """Get status of available AI models"""
    from app.core.config import settings
    
    return {
        "models": settings.AI_MODELS,
        "fallback_enabled": True,
        "caching_enabled": settings.ENABLE_AI_CACHE,
        "max_tokens": settings.AI_MAX_TOKENS,
        "temperature": settings.AI_TEMPERATURE
    }
