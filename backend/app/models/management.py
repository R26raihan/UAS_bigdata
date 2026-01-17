from sqlalchemy import Column, Integer, BigInteger, String, Text, ForeignKey, Date, JSON
from sqlalchemy.orm import relationship
from app.core.database import Base


class ManagementSummary(Base):
    __tablename__ = "management_summaries"
    
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    document_id = Column(BigInteger, ForeignKey("documents.id", ondelete="CASCADE"), index=True)
    executive_summary = Column(Text)
    challenges = Column(JSON)  # Array of strings stored as JSON
    next_steps = Column(JSON)  # Array of strings stored as JSON
    achievements = Column(JSON)  # Array of strings stored as JSON
    
    # Relationship
    document = relationship("Document", backref="management_summary")


class StrategicGoal(Base):
    __tablename__ = "strategic_goals"
    
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    document_id = Column(BigInteger, ForeignKey("documents.id", ondelete="CASCADE"), index=True)
    goal_name = Column(String(255))
    progress_percentage = Column(Integer)
    status = Column(String(50))  # On Track, At Risk, Ahead
    deadline = Column(Date)
    
    # Relationship
    document = relationship("Document", backref="strategic_goals")


class SWOTAnalysis(Base):
    __tablename__ = "swot_analysis"
    
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    document_id = Column(BigInteger, ForeignKey("documents.id", ondelete="CASCADE"), index=True)
    analysis_type = Column(String(50))  # Changed from Enum to String
    content = Column(Text)
    
    # Relationship
    document = relationship("Document", backref="swot_items")


class Stakeholder(Base):
    __tablename__ = "stakeholders"
    
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    document_id = Column(BigInteger, ForeignKey("documents.id", ondelete="CASCADE"), index=True)
    name = Column(String(100))
    role = Column(String(100))
    involvement_level = Column(String(100))
    
    # Relationship
    document = relationship("Document", backref="stakeholders")
