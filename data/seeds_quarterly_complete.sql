-- =====================================================
-- SEED DATA COMPLETION - Q3, Q4, ANNUAL 2023
-- Melengkapi data quarterly yang belum ada di seeds.sql
-- Document numbers start from 0100 to avoid conflicts
-- =====================================================

-- =====================================================
-- FINANCIAL DOCUMENTS - Q3 & Q4 2023
-- =====================================================

-- PT 1: Maju Bersama Teknologi - Q3 & Q4
INSERT INTO documents (company_id, document_number, type, title, period, date, notes) VALUES
(1, 'FIN/2023/0101', 'financial', 'Laporan Keuangan September 2023', 'September 2023', '2023-09-30', 'Laporan bulanan Q3'),
(1, 'FIN/2023/0102', 'financial', 'Laporan Keuangan Q3 2023', 'Q3 2023', '2023-09-30', 'Laporan kuartalan Q3'),
(1, 'FIN/2023/0103', 'financial', 'Laporan Keuangan Oktober 2023', 'Oktober 2023', '2023-10-31', 'Laporan bulanan Q4'),
(1, 'FIN/2023/0104', 'financial', 'Laporan Keuangan November 2023', 'November 2023', '2023-11-30', 'Laporan bulanan Q4'),
(1, 'FIN/2023/0105', 'financial', 'Laporan Keuangan Desember 2023', 'Desember 2023', '2023-12-31', 'Laporan bulanan Q4'),
(1, 'FIN/2023/0106', 'financial', 'Laporan Keuangan Q4 2023', 'Q4 2023', '2023-12-31', 'Laporan kuartalan Q4'),
(1, 'FIN/2023/0107', 'financial', 'Laporan Keuangan Tahunan 2023', 'Tahun 2023', '2023-12-31', 'Laporan tahunan');

-- PT 2: Sejahtera Abadi Manufacturing - Q3 & Q4
INSERT INTO documents (company_id, document_number, type, title, period, date, notes) VALUES
(2, 'FIN/2023/0201', 'financial', 'Laporan Keuangan September 2023', 'September 2023', '2023-09-30', 'Manufacturing Q3'),
(2, 'FIN/2023/0202', 'financial', 'Laporan Keuangan Q3 2023', 'Q3 2023', '2023-09-30', 'Quarterly Q3'),
(2, 'FIN/2023/0203', 'financial', 'Laporan Keuangan Oktober 2023', 'Oktober 2023', '2023-10-31', 'Manufacturing Q4'),
(2, 'FIN/2023/0204', 'financial', 'Laporan Keuangan November 2023', 'November 2023', '2023-11-30', 'Manufacturing Q4'),
(2, 'FIN/2023/0205', 'financial', 'Laporan Keuangan Desember 2023', 'Desember 2023', '2023-12-31', 'Manufacturing Q4'),
(2, 'FIN/2023/0206', 'financial', 'Laporan Keuangan Q4 2023', 'Q4 2023', '2023-12-31', 'Quarterly Q4'),
(2, 'FIN/2023/0207', 'financial', 'Laporan Keuangan Tahunan 2023', 'Tahun 2023', '2023-12-31', 'Annual report');

-- PT 3: Global Nusantara Solutions - Complete 2023
INSERT INTO documents (company_id, document_number, type, title, period, date, notes) VALUES
(3, 'FIN/2023/0301', 'financial', 'Laporan Keuangan Q1 2023', 'Q1 2023', '2023-03-31', 'Quarterly Q1'),
(3, 'FIN/2023/0302', 'financial', 'Laporan Keuangan Q2 2023', 'Q2 2023', '2023-06-30', 'Quarterly Q2'),
(3, 'FIN/2023/0303', 'financial', 'Laporan Keuangan Q3 2023', 'Q3 2023', '2023-09-30', 'Quarterly Q3'),
(3, 'FIN/2023/0304', 'financial', 'Laporan Keuangan Q4 2023', 'Q4 2023', '2023-12-31', 'Quarterly Q4'),
(3, 'FIN/2023/0305', 'financial', 'Laporan Keuangan Tahunan 2023', 'Tahun 2023', '2023-12-31', 'Annual report');

