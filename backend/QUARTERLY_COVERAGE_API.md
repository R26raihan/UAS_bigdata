# Quarterly Coverage API - Usage Guide

## Overview
API endpoints untuk mengecek kelengkapan data quarterly (Q1-Q4) per PT dari tahun 2023-2025.

## Endpoints

### 1. Get Quarterly Coverage for Specific Company
**Endpoint:** `GET /api/v1/companies/{company_id}/quarterly-coverage`

**Description:** Cek kelengkapan data quarterly untuk satu PT tertentu

**Example Request:**
```bash
curl http://localhost:8001/api/v1/companies/1/quarterly-coverage
```

**Example Response:**
```json
{
  "company_id": 1,
  "coverage": {
    "2023": {
      "Q1": {
        "exists": true,
        "documents": [
          {
            "id": 4,
            "document_number": "FIN/2023/0004",
            "type": "financial",
            "title": "Laporan Keuangan Q1 2023",
            "period": "Q1 2023",
            "date": "2023-03-31"
          }
        ]
      },
      "Q2": {
        "exists": true,
        "documents": [...]
      },
      "Q3": {
        "exists": false,
        "documents": []
      },
      "Q4": {
        "exists": false,
        "documents": []
      }
    },
    "2024": {
      "Q1": {"exists": false, "documents": []},
      "Q2": {"exists": false, "documents": []},
      "Q3": {"exists": false, "documents": []},
      "Q4": {"exists": false, "documents": []}
    },
    "2025": {
      "Q1": {"exists": false, "documents": []},
      "Q2": {"exists": false, "documents": []},
      "Q3": {"exists": false, "documents": []},
      "Q4": {"exists": false, "documents": []}
    }
  },
  "statistics": {
    "total_quarters": 12,
    "existing_quarters": 2,
    "missing_quarters_count": 10,
    "coverage_percentage": 16.67,
    "missing_quarters": [
      "Q3 2023", "Q4 2023",
      "Q1 2024", "Q2 2024", "Q3 2024", "Q4 2024",
      "Q1 2025", "Q2 2025", "Q3 2025", "Q4 2025"
    ]
  }
}
```

---

### 2. Get Quarterly Coverage Summary for All Companies
**Endpoint:** `GET /api/v1/companies/quarterly-coverage/summary`

**Description:** Ringkasan kelengkapan data quarterly untuk semua PT

**Example Request:**
```bash
curl http://localhost:8001/api/v1/companies/quarterly-coverage/summary
```

**Example Response:**
```json
[
  {
    "company_id": 1,
    "company_name": "PT. Maju Bersama Teknologi",
    "total_quarters": 12,
    "existing_quarters": 4,
    "missing_quarters": 8,
    "coverage_percentage": 33.33,
    "status": "incomplete"
  },
  {
    "company_id": 2,
    "company_name": "PT. Sejahtera Abadi Manufacturing",
    "total_quarters": 12,
    "existing_quarters": 4,
    "missing_quarters": 8,
    "coverage_percentage": 33.33,
    "status": "incomplete"
  },
  {
    "company_id": 3,
    "company_name": "PT. Global Nusantara Solutions",
    "total_quarters": 12,
    "existing_quarters": 0,
    "missing_quarters": 12,
    "coverage_percentage": 0.0,
    "status": "incomplete"
  }
]
```

---

### 3. Get Quarterly Coverage by Document Type
**Endpoint:** `GET /api/v1/companies/{company_id}/quarterly-coverage/by-type?doc_type={type}`

**Description:** Cek kelengkapan data quarterly untuk tipe dokumen tertentu

**Parameters:**
- `company_id` (path): ID perusahaan
- `doc_type` (query): Tipe dokumen (`financial`, `operational`, `management`)

**Example Request:**
```bash
curl "http://localhost:8001/api/v1/companies/1/quarterly-coverage/by-type?doc_type=financial"
```

**Example Response:**
```json
{
  "company_id": 1,
  "document_type": "financial",
  "coverage": {
    "2023": {
      "Q1": {
        "exists": true,
        "document_id": 4,
        "document_number": "FIN/2023/0004",
        "title": "Laporan Keuangan Q1 2023",
        "date": "2023-03-31"
      },
      "Q2": {
        "exists": true,
        "document_id": 8,
        "document_number": "FIN/2023/0008",
        "title": "Laporan Keuangan Q2 2023",
        "date": "2023-06-30"
      },
      "Q3": {
        "exists": false,
        "document_id": null,
        "document_number": null
      },
      "Q4": {
        "exists": false,
        "document_id": null,
        "document_number": null
      }
    },
    "2024": {...},
    "2025": {...}
  },
  "statistics": {
    "total_quarters": 12,
    "existing_quarters": 2,
    "missing_quarters": 10,
    "coverage_percentage": 16.67
  }
}
```

