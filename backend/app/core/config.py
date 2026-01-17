from pydantic_settings import BaseSettings
from typing import List


class Settings(BaseSettings):
    # Database
    DATABASE_HOST: str = "localhost"
    DATABASE_PORT: int = 3306
    DATABASE_USER: str = "root"
    DATABASE_PASSWORD: str = ""
    DATABASE_NAME: str = "ai_writer"
    
    # Application
    APP_NAME: str = "AI Writer API"
    APP_VERSION: str = "1.0.0"
    DEBUG: bool = True
    
    # API
    API_V1_PREFIX: str = "/api/v1"
    CORS_ORIGINS: List[str] = [
        "http://localhost:5173", 
        "http://localhost:3000",
        "http://192.168.1.12:5173",
        "http://192.168.1.12:3000"
    ]
    
    # OpenRouter AI
    OPENROUTER_API_KEY: str = ""
    OPENROUTER_BASE_URL: str = "https://openrouter.ai/api/v1"
    
    # AI Models (Fallback Priority - Best Free Models 2024/2025)
    AI_MODEL_1: str = "google/gemini-2.0-flash-exp:free"
    AI_MODEL_2: str = "meta-llama/llama-3.1-8b-instruct:free"
    AI_MODEL_3: str = "qwen/qwen-2.5-7b-instruct:free"
    AI_MODEL_4: str = "mistralai/mistral-7b-instruct-v0.1:free"
    AI_MODEL_5: str = "openrouter/auto-free" # OpenRouter will automatically pick a working free model
    
    # AI Generation Settings
    AI_MAX_TOKENS: int = 500
    AI_TEMPERATURE: float = 0.3
    AI_TIMEOUT: int = 30
    AI_MAX_RETRIES: int = 3
    
    # Caching
    ENABLE_AI_CACHE: bool = True
    CACHE_TTL_HOURS: int = 24
    
    @property
    def DATABASE_URL(self) -> str:
        return f"mysql+pymysql://{self.DATABASE_USER}:{self.DATABASE_PASSWORD}@{self.DATABASE_HOST}:{self.DATABASE_PORT}/{self.DATABASE_NAME}"
    
    @property
    def AI_MODELS(self) -> List[str]:
        """Return list of AI models in fallback order"""
        return [
            self.AI_MODEL_1,
            self.AI_MODEL_2,
            self.AI_MODEL_3,
            self.AI_MODEL_4,
            self.AI_MODEL_5
        ]
    
    class Config:
        env_file = ".env"
        case_sensitive = True


settings = Settings()
