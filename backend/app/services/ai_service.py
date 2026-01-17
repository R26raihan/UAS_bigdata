"""
AI Service for document generation
Implements micro-call approach: intro + analysis + conclusion
"""
from typing import Dict, Any
from app.core.ai_client import ai_client
import logging

logger = logging.getLogger(__name__)


class AIService:
    """
    AI Service for generating document narratives
    Follows aturan.txt principles:
    - Micro-call per section (not one big call)
    - AI only for language, not calculations
    - Token-efficient data summaries
    """
    
    async def generate_financial_narrative(self, financial_data: Dict[str, Any]) -> Dict[str, str]:
        """
        Generate narrative sections for financial document
        
        Args:
            financial_data: Financial metrics (summary only, not raw data)
        
        Returns:
            Dict with 'intro', 'analysis', 'conclusion' keys
        """
        # Condense data to key metrics only (token-efficient)
        data_summary = self._condense_financial_data(financial_data)
        
        # Micro-call approach: 3 separate AI calls
        intro = await ai_client.generate_section("intro", data_summary, "financial")
        analysis = await ai_client.generate_section("analysis", data_summary, "financial")
        conclusion = await ai_client.generate_section("conclusion", data_summary, "financial")
        
        return {
            "intro": intro,
            "analysis": analysis,
            "conclusion": conclusion
        }
    
    async def generate_operational_narrative(self, operational_data: Dict[str, Any]) -> Dict[str, str]:
        """Generate narrative for operational document"""
        data_summary = self._condense_operational_data(operational_data)
        
        # Core narrative
        intro = await ai_client.generate_section("intro", data_summary, "operational")
        analysis = await ai_client.generate_section("analysis", data_summary, "operational")
        conclusion = await ai_client.generate_section("conclusion", data_summary, "operational")
        
        # Detailed insights (micro-calls)
        achievements = await ai_client.generate_section("achievements", data_summary, "operational")
        issues = await ai_client.generate_section("issues", data_summary, "operational")
        recommendations = await ai_client.generate_section("recommendations", data_summary, "operational")
        
        return {
            "intro": intro,
            "analysis": analysis,
            "conclusion": conclusion,
            "achievements": achievements,
            "issues": issues,
            "recommendations": recommendations
        }
    
    async def generate_management_narrative(self, management_data: Dict[str, Any]) -> Dict[str, str]:
        """Generate narrative for management document"""
        data_summary = self._condense_management_data(management_data)
        
        # Core narrative
        intro = await ai_client.generate_section("intro", data_summary, "management")
        analysis = await ai_client.generate_section("analysis", data_summary, "management")
        conclusion = await ai_client.generate_section("conclusion", data_summary, "management")
        
        # Detailed insights (micro-calls)
        achievements = await ai_client.generate_section("achievements", data_summary, "management")
        challenges = await ai_client.generate_section("challenges", data_summary, "management")
        next_steps = await ai_client.generate_section("next_steps", data_summary, "management")
        
        return {
            "intro": intro,
            "analysis": analysis,
            "conclusion": conclusion,
            "achievements": achievements,
            "challenges": challenges,
            "next_steps": next_steps
        }
    
    def _condense_financial_data(self, data: Dict[str, Any]) -> Dict[str, Any]:
        """
        Condense financial data to key metrics only
        NOT full JSON - only what AI needs for narration
        """
        from decimal import Decimal
        
        summary = data.get("summary", {})
        
        # Helper to convert Decimal to float
        def to_float(val):
            if isinstance(val, Decimal):
                return float(val)
            return val if val is not None else 0
        
        revenue = to_float(summary.get("revenue"))
        revenue_last = to_float(summary.get("revenue_last_year"))
        
        # Get top 3 revenue categories
        breakdowns = data.get("breakdowns", [])
        top_revenue = [b for b in breakdowns if b.get("type") == "revenue"]
        top_revenue.sort(key=lambda x: to_float(x.get("amount")), reverse=True)
        revenue_details = ", ".join([f"{b.get('category')}: {to_float(b.get('amount')):,}" for b in top_revenue[:3]])
        
        # Get top 3 expense categories
        top_expenses = [b for b in breakdowns if b.get("type") == "expense"]
        top_expenses.sort(key=lambda x: to_float(x.get("amount")), reverse=True)
        expense_details = ", ".join([f"{b.get('category')}: {to_float(b.get('amount')):,}" for b in top_expenses[:3]])
        
        return {
            "Current Revenue": f"Rp {revenue:,}",
            "Revenue Growth": f"{self._calculate_growth(revenue, revenue_last)}% YoY",
            "Top Revenue Sources": revenue_details or "Data tidak tersedia",
            "Net Profit": f"Rp {to_float(summary.get('net_profit')):,}",
            "Profit Margin": f"{to_float(summary.get('profit_margin'))}%",
            "Total Expenses": f"Rp {to_float(summary.get('expenses')):,}",
            "Major Expense Categories": expense_details or "Data tidak tersedia"
        }
    
    def _condense_operational_data(self, data: Dict[str, Any]) -> Dict[str, Any]:
        """Condense operational data for AI analysis"""
        kpi = data.get("kpi", {})
        return {
            "Produktivitas": f"{kpi.get('productivity_score', 0)}%",
            "Efisiensi": f"{kpi.get('efficiency_score', 0)}%",
            "Kualitas": f"{kpi.get('quality_score', 0)}%",
            "Ketepatan Waktu": f"{kpi.get('on_time_delivery_score', 0)}%",
            "Daftar Pencapaian": ", ".join(data.get("achievements", [])),
            "Daftar Masalah": ", ".join(data.get("issues", [])),
            "Daftar Rekomendasi": ", ".join(data.get("recommendations", []))
        }
    
    def _condense_management_data(self, data: Dict[str, Any]) -> Dict[str, Any]:
        """Condense management data for AI analysis"""
        goals = data.get("strategic_goals", [])
        goals_summary = [f"{g.get('goal')} ({g.get('progress')}%)" for g in goals[:3]]
        
        return {
            "Tujuan Strategis": goals_summary,
            "Total Target": len(goals),
            "Ringkasan Eksekutif": data.get("executive_summary", "")[:1000],
            "Daftar Pencapaian": ", ".join(data.get("achievements", [])),
            "Daftar Tantangan": ", ".join(data.get("challenges", [])),
            "Rencana Langkah": ", ".join(data.get("next_steps", []))
        }
    
    def _calculate_growth(self, current: float, previous: float) -> float:
        """Calculate growth percentage"""
        if not current or not previous or previous == 0:
            return 0.0
        
        # Convert to float if Decimal
        from decimal import Decimal
        if isinstance(current, Decimal):
            current = float(current)
        if isinstance(previous, Decimal):
            previous = float(previous)
            
        return round(((current - previous) / previous) * 100, 1)


# Singleton instance
ai_service = AIService()
