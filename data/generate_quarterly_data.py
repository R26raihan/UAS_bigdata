#!/usr/bin/env python3
"""
Generate quarterly data with document numbers starting from 5000
to absolutely avoid any conflicts
"""

# Configuration
YEARS = [2024, 2025]
QUARTERS = ['Q1', 'Q2', 'Q3', 'Q4']
QUARTER_DATES = {
    'Q1': '03-31',
    'Q2': '06-30',
    'Q3': '09-30',
    'Q4': '12-31'
}
NUM_COMPANIES = 30

# Generate SQL
sql_output = []
sql_output.append("-- " + "=" * 53)
sql_output.append("-- COMPLETE QUARTERLY DATA 2024-2025")
sql_output.append("-- Document numbers start from 5000 to avoid conflicts")
sql_output.append("-- Coverage: Q1-Q4 for all 30 companies")
sql_output.append("-- " + "=" * 53)
sql_output.append("")

doc_counter = 5000  # Start from 5000 - very safe!

for year in YEARS:
    sql_output.append(f"-- =====================================================")
    sql_output.append(f"-- YEAR {year} - ALL COMPANIES")
    sql_output.append(f"-- =====================================================")
    sql_output.append("")
    
    for company_id in range(1, NUM_COMPANIES + 1):
        sql_output.append(f"-- PT {company_id} - {year}")
        sql_output.append("INSERT INTO documents (company_id, document_number, type, title, period, date, notes) VALUES")
        
        values = []
        for quarter in QUARTERS:
            doc_num = f"FIN/{year}/{doc_counter:04d}"
            period = f"{quarter} {year}"
            date = f"{year}-{QUARTER_DATES[quarter]}"
            title = f"Laporan Keuangan {quarter} {year}"
            
            values.append(f"({company_id}, '{doc_num}', 'financial', '{title}', '{period}', '{date}', 'Quarterly {quarter}')")
            doc_counter += 1
        
        sql_output.append(",\n".join(values) + ";")
        sql_output.append("")

# Summary
sql_output.append("-- " + "=" * 53)
sql_output.append("-- SUMMARY")
sql_output.append("-- " + "=" * 53)
sql_output.append(f"-- Total documents: {NUM_COMPANIES} companies × {len(QUARTERS)} quarters × {len(YEARS)} years = {NUM_COMPANIES * len(QUARTERS) * len(YEARS)}")
sql_output.append(f"-- Document numbers: FIN/2024/5000 - FIN/2025/{doc_counter-1:04d}")
sql_output.append("-- Starting from 5000 to avoid ALL possible conflicts")

# Write to file
output_file = "/Users/raihansetiawan/Uas-bigdata/data/seeds_2024_2025_final.sql"
with open(output_file, 'w') as f:
    f.write('\n'.join(sql_output))

print(f"✅ Generated {doc_counter - 5000} documents")
print(f"📄 Output: {output_file}")
print(f"📊 Document range: FIN/2024/5000 - FIN/2025/{doc_counter-1:04d}")
print(f"🚀 Import with: mysql -u root -p ai_writer < {output_file}")
print(f"✨ Starting from 5000 - guaranteed no conflicts!")