---

## Use Cases

### 1. Dashboard Overview
Gunakan endpoint summary untuk menampilkan overview kelengkapan data semua PT:

```javascript
// Frontend example
const response = await fetch('/api/v1/companies/quarterly-coverage/summary');
const companies = await response.json();

// Display in table
companies.forEach(company => {
  console.log(`${company.company_name}: ${company.coverage_percentage}% complete`);
});
```

### 2. Data Validation
Cek PT mana yang belum lengkap datanya:

```bash
curl http://localhost:8001/api/v1/companies/quarterly-coverage/summary | \
  jq '.[] | select(.status == "incomplete")'
```

### 3. Missing Data Report
Generate laporan data yang hilang:

```bash
curl http://localhost:8001/api/v1/companies/1/quarterly-coverage | \
  jq '.statistics.missing_quarters[]'
```

### 4. Type-Specific Check
Cek kelengkapan untuk tipe dokumen tertentu:

```bash
# Check financial documents
curl "http://localhost:8001/api/v1/companies/1/quarterly-coverage/by-type?doc_type=financial"

# Check operational documents
curl "http://localhost:8001/api/v1/companies/1/quarterly-coverage/by-type?doc_type=operational"

# Check management documents
curl "http://localhost:8001/api/v1/companies/1/quarterly-coverage/by-type?doc_type=management"
```

---

## Response Fields

### Coverage Object
- `exists` (boolean): Apakah quarter ini punya data
- `documents` (array): List dokumen untuk quarter ini
- `document_id` (int): ID dokumen (untuk by-type endpoint)
- `document_number` (string): Nomor dokumen
- `title` (string): Judul dokumen
- `date` (string): Tanggal dokumen (ISO format)

### Statistics Object
- `total_quarters` (int): Total quarters yang dicek (12 untuk 2023-2025)
- `existing_quarters` (int): Jumlah quarters yang ada datanya
- `missing_quarters` (int): Jumlah quarters yang belum ada data
- `coverage_percentage` (float): Persentase kelengkapan
- `missing_quarters` (array): List quarters yang hilang (format: "Q1 2023")

---

## Integration with Frontend

### Example: Coverage Chart
```javascript
async function displayCoverageChart(companyId) {
  const response = await fetch(`/api/v1/companies/${companyId}/quarterly-coverage`);
  const data = await response.json();
  
  // Extract data for chart
  const years = Object.keys(data.coverage);
  const quarters = ['Q1', 'Q2', 'Q3', 'Q4'];
  
  const chartData = years.map(year => {
    return quarters.map(quarter => {
      return data.coverage[year][quarter].exists ? 1 : 0;
    });
  });
  
  // Use with Chart.js or similar
  renderHeatmap(chartData, years, quarters);
}
```

### Example: Missing Data Alert
```javascript
async function checkMissingData(companyId) {
  const response = await fetch(`/api/v1/companies/${companyId}/quarterly-coverage`);
  const data = await response.json();
  
  if (data.statistics.coverage_percentage < 100) {
    alert(`Missing ${data.statistics.missing_quarters_count} quarters: ${data.statistics.missing_quarters.join(', ')}`);
  }
}
```

---

## Testing

### Test All Endpoints
```bash
# Test company 1 coverage
curl http://localhost:8001/api/v1/companies/1/quarterly-coverage

# Test summary
curl http://localhost:8001/api/v1/companies/quarterly-coverage/summary

# Test by type
curl "http://localhost:8001/api/v1/companies/1/quarterly-coverage/by-type?doc_type=financial"
```

### Expected Results After Import
After importing `seeds_quarterly_complete.sql`:
- PT 1-2: Should have Q1-Q4 2023 (financial)
- PT 3-5: Should have Q1-Q4 2023 (financial)
- All: Missing 2024 and 2025 data

---

## Notes

- API checks for documents with period containing "Q1", "Q2", "Q3", or "Q4"
- Years checked: 2023, 2024, 2025 (total 12 quarters)
- Coverage percentage calculated as: (existing / total) * 100
- Status is "complete" only if coverage is 100%
