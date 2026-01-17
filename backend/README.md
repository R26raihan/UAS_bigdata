# AI Writer API - FastAPI Backend

Backend API untuk sistem AI-powered document generation dengan Clean Architecture.

## 🚀 Quick Start

### 1. Setup Environment

```bash
# Copy environment template
cp .env.example .env

# Edit .env dengan konfigurasi database Anda
nano .env
```

### 2. Install Dependencies

```bash
# Create virtual environment (recommended)
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

### 3. Setup Database

Pastikan database MySQL `ai_writer` sudah dibuat dan tabel sudah di-import:

```bash
# Login ke MySQL
mysql -u root -p

# Create database
CREATE DATABASE ai_writer;

# Import schema
mysql -u root -p ai_writer < ../data/schema.sql

# Import seed data (pilih salah satu atau semua)
mysql -u root -p ai_writer < ../data/seeds.sql
mysql -u root -p ai_writer < ../data/seedsv2.sql
mysql -u root -p ai_writer < ../data/seedsv3.sql
```

### 4. Run Server

```bash
# Development mode with auto-reload
uvicorn app.main:app --reload

# Production mode
uvicorn app.main:app --host 0.0.0.0 --port 8000
```

Server akan berjalan di: **http://localhost:8000**

## 📚 API Documentation

Setelah server running, akses dokumentasi interaktif:

- **Swagger UI**: http://localhost:8000/docs
- **ReDoc**: http://localhost:8000/redoc

## 🏗️ Architecture

Project ini menggunakan **Clean Architecture** dengan layer separation:

```
backend/
├── app/
│   ├── core/           # Configuration & Database
│   ├── models/         # SQLAlchemy ORM Models
│   ├── schemas/        # Pydantic Schemas (DTOs)
│   ├── repositories/   # Data Access Layer
│   ├── services/       # Business Logic Layer
│   ├── api/            # API Routes/Controllers
│   └── main.py         # FastAPI App Entry Point
├── requirements.txt
├── .env.example
└── README.md
```

### Layer Responsibilities:

- **Core**: Database connection, configuration, dependencies
- **Models**: SQLAlchemy ORM models (database tables)
- **Schemas**: Pydantic models for request/response validation
- **Repositories**: Data access patterns (queries)
- **Services**: Business logic and data transformation
- **API**: FastAPI routes and endpoints

## 🔌 API Endpoints

### Companies

- `GET /api/v1/companies` - List all companies
  - Query params: `skip`, `limit`, `with_count`
- `GET /api/v1/companies/{id}` - Get company by ID
- `GET /api/v1/companies/{id}/documents` - Get company's documents

### Documents

- `GET /api/v1/documents` - List all documents
  - Query params: `skip`, `limit`, `type`
- `GET /api/v1/documents/{id}` - Get document with full data
- `GET /api/v1/documents/type/{type}` - Filter by type
  - Types: `financial`, `operational`, `management`, `custom`

## 🔧 Configuration

Edit `.env` file:

```env
# Database
DATABASE_HOST=localhost
DATABASE_PORT=3306
DATABASE_USER=root
DATABASE_PASSWORD=your_password
DATABASE_NAME=ai_writer

# Application
APP_NAME="AI Writer API"
DEBUG=True

# CORS (untuk Vue.js frontend)
CORS_ORIGINS=["http://localhost:5173","http://localhost:3000"]
```

## 📊 Database Schema

Database `ai_writer` memiliki tabel:

**Core Tables:**
- `companies` - Company information
- `documents` - Document headers

**Financial Tables:**
- `financial_summaries`
- `financial_breakdowns`
- `financial_cash_flows`
- `financial_trends`

**Operational Tables:**
- `operational_kpis`
- `department_performance`
- `inventory_status`
- `operational_risks`

**Management Tables:**
- `management_summaries`
- `strategic_goals`
- `swot_analysis`
- `stakeholders`

## 🧪 Testing API

### Using cURL:

```bash
# Get all companies
curl http://localhost:8000/api/v1/companies

# Get company by ID
curl http://localhost:8000/api/v1/companies/1

# Get documents with filter
curl "http://localhost:8000/api/v1/documents?type=financial&limit=10"

# Get document detail
curl http://localhost:8000/api/v1/documents/1
```

### Using Python:

```python
import requests

# Get companies
response = requests.get("http://localhost:8000/api/v1/companies")
companies = response.json()

# Get financial documents
response = requests.get(
    "http://localhost:8000/api/v1/documents",
    params={"type": "financial", "limit": 5}
)
documents = response.json()
```

## 🛠️ Development

### Project Structure Details:

```
app/
├── core/
│   ├── config.py       # Settings & environment variables
│   └── database.py     # SQLAlchemy setup & session
├── models/
│   ├── company.py      # Company model
│   ├── document.py     # Document model
│   ├── financial.py    # Financial models
│   ├── operational.py  # Operational models
│   └── management.py   # Management models
├── schemas/
│   ├── company.py      # Company DTOs
│   ├── document.py     # Document DTOs
│   └── financial.py    # Financial DTOs
├── repositories/
│   ├── company_repository.py
│   ├── document_repository.py
│   └── financial_repository.py
├── services/
│   ├── company_service.py
│   └── document_service.py
└── api/v1/
    ├── companies.py    # Company endpoints
    └── documents.py    # Document endpoints
```

## 📝 Notes

- Semua endpoint menggunakan pagination (default: limit=100)
- Response format konsisten dengan `total`, `skip`, `limit`, `data`
- Error handling dengan HTTP status codes standar
- CORS sudah dikonfigurasi untuk frontend development

## 🔗 Integration dengan Frontend

Frontend Vue.js dapat mengakses API dengan:

```javascript
// Example: Fetch companies
const response = await fetch('http://localhost:8000/api/v1/companies');
const data = await response.json();
console.log(data.data); // Array of companies
```

## 📄 License

Internal project for AI Writer system.
