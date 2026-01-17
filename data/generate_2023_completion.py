#!/usr/bin/env python3
"""
Generate 2023 quarterly data for PT 6-30 to complete coverage
"""

# Configuration
YEAR = 2023
QUARTERS = ['Q1', 'Q2', 'Q3', 'Q4']
QUARTER_DATES = {
    'Q1': '03-31',
    'Q2': '06-30',
    'Q3': '09-30',
    'Q4': '12-31'
}
START_COMPANY = 6
END_COMPANY = 30

# Generate SQL
sql_output = []
sql_output.append("-- " + "=" * 53)
sql_output.append("-- COMPLETE 2023 DATA FOR PT 6-30")
sql_output.append("-- Document numbers start from 6000 to avoid conflicts")
sql_output.append("-- Coverage: Q1-Q4 2023 for PT 6-30")
sql_output.append("-- " + "=" * 53)
sql_output.append("")

doc_counter = 6000  # Start from 6000

sql_output.append(f"-- =====================================================")
sql_output.append(f"-- YEAR {YEAR} - PT {START_COMPANY}-{END_COMPANY}")
sql_output.append(f"-- =====================================================")
sql_output.append("")

for company_id in range(START_COMPANY, END_COMPANY + 1):
    sql_output.append(f"-- PT {company_id} - {YEAR}")
    sql_output.append("INSERT INTO documents (company_id, document_number, type, title, period, date, notes) VALUES")
    
    values = []
    for quarter in QUARTERS:
        doc_num = f"FIN/{YEAR}/{doc_counter:04d}"
        period = f"{quarter} {YEAR}"
        date = f"{YEAR}-{QUARTER_DATES[quarter]}"
        title = f"Laporan Keuangan {quarter} {YEAR}"
        
        values.append(f"({company_id}, '{doc_num}', 'financial', '{title}', '{period}', '{date}', 'Quarterly {quarter}')")
        doc_counter += 1
    
    sql_output.append(",\n".join(values) + ";")
    sql_output.append("")

# Summary
total_companies = END_COMPANY - START_COMPANY + 1
total_docs = total_companies * len(QUARTERS)

sql_output.append("-- " + "=" * 53)
sql_output.append("-- SUMMARY")
sql_output.append("-- " + "=" * 53)
sql_output.append(f"-- Total documents: {total_companies} companies × {len(QUARTERS)} quarters = {total_docs}")
sql_output.append(f"-- Document numbers: FIN/{YEAR}/6000 - FIN/{YEAR}/{doc_counter-1:04d}")
sql_output.append("-- After import, ALL 30 companies will have 100% coverage!")

# Write to file
output_file = "/Users/raihansetiawan/Uas-bigdata/data/seeds_2023_pt6_30.sql"
with open(output_file, 'w') as f:
    f.write('\n'.join(sql_output))

print(f"✅ Generated {total_docs} documents for PT {START_COMPANY}-{END_COMPANY}")
print(f"📄 Output: {output_file}")
print(f"📊 Document range: FIN/{YEAR}/6000 - FIN/{YEAR}/{doc_counter-1:04d}")
print(f"🚀 Import with phpMyAdmin or: mysql -u root -p ai_writer < {output_file}")
print(f"✨ After import: ALL 30 companies = 100% coverage!")