-- PT 4: Karya Mandiri Industri - Complete 2023
INSERT INTO documents (company_id, document_number, type, title, period, date, notes) VALUES
(4, 'FIN/2023/0401', 'financial', 'Laporan Keuangan Q1 2023', 'Q1 2023', '2023-03-31', 'Quarterly Q1'),
(4, 'FIN/2023/0402', 'financial', 'Laporan Keuangan Q2 2023', 'Q2 2023', '2023-06-30', 'Quarterly Q2'),
(4, 'FIN/2023/0403', 'financial', 'Laporan Keuangan Q3 2023', 'Q3 2023', '2023-09-30', 'Quarterly Q3'),
(4, 'FIN/2023/0404', 'financial', 'Laporan Keuangan Q4 2023', 'Q4 2023', '2023-12-31', 'Quarterly Q4'),
(4, 'FIN/2023/0405', 'financial', 'Laporan Keuangan Tahunan 2023', 'Tahun 2023', '2023-12-31', 'Annual report');

-- PT 5: Inovasi Digital Indonesia - Complete 2023
INSERT INTO documents (company_id, document_number, type, title, period, date, notes) VALUES
(5, 'FIN/2023/0501', 'financial', 'Laporan Keuangan Q1 2023', 'Q1 2023', '2023-03-31', 'Quarterly Q1'),
(5, 'FIN/2023/0502', 'financial', 'Laporan Keuangan Q2 2023', 'Q2 2023', '2023-06-30', 'Quarterly Q2'),
(5, 'FIN/2023/0503', 'financial', 'Laporan Keuangan Q3 2023', 'Q3 2023', '2023-09-30', 'Quarterly Q3'),
(5, 'FIN/2023/0504', 'financial', 'Laporan Keuangan Q4 2023', 'Q4 2023', '2023-12-31', 'Quarterly Q4'),
(5, 'FIN/2023/0505', 'financial', 'Laporan Keuangan Tahunan 2023', 'Tahun 2023', '2023-12-31', 'Annual report');

-- =====================================================
-- FINANCIAL SUMMARIES - Q3 & Q4 2023
-- =====================================================

-- PT 1 Financial Summaries
INSERT INTO financial_summaries (document_id, revenue, revenue_last_year, expenses, expenses_last_year, net_profit, net_profit_last_year, profit_margin, profit_margin_last_year) VALUES
-- September 2023
((SELECT id FROM documents WHERE company_id = 1 AND period = 'September 2023' AND document_number = 'FIN/2023/0101'), 
 13800000000, 11500000000, 10500000000, 9200000000, 3300000000, 2300000000, 23.9, 20.0),
-- Q3 2023
((SELECT id FROM documents WHERE company_id = 1 AND period = 'Q3 2023' AND document_number = 'FIN/2023/0102'), 
 41200000000, 34500000000, 31800000000, 27500000000, 9400000000, 7000000000, 22.8, 20.3),
-- Oktober 2023
((SELECT id FROM documents WHERE company_id = 1 AND period = 'Oktober 2023' AND document_number = 'FIN/2023/0103'), 
 14200000000, 12000000000, 10800000000, 9500000000, 3400000000, 2500000000, 23.9, 20.8),
-- November 2023
((SELECT id FROM documents WHERE company_id = 1 AND period = 'November 2023' AND document_number = 'FIN/2023/0104'), 
 15100000000, 12800000000, 11400000000, 10200000000, 3700000000, 2600000000, 24.5, 20.3),
-- Desember 2023
((SELECT id FROM documents WHERE company_id = 1 AND period = 'Desember 2023' AND document_number = 'FIN/2023/0105'), 
 16500000000, 14000000000, 12500000000, 11000000000, 4000000000, 3000000000, 24.2, 21.4),
-- Q4 2023
((SELECT id FROM documents WHERE company_id = 1 AND period = 'Q4 2023' AND document_number = 'FIN/2023/0106'), 
 45800000000, 38800000000, 34700000000, 30700000000, 11100000000, 8100000000, 24.2, 20.9),
