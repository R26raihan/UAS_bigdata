from pydantic import BaseModel, ConfigDict
from typing import Optional, List
from decimal import Decimal


class FinancialSummaryResponse(BaseModel):
    id: int
    document_id: int
    revenue: Optional[Decimal] = None
    revenue_last_year: Optional[Decimal] = None
    expenses: Optional[Decimal] = None
    expenses_last_year: Optional[Decimal] = None
    net_profit: Optional[Decimal] = None
    net_profit_last_year: Optional[Decimal] = None
    profit_margin: Optional[Decimal] = None
    profit_margin_last_year: Optional[Decimal] = None
    
    model_config = ConfigDict(from_attributes=True)


class FinancialBreakdownResponse(BaseModel):
    id: int
    document_id: int
    category: str
    amount: Optional[Decimal] = None
    previous_amount: Optional[Decimal] = None
    percentage: Optional[Decimal] = None
    type: Optional[str] = None
    
    model_config = ConfigDict(from_attributes=True)


class FinancialCashFlowResponse(BaseModel):
    id: int
    document_id: int
    operating_cash: Optional[Decimal] = None
    investing_cash: Optional[Decimal] = None
    financing_cash: Optional[Decimal] = None
    beginning_cash: Optional[Decimal] = None
    ending_cash: Optional[Decimal] = None
    
    model_config = ConfigDict(from_attributes=True)


class FinancialTrendResponse(BaseModel):
    id: int
    document_id: int
    period_label: Optional[str] = None
    revenue: Optional[Decimal] = None
    profit: Optional[Decimal] = None
    sort_order: Optional[int] = None
    
    model_config = ConfigDict(from_attributes=True)


class FinancialDocumentDetail(BaseModel):
    summary: Optional[FinancialSummaryResponse] = None
    breakdowns: List[FinancialBreakdownResponse] = []
    cash_flow: Optional[FinancialCashFlowResponse] = None
    trends: List[FinancialTrendResponse] = []
