from fastapi import APIRouter
from app.api.v1 import companies, documents, ai_generate, quarterly_coverage

api_router = APIRouter()

# Include all v1 routers
api_router.include_router(companies.router)
api_router.include_router(documents.router)
api_router.include_router(ai_generate.router)
api_router.include_router(quarterly_coverage.router)