-- Annual 2023
((SELECT id FROM documents WHERE company_id = 1 AND period = 'Tahun 2023' AND document_number = 'FIN/2023/0107'), 
 174500000000, 145000000000, 132300000000, 115000000000, 42200000000, 30000000000, 24.2, 20.7);

-- PT 2 Financial Summaries
INSERT INTO financial_summaries (document_id, revenue, revenue_last_year, expenses, expenses_last_year, net_profit, net_profit_last_year, profit_margin, profit_margin_last_year) VALUES
-- September 2023
((SELECT id FROM documents WHERE company_id = 2 AND period = 'September 2023' AND document_number = 'FIN/2023/0201'), 
 18500000000, 16200000000, 14800000000, 13000000000, 3700000000, 3200000000, 20.0, 19.8),
-- Q3 2023
((SELECT id FROM documents WHERE company_id = 2 AND period = 'Q3 2023' AND document_number = 'FIN/2023/0202'), 
 55000000000, 48000000000, 44000000000, 38500000000, 11000000000, 9500000000, 20.0, 19.8),
-- Oktober 2023
((SELECT id FROM documents WHERE company_id = 2 AND period = 'Oktober 2023' AND document_number = 'FIN/2023/0203'), 
 19200000000, 17000000000, 15400000000, 13600000000, 3800000000, 3400000000, 19.8, 20.0),
-- November 2023
((SELECT id FROM documents WHERE company_id = 2 AND period = 'November 2023' AND document_number = 'FIN/2023/0204'), 
 20100000000, 17800000000, 16100000000, 14300000000, 4000000000, 3500000000, 19.9, 19.7),
-- Desember 2023
((SELECT id FROM documents WHERE company_id = 2 AND period = 'Desember 2023' AND document_number = 'FIN/2023/0205'), 
 21500000000, 19000000000, 17200000000, 15200000000, 4300000000, 3800000000, 20.0, 20.0),
-- Q4 2023
((SELECT id FROM documents WHERE company_id = 2 AND period = 'Q4 2023' AND document_number = 'FIN/2023/0206'), 
 60800000000, 53800000000, 48700000000, 43100000000, 12100000000, 10700000000, 19.9, 19.9),
-- Annual 2023
((SELECT id FROM documents WHERE company_id = 2 AND period = 'Tahun 2023' AND document_number = 'FIN/2023/0207'), 
 230000000000, 200000000000, 184000000000, 160000000000, 46000000000, 40000000000, 20.0, 20.0);

-- PT 3 Financial Summaries (All Quarters)
INSERT INTO financial_summaries (document_id, revenue, revenue_last_year, expenses, expenses_last_year, net_profit, net_profit_last_year, profit_margin, profit_margin_last_year) VALUES
-- Q1 2023
((SELECT id FROM documents WHERE company_id = 3 AND period = 'Q1 2023' AND document_number = 'FIN/2023/0301'), 
 26000000000, 21800000000, 18200000000, 15500000000, 7800000000, 6300000000, 30.0, 28.9),
-- Q2 2023
((SELECT id FROM documents WHERE company_id = 3 AND period = 'Q2 2023' AND document_number = 'FIN/2023/0302'), 
 27000000000, 22700000000, 18800000000, 16200000000, 8200000000, 6500000000, 30.4, 28.6),
-- Q3 2023
((SELECT id FROM documents WHERE company_id = 3 AND period = 'Q3 2023' AND document_number = 'FIN/2023/0303'), 
 28500000000, 23900000000, 19800000000, 17000000000, 8700000000, 6900000000, 30.5, 28.9),
-- Q4 2023
((SELECT id FROM documents WHERE company_id = 3 AND period = 'Q4 2023' AND document_number = 'FIN/2023/0304'), 
 30500000000, 25600000000, 21200000000, 18300000000, 9300000000, 7300000000, 30.5, 28.5),
-- Annual 2023
((SELECT id FROM documents WHERE company_id = 3 AND period = 'Tahun 2023' AND document_number = 'FIN/2023/0305'), 
 112000000000, 94000000000, 78000000000, 67000000000, 34000000000, 27000000000, 30.4, 28.7);

