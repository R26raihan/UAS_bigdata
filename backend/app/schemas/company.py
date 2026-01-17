from pydantic import BaseModel, ConfigDict
from datetime import datetime
from typing import Optional


class CompanyBase(BaseModel):
    name: str
    address: Optional[str] = None
    phone: Optional[str] = None
    email: Optional[str] = None
    logo_url: Optional[str] = None


class CompanyResponse(CompanyBase):
    id: int
    created_at: datetime
    
    model_config = ConfigDict(from_attributes=True)


class CompanyWithDocumentCount(CompanyResponse):
    document_count: int = 0
