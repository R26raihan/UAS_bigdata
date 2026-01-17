"""
AI Client for OpenRouter with fallback mechanism
Implements token-efficient micro-call approach as per aturan.txt
"""
import httpx
import json
import hashlib
from typing import Optional, Dict, Any, List
from app.core.config import settings
import logging

logger = logging.getLogger(__name__)

# Simple in-memory cache (production should use Redis)
_cache: Dict[str, str] = {}


class AIClient:
    """
    OpenRouter AI Client with 5-model fallback mechanism
    Follows aturan.txt principles:
    - AI only for narration, not calculation
    - Micro-call approach (per-section)
    - Token-efficient prompts
    - Caching enabled
    """
    
    def __init__(self):
        self.api_key = settings.OPENROUTER_API_KEY
        self.base_url = settings.OPENROUTER_BASE_URL
        self.models = settings.AI_MODELS
        self.max_tokens = settings.AI_MAX_TOKENS
        self.temperature = settings.AI_TEMPERATURE
        self.timeout = settings.AI_TIMEOUT
        self.max_retries = settings.AI_MAX_RETRIES
    
    def _generate_cache_key(self, prompt: str, section_type: str) -> str:
        """Generate cache key from prompt and section type"""
        content = f"{section_type}:{prompt}"
        return hashlib.md5(content.encode()).hexdigest()
    
    def _get_from_cache(self, cache_key: str) -> Optional[str]:
        """Get cached result if available"""
        if not settings.ENABLE_AI_CACHE:
            return None
        return _cache.get(cache_key)
    
    def _save_to_cache(self, cache_key: str, content: str):
        """Save result to cache"""
        if settings.ENABLE_AI_CACHE:
            _cache[cache_key] = content
    
    async def _call_model(
        self,
        model: str,
        system_prompt: str,
        user_prompt: str
    ) -> Optional[str]:
        """Call a specific model via OpenRouter API"""
        try:
            async with httpx.AsyncClient(timeout=self.timeout) as client:
                response = await client.post(
                    f"{self.base_url}/chat/completions",
                    headers={
                        "Authorization": f"Bearer {self.api_key}",
                        "Content-Type": "application/json",
                    },
                    json={
                        "model": model,
                        "messages": [
                            {"role": "system", "content": system_prompt},
                            {"role": "user", "content": user_prompt}
                        ],
                        "max_tokens": self.max_tokens,
                        "temperature": self.temperature,
                    }
                )
                
                if response.status_code == 200:
                    data = response.json()
                    content = data["choices"][0]["message"]["content"]
                    logger.info(f"✅ Model {model} succeeded")
                    return content
                elif response.status_code == 429:
                    logger.warning(f"⚠️ Model {model} rate limited")
                    return None
                else:
                    logger.error(f"❌ Model {model} failed: {response.status_code}")
                    return None
                    
        except Exception as e:
            logger.error(f"❌ Model {model} error: {str(e)}")
            return None
    
    async def generate_section(
        self,
        section_type: str,
        data_summary: Dict[str, Any],
        document_type: str
    ) -> str:
        """
        Generate a document section using micro-call approach
        
        Args:
            section_type: 'intro', 'analysis', or 'conclusion'
            data_summary: Condensed data (NOT raw JSON)
            document_type: 'financial', 'operational', or 'management'
        
        Returns:
            Generated text content
        """
        # Check cache first
        prompt_str = json.dumps(data_summary, sort_keys=True)
        cache_key = self._generate_cache_key(prompt_str, f"{document_type}_{section_type}")
        
        cached = self._get_from_cache(cache_key)
        if cached:
            logger.info(f"📦 Cache hit for {document_type} {section_type}")
            return cached
        
        # Prepare prompts (token-efficient)
        system_prompt = self._get_system_prompt(document_type, section_type)
        user_prompt = self._build_user_prompt(data_summary, section_type)
        
        # Try models in fallback order
        for attempt, model in enumerate(self.models, 1):
            logger.info(f"🤖 [Percobaan {attempt}/{len(self.models)}] Menghubungi model: {model}...")
            
            result = await self._call_model(model, system_prompt, user_prompt)
            
            if result:
                logger.info(f"✨ Berhasil mendapatkan narasi dari model: {model}")
                # Save to cache
                self._save_to_cache(cache_key, result)
                return result
            
            # If not last model, continue to next
            if attempt < len(self.models):
                logger.warning(f"⚠️ Model {model} gagal/limit. Beralih ke model cadangan berikutnya...")
            else:
                logger.error("❌ Semua model AI percobaan gagal atau terkena limit.")
        return self._get_fallback_content(section_type, document_type)
    
    def _get_system_prompt(self, document_type: str, section_type: str) -> str:
        """
        Get system prompt (static, minimal)
        Professional and directive - no examples or meta-commentary
        """
        prompts = {
            "financial": {
                "intro": """Anda adalah Financial Report Writer profesional untuk perusahaan Indonesia. 
Tulis pendahuluan laporan keuangan yang langsung membahas performa perusahaan.
ATURAN KETAT:
- Langsung ke inti, tanpa kata "berikut", "contoh", atau "berdasarkan data"
- Gunakan bahasa formal dan objektif
- Fokus pada fakta dan angka
- Maksimal 3 kalimat
- Gunakan format: "Perusahaan mencatat..." atau "Kinerja keuangan menunjukkan..."
""",
                "analysis": """Anda adalah Financial Analyst profesional.
Tulis analisis keuangan yang tajam dan faktual.
ATURAN KETAT:
- Langsung analisis, tanpa pembukaan atau penjelasan
- Bandingkan angka dengan periode sebelumnya
- Identifikasi tren positif atau negatif
- Maksimal 4 kalimat
- Gunakan istilah keuangan yang tepat (margin, growth, efficiency)
""",
                "conclusion": """Anda adalah Financial Report Writer profesional.
Tulis kesimpulan yang ringkas dan actionable.
ATURAN KETAT:
- Langsung ke kesimpulan, tanpa kata "secara keseluruhan" atau "dengan demikian"
- Ringkas pencapaian utama
- Maksimal 3 kalimat
- Gunakan format: "Perusahaan berhasil..." atau "Hasil periode ini..."
"""
            },
            "operational": {
                "intro": """Anda adalah Operational Report Writer profesional.
Tulis pendahuluan laporan operasional yang langsung membahas kinerja.
ATURAN KETAT:
- Langsung ke inti, tanpa kata "berikut", "contoh", atau "berdasarkan data"
- Fokus pada KPI dan metrik operasional
- Bahasa formal dan objektif
- Maksimal 3 kalimat
- Gunakan format: "Operasi perusahaan pada..." atau "Efisiensi produksi menunjukkan..."
""",
                "analysis": """Anda adalah Operations Analyst profesional.
Tulis analisis operasional yang data-driven.
ATURAN KETAT:
- Langsung analisis performa, tanpa kata "berikut", "contoh", atau "berdasarkan data"
- Bandingkan dengan target
- Identifikasi area kuat dan lemah
- Maksimal 4 kalimat
""",
                "conclusion": """Anda adalah Operational Report Writer profesional.
Tulis kesimpulan operasional yang actionable.
ATURAN KETAT:
- Langsung ke kesimpulan tanpa filler words atau kata "contoh"
- Ringkas pencapaian operasional
- Maksimal 3 kalimat
""",
                "achievements": """Anda adalah Senior Operations Manager.
Tulis pencapaian operasional yang prestisius berdasarkan data.
ATURAN KETAT:
- Langsung ke poin, tanpa kata "berikut", "contoh", atau "berdasarkan data"
- Gunakan bullet points ( - )
- Maksimal 3 poin pencapaian
- Bahasa formal dan faktual
""",
                "issues": """Anda adalah Operations Risk Specialist.
Tulis analisis tantangan/isu operasional yang kritis dan objektif.
ATURAN KETAT:
- Langsung ke poin, tanpa kata "berikut", "contoh", atau "berdasarkan data"
- Gunakan bullet points ( - )
- Fokus pada masalah yang menghambat produktivitas
- Maksimal 3 poin isu
""",
                "recommendations": """Anda adalah Management Consultant Strategis.
Tulis saran perbaikan operasional yang konkret dan berdampak tinggi.
ATURAN KETAT:
- Langsung ke poin, tanpa kata "berikut", "contoh", atau "berdasarkan data"
- Gunakan bullet points ( - )
- Rekomendasi harus actionable
- Maksimal 3 poin saran
"""
            },
            "management": {
                "intro": """Anda adalah Management Report Writer profesional.
Tulis pendahuluan laporan manajemen yang strategis.
ATURAN KETAT:
- Langsung ke inti, tanpa kata "berikut", "contoh", atau "berdasarkan data"
- Fokus pada pencapaian strategis
- Bahasa eksekutif dan objektif
- Maksimal 3 kalimat
- Gunakan format: "Manajemen melaporkan..." atau "Arah strategis perusahaan..."
""",
                "analysis": """Anda adalah Strategic Analyst profesional.
Tulis analisis strategis yang tajam.
ATURAN KETAT:
- Langsung analisis, tanpa kata "berikut", "contoh", atau "berdasarkan data"
- Identifikasi risiko dan peluang
- Maksimal 4 kalimat
""",
                "conclusion": """Anda adalah Management Report Writer profesional.
Tulis kesimpulan strategis yang forward-looking.
ATURAN KETAT:
- Langsung ke kesimpulan tanpa filler words atau kata "contoh"
- Ringkas arah strategis
- Maksimal 3 kalimat
""",
                "achievements": """Anda adalah Chief Strategy Officer.
Tulis pencapaian strategis yang krusial.
ATURAN KETAT:
- Langsung ke poin, tanpa kata "berikut", "contoh", atau "berdasarkan data"
- Gunakan bullet points ( - )
- Fokus pada visi perusahaan
- Maksimal 3 poin utama
""",
                "challenges": """Anda adalah Risk Management Director.
Tulis hambatan strategis dan tantangan pasar yang nyata.
ATURAN KETAT:
- Langsung ke poin, tanpa kata "berikut", "contoh", atau "berdasarkan data"
- Gunakan bullet points ( - )
- Analisis hambatan internal/eksternal yang signifikan
- Maksimal 3 poin tantangan
""",
                "next_steps": """Anda adalah CEO / Chief Strategist.
Tulis langkah strategis berikutnya secara konkret.
ATURAN KETAT:
- Langsung ke poin, tanpa kata "berikut", "contoh", atau "berdasarkan data"
- Gunakan bullet points ( - )
- Langkah harus actionable dan berwawasan masa depan
- Maksimal 3 poin langkah
"""
            }
        }
        return prompts.get(document_type, {}).get(section_type, "Tulis teks profesional dan ringkas.")
    
    def _build_user_prompt(self, data_summary: Dict[str, Any], section_type: str) -> str:
        """
        Build user prompt (condensed data only)
        Direct and factual - no meta instructions
        """
        # Convert data summary to concise text
        lines = []
        for key, value in data_summary.items():
            if isinstance(value, (int, float)):
                lines.append(f"{key}: {value:,.0f}" if isinstance(value, (int, float)) else f"{key}: {value}")
            else:
                lines.append(f"{key}: {value}")
        
        data_text = "\n".join(lines)
        
        # Custom instructions per section type
        instructions = {
            "intro": "Tulis pendahuluan laporan.",
            "analysis": "Tulis analisis performa.",
            "conclusion": "Tulis kesimpulan laporan.",
            "achievements": "Tulis poin-poin pencapaian utama.",
            "issues": "Tulis poin-poin tantangan operasional.",
            "recommendations": "Tulis poin-poin saran perbaikan.",
            "challenges": "Tulis poin-poin tantangan strategis.",
            "next_steps": "Tulis poin-poin langkah berikutnya."
        }
        
        instruction = instructions.get(section_type, "Tulis analisis berdasarkan data.")
        
        # Guard against empty data
        is_empty = True
        for key in data_summary:
            if data_summary[key] and str(data_summary[key]).strip():
                is_empty = False
                break
        
        if is_empty:
            return "TIDAK ADA DATA TERSEDIA. JANGAN MENULIS APAPUN ATAU MEMBERIKAN CONTOH. Cukup balas: 'Data tidak tersedia untuk periode ini.'"

        return f"Berikut adalah data untuk analisis:\n{data_text}\n\n{instruction}\nPETUNJUK: Gunakan HANYA data di atas. Jangan memberikan contoh umum atau teks placeholder."
    
    def _get_fallback_content(self, section_type: str, document_type: str) -> str:
        """
        Fallback content if all AI models fail
        Returns professional template text
        """
        fallbacks = {
            "intro": f"Laporan {document_type} ini menyajikan ringkasan kinerja periode berjalan berdasarkan data yang telah divalidasi.",
            "analysis": "Berdasarkan data yang tersedia, kinerja menunjukkan tren yang konsisten dengan target yang telah ditetapkan.",
            "conclusion": "Secara keseluruhan, hasil periode ini mencerminkan pelaksanaan strategi yang telah direncanakan."
        }
        return fallbacks.get(section_type, "Konten tidak tersedia.")


# Singleton instance
ai_client = AIClient()