-- PT 4 Financial Summaries (All Quarters)
INSERT INTO financial_summaries (document_id, revenue, revenue_last_year, expenses, expenses_last_year, net_profit, net_profit_last_year, profit_margin, profit_margin_last_year) VALUES
-- Q1 2023
((SELECT id FROM documents WHERE company_id = 4 AND period = 'Q1 2023' AND document_number = 'FIN/2023/0401'), 
 65000000000, 54800000000, 53500000000, 45500000000, 11500000000, 9300000000, 17.7, 17.0),
-- Q2 2023
((SELECT id FROM documents WHERE company_id = 4 AND period = 'Q2 2023' AND document_number = 'FIN/2023/0402'), 
 68000000000, 57400000000, 56000000000, 47700000000, 12000000000, 9700000000, 17.6, 16.9),
-- Q3 2023
((SELECT id FROM documents WHERE company_id = 4 AND period = 'Q3 2023' AND document_number = 'FIN/2023/0403'), 
 70000000000, 59100000000, 57700000000, 49200000000, 12300000000, 9900000000, 17.6, 16.8),
-- Q4 2023
((SELECT id FROM documents WHERE company_id = 4 AND period = 'Q4 2023' AND document_number = 'FIN/2023/0404'), 
 73000000000, 61700000000, 60300000000, 51400000000, 12700000000, 10300000000, 17.4, 16.7),
-- Annual 2023
((SELECT id FROM documents WHERE company_id = 4 AND period = 'Tahun 2023' AND document_number = 'FIN/2023/0405'), 
 276000000000, 233000000000, 227500000000, 193800000000, 48500000000, 39200000000, 17.6, 16.8);

-- PT 5 Financial Summaries (All Quarters)
INSERT INTO financial_summaries (document_id, revenue, revenue_last_year, expenses, expenses_last_year, net_profit, net_profit_last_year, profit_margin, profit_margin_last_year) VALUES
-- Q1 2023
((SELECT id FROM documents WHERE company_id = 5 AND period = 'Q1 2023' AND document_number = 'FIN/2023/0501'), 
 17000000000, 12200000000, 11500000000, 8400000000, 5500000000, 3800000000, 32.4, 31.1),
-- Q2 2023
((SELECT id FROM documents WHERE company_id = 5 AND period = 'Q2 2023' AND document_number = 'FIN/2023/0502'), 
 18400000000, 13200000000, 12400000000, 9100000000, 6000000000, 4100000000, 32.6, 31.1),
-- Q3 2023
((SELECT id FROM documents WHERE company_id = 5 AND period = 'Q3 2023' AND document_number = 'FIN/2023/0503'), 
 19200000000, 13800000000, 12900000000, 9500000000, 6300000000, 4300000000, 32.8, 31.2),
-- Q4 2023
((SELECT id FROM documents WHERE company_id = 5 AND period = 'Q4 2023' AND document_number = 'FIN/2023/0504'), 
 20400000000, 14700000000, 13700000000, 10100000000, 6700000000, 4600000000, 32.8, 31.3),
-- Annual 2023
((SELECT id FROM documents WHERE company_id = 5 AND period = 'Tahun 2023' AND document_number = 'FIN/2023/0505'), 
 75000000000, 53900000000, 50500000000, 37100000000, 24500000000, 16800000000, 32.7, 31.2);

-- =====================================================
-- MANAGEMENT DOCUMENTS - Q3 & Q4 Completion
-- =====================================================

-- PT 3 Management Q3 & Q4
INSERT INTO documents (company_id, document_number, type, title, period, date, notes) VALUES
(3, 'MGT/2023/PT3-Q3', 'management', 'Laporan Manajemen Q3 2023', 'Q3 2023', '2023-09-30', 'Strategic review Q3'),
(3, 'MGT/2023/PT3-Q4', 'management', 'Laporan Manajemen Q4 2023', 'Q4 2023', '2023-12-31', 'Strategic review Q4'),
(3, 'MGT/2023/PT3-ANNUAL', 'management', 'Laporan Manajemen Tahunan 2023', 'Tahun 2023', '2023-12-31', 'Annual review');

