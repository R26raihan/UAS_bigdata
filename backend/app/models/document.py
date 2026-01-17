from sqlalchemy import Column, Integer, BigInteger, String, Date, Text, TIMESTAMP, ForeignKey
from sqlalchemy.sql import func
from sqlalchemy.orm import relationship
from app.core.database import Base


class Document(Base):
    __tablename__ = "documents"
    
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    company_id = Column(BigInteger, ForeignKey("companies.id"), index=True)
    document_number = Column(String(50), unique=True)
    type = Column(String(50), nullable=False, index=True)  # Changed from Enum to String
    title = Column(String(255), nullable=False)
    period = Column(String(100))
    date = Column(Date)
    notes = Column(Text)
    created_at = Column(TIMESTAMP, server_default=func.current_timestamp())
    
    # Relationships
    company = relationship("Company", backref="documents")
