from pydantic import BaseModel, ConfigDict, Field
from datetime import datetime, date
from typing import Optional, Union, Any


class DocumentBase(BaseModel):
    company_id: int
    type: str
    title: str
    period: Optional[str] = None
    date: Any = None
    notes: Optional[str] = None

class DocumentCreate(DocumentBase):
    pass


class DocumentResponse(DocumentBase):
    id: int
    created_at: datetime
    
    model_config = ConfigDict(from_attributes=True, arbitrary_types_allowed=True)


class DocumentListResponse(BaseModel):
    id: int
    company_id: int
    document_number: str
    type: str  # Changed from Enum to str
    title: str
    period: Optional[str] = None
    date: Any = None  # Use Any to bypass strict validation
    created_at: datetime
    company_name: Optional[str] = None
    
    model_config = ConfigDict(from_attributes=True, arbitrary_types_allowed=True)

