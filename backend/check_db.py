import pymysql
import os

connection = pymysql.connect(
    host='localhost',
    user='root',
    password='',
    database='ai_writer',
    port=3306
)

try:
    with connection.cursor() as cursor:
        # Check financial_summaries
        cursor.execute("SELECT document_id, revenue FROM financial_summaries LIMIT 5")
        summaries = cursor.fetchall()
        print("Financial Summaries (doc_id, revenue):")
        for s in summaries:
            print(s)
            
        # Check documents
        cursor.execute("SELECT id, title FROM documents ORDER BY id DESC LIMIT 5")
        docs = cursor.fetchall()
        print("\nLatest Documents (id, title):")
        for d in docs:
            print(d)
finally:
    connection.close()