-- PT 4 Management Q2, Q3, Q4
INSERT INTO documents (company_id, document_number, type, title, period, date, notes) VALUES
(4, 'MGT/2023/PT4-Q2', 'management', 'Laporan Manajemen Q2 2023', 'Q2 2023', '2023-06-30', 'Strategic review Q2'),
(4, 'MGT/2023/PT4-Q3', 'management', 'Laporan Manajemen Q3 2023', 'Q3 2023', '2023-09-30', 'Strategic review Q3'),
(4, 'MGT/2023/PT4-Q4', 'management', 'Laporan Manajemen Q4 2023', 'Q4 2023', '2023-12-31', 'Strategic review Q4'),
(4, 'MGT/2023/PT4-ANNUAL', 'management', 'Laporan Manajemen Tahunan 2023', 'Tahun 2023', '2023-12-31', 'Annual review');

-- PT 5 Management Q2, Q3, Q4
INSERT INTO documents (company_id, document_number, type, title, period, date, notes) VALUES
(5, 'MGT/2023/PT5-Q2', 'management', 'Laporan Manajemen Q2 2023', 'Q2 2023', '2023-06-30', 'Strategic review Q2'),
(5, 'MGT/2023/PT5-Q3', 'management', 'Laporan Manajemen Q3 2023', 'Q3 2023', '2023-09-30', 'Strategic review Q3'),
(5, 'MGT/2023/PT5-Q4', 'management', 'Laporan Manajemen Q4 2023', 'Q4 2023', '2023-12-31', 'Strategic review Q4'),
(5, 'MGT/2023/PT5-ANNUAL', 'management', 'Laporan Manajemen Tahunan 2023', 'Tahun 2023', '2023-12-31', 'Annual review');

-- =====================================================
-- OPERATIONAL DOCUMENTS - Quarterly
-- =====================================================

-- PT 1-5 Operational Quarterly
INSERT INTO documents (company_id, document_number, type, title, period, date, notes) VALUES
(1, 'OPS/2023/PT1-Q3', 'operational', 'Laporan Operasional Q3 2023', 'Q3 2023', '2023-09-30', 'Operational Q3'),
(1, 'OPS/2023/PT1-Q4', 'operational', 'Laporan Operasional Q4 2023', 'Q4 2023', '2023-12-31', 'Operational Q4'),
(2, 'OPS/2023/PT2-Q3', 'operational', 'Laporan Operasional Q3 2023', 'Q3 2023', '2023-09-30', 'Operational Q3'),
(2, 'OPS/2023/PT2-Q4', 'operational', 'Laporan Operasional Q4 2023', 'Q4 2023', '2023-12-31', 'Operational Q4'),
(3, 'OPS/2023/PT3-Q3', 'operational', 'Laporan Operasional Q3 2023', 'Q3 2023', '2023-09-30', 'Operational Q3'),
(3, 'OPS/2023/PT3-Q4', 'operational', 'Laporan Operasional Q4 2023', 'Q4 2023', '2023-12-31', 'Operational Q4'),
(4, 'OPS/2023/PT4-Q3', 'operational', 'Laporan Operasional Q3 2023', 'Q3 2023', '2023-09-30', 'Operational Q3'),
(4, 'OPS/2023/PT4-Q4', 'operational', 'Laporan Operasional Q4 2023', 'Q4 2023', '2023-12-31', 'Operational Q4'),
(5, 'OPS/2023/PT5-Q3', 'operational', 'Laporan Operasional Q3 2023', 'Q3 2023', '2023-09-30', 'Operational Q3'),
(5, 'OPS/2023/PT5-Q4', 'operational', 'Laporan Operasional Q4 2023', 'Q4 2023', '2023-12-31', 'Operational Q4');

-- =====================================================
-- SUMMARY
-- =====================================================
/*
Data yang ditambahkan:
- PT 1-2: Q3, Q4, Annual (Financial) - 14 documents
- PT 3-5: Q1, Q2, Q3, Q4, Annual (Financial) - 15 documents
- PT 3-5: Q2-Q4, Annual (Management) - 10 documents
- PT 1-5: Q3-Q4 (Operational) - 10 documents

Total: ~50 documents baru
Coverage: Complete 2023 quarterly data untuk semua PT
*/
