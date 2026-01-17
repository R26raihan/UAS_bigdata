from sqlalchemy import Column, Integer, BigInteger, String, Numeric, ForeignKey, Date, Text
from sqlalchemy.orm import relationship
from app.core.database import Base


class OperationalKPI(Base):
    __tablename__ = "operational_kpis"
    
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    document_id = Column(BigInteger, ForeignKey("documents.id", ondelete="CASCADE"), index=True)
    productivity_score = Column(Numeric(5, 2))
    efficiency_score = Column(Numeric(5, 2))
    quality_score = Column(Numeric(5, 2))
    on_time_delivery_score = Column(Numeric(5, 2))
    
    # Relationship
    document = relationship("Document", backref="operational_kpi")


class DepartmentPerformance(Base):
    __tablename__ = "department_performance"
    
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    document_id = Column(BigInteger, ForeignKey("documents.id", ondelete="CASCADE"), index=True)
    department_name = Column(String(100))
    target_value = Column(Integer)
    actual_value = Column(Integer)
    achievement_rate = Column(Numeric(5, 2))
    
    # Relationship
    document = relationship("Document", backref="department_performances")


class InventoryStatusModel(Base):
    __tablename__ = "inventory_status"
    
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    document_id = Column(BigInteger, ForeignKey("documents.id", ondelete="CASCADE"), index=True)
    item_name = Column(String(255))
    current_stock = Column(String(100))
    status = Column(String(50))  # Changed from Enum to String
    restock_date = Column(Date)
    
    # Relationship
    document = relationship("Document", backref="inventory_items")


class OperationalRisk(Base):
    __tablename__ = "operational_risks"
    
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    document_id = Column(BigInteger, ForeignKey("documents.id", ondelete="CASCADE"), index=True)
    category = Column(String(100))
    risk_issue = Column(Text)
    impact_level = Column(String(50))
    probability_level = Column(String(50))
    mitigation_plan = Column(Text)
    
    # Relationship
    document = relationship("Document", backref="operational_risks")
