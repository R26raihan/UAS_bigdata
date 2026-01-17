from sqlalchemy import Column, Integer, BigInteger, String, Numeric, ForeignKey, Text
from sqlalchemy.orm import relationship
from app.core.database import Base


class FinancialSummary(Base):
    __tablename__ = "financial_summaries"
    
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    document_id = Column(BigInteger, ForeignKey("documents.id", ondelete="CASCADE"), index=True)
    revenue = Column(Numeric(20, 2))
    revenue_last_year = Column(Numeric(20, 2))
    expenses = Column(Numeric(20, 2))
    expenses_last_year = Column(Numeric(20, 2))
    net_profit = Column(Numeric(20, 2))
    net_profit_last_year = Column(Numeric(20, 2))
    profit_margin = Column(Numeric(5, 2))
    profit_margin_last_year = Column(Numeric(5, 2))
    
    # Relationship
    document = relationship("Document", backref="financial_summary")


class FinancialBreakdown(Base):
    __tablename__ = "financial_breakdowns"
    
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    document_id = Column(BigInteger, ForeignKey("documents.id", ondelete="CASCADE"), index=True)
    category = Column(String(255), nullable=False)
    amount = Column(Numeric(20, 2))
    previous_amount = Column(Numeric(20, 2))
    percentage = Column(Numeric(5, 2))
    type = Column(String(50))  # Changed from Enum to String
    
    # Relationship
    document = relationship("Document", backref="financial_breakdowns")


class FinancialCashFlow(Base):
    __tablename__ = "financial_cash_flows"
    
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    document_id = Column(BigInteger, ForeignKey("documents.id", ondelete="CASCADE"), index=True)
    operating_cash = Column(Numeric(20, 2))
    investing_cash = Column(Numeric(20, 2))
    financing_cash = Column(Numeric(20, 2))
    beginning_cash = Column(Numeric(20, 2))
    ending_cash = Column(Numeric(20, 2))
    
    # Relationship
    document = relationship("Document", backref="cash_flow")


class FinancialTrend(Base):
    __tablename__ = "financial_trends"
    
    id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    document_id = Column(BigInteger, ForeignKey("documents.id", ondelete="CASCADE"), index=True)
    period_label = Column(String(50))
    revenue = Column(Numeric(20, 2))
    profit = Column(Numeric(20, 2))
    sort_order = Column(Integer)
    
    # Relationship
    document = relationship("Document", backref="financial_trends")
