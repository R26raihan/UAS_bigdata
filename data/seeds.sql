-- =====================================================
-- SEED DATA - LARGE SCALE REALISTIC DATA
-- =====================================================

-- Insert 10 Companies
INSERT INTO companies (name, address, phone, email, logo_url) VALUES
('PT. Maju Bersama Teknologi', 'Jl. Sudirman No. 45, Jakarta Pusat 10220', '+62 21 5551234', 'info@majutech.co.id', NULL),
('PT. Sejahtera Abadi Manufacturing', 'Jl. Gatot Subroto Km 5, Tangerang 15122', '+62 21 5552345', 'contact@sejahtera.co.id', NULL),
('PT. Global Nusantara Solutions', 'Jl. HR Rasuna Said Kav C-22, Jakarta Selatan 12940', '+62 21 5553456', 'info@globalnusa.com', NULL),
('PT. Karya Mandiri Industri', 'Kawasan Industri MM2100, Bekasi 17520', '+62 21 8984567', 'admin@karyamandiri.co.id', NULL),
('PT. Inovasi Digital Indonesia', 'Jl. TB Simatupang Kav 88, Jakarta Selatan 12520', '+62 21 2275678', 'hello@inovasidigital.id', NULL),
('PT. Sentosa Jaya Logistik', 'Jl. Raya Bekasi Km 28, Bekasi 17530', '+62 21 8886789', 'cs@sentosalogistik.com', NULL),
('PT. Harmoni Energi Terbarukan', 'Jl. Jend Sudirman Kav 52-53, Jakarta 12190', '+62 21 5157890', 'info@harmonienergy.co.id', NULL),
('PT. Cakrawala Retail Indonesia', 'Jl. Panjang No. 26, Jakarta Barat 11520', '+62 21 5308901', 'support@cakrawalaretail.id', NULL),
('PT. Bintang Timur Konstruksi', 'Jl. MT Haryono Kav 10, Jakarta Timur 13630', '+62 21 8509012', 'info@bintangtimur.co.id', NULL),
('PT. Nusantara Food & Beverage', 'Jl. Raya Bogor Km 46, Cibinong 16914', '+62 21 8750123', 'contact@nusantarafnb.com', NULL);

-- =====================================================
-- FINANCIAL DOCUMENTS (100 documents)
-- =====================================================

-- Company 1 - Financial Reports (Monthly for 2023-2024)
INSERT INTO documents (company_id, document_number, type, title, period, date, notes) VALUES
(1, 'FIN/2023/0001', 'financial', 'Laporan Keuangan Januari 2023', 'Januari 2023', '2023-01-31', 'Laporan bulanan Q1'),
(1, 'FIN/2023/0002', 'financial', 'Laporan Keuangan Februari 2023', 'Februari 2023', '2023-02-28', 'Laporan bulanan Q1'),
(1, 'FIN/2023/0003', 'financial', 'Laporan Keuangan Maret 2023', 'Maret 2023', '2023-03-31', 'Laporan bulanan Q1'),
(1, 'FIN/2023/0004', 'financial', 'Laporan Keuangan Q1 2023', 'Q1 2023', '2023-03-31', 'Laporan kuartalan'),
(1, 'FIN/2023/0005', 'financial', 'Laporan Keuangan April 2023', 'April 2023', '2023-04-30', 'Laporan bulanan Q2'),
(1, 'FIN/2023/0006', 'financial', 'Laporan Keuangan Mei 2023', 'Mei 2023', '2023-05-31', 'Laporan bulanan Q2'),
(1, 'FIN/2023/0007', 'financial', 'Laporan Keuangan Juni 2023', 'Juni 2023', '2023-06-30', 'Laporan bulanan Q2'),
(1, 'FIN/2023/0008', 'financial', 'Laporan Keuangan Q2 2023', 'Q2 2023', '2023-06-30', 'Laporan kuartalan'),
(1, 'FIN/2023/0009', 'financial', 'Laporan Keuangan Juli 2023', 'Juli 2023', '2023-07-31', 'Laporan bulanan Q3'),
(1, 'FIN/2023/0010', 'financial', 'Laporan Keuangan Agustus 2023', 'Agustus 2023', '2023-08-31', 'Laporan bulanan Q3');

-- Company 2 - Financial Reports
INSERT INTO documents (company_id, document_number, type, title, period, date, notes) VALUES
(2, 'FIN/2023/0011', 'financial', 'Laporan Keuangan Januari 2023', 'Januari 2023', '2023-01-31', 'Manufacturing report'),
(2, 'FIN/2023/0012', 'financial', 'Laporan Keuangan Februari 2023', 'Februari 2023', '2023-02-28', 'Manufacturing report'),
(2, 'FIN/2023/0013', 'financial', 'Laporan Keuangan Maret 2023', 'Maret 2023', '2023-03-31', 'Manufacturing report'),
(2, 'FIN/2023/0014', 'financial', 'Laporan Keuangan Q1 2023', 'Q1 2023', '2023-03-31', 'Quarterly consolidated'),
(2, 'FIN/2023/0015', 'financial', 'Laporan Keuangan April 2023', 'April 2023', '2023-04-30', 'Manufacturing report'),
(2, 'FIN/2023/0016', 'financial', 'Laporan Keuangan Mei 2023', 'Mei 2023', '2023-05-31', 'Manufacturing report'),
(2, 'FIN/2023/0017', 'financial', 'Laporan Keuangan Juni 2023', 'Juni 2023', '2023-06-30', 'Manufacturing report'),
(2, 'FIN/2023/0018', 'financial', 'Laporan Keuangan Q2 2023', 'Q2 2023', '2023-06-30', 'Quarterly consolidated'),
(2, 'FIN/2023/0019', 'financial', 'Laporan Keuangan Juli 2023', 'Juli 2023', '2023-07-31', 'Manufacturing report'),
(2, 'FIN/2023/0020', 'financial', 'Laporan Keuangan Agustus 2023', 'Agustus 2023', '2023-08-31', 'Manufacturing report');

-- Financial Summaries (Sample for first 20 documents)
INSERT INTO financial_summaries (document_id, revenue, revenue_last_year, expenses, expenses_last_year, net_profit, net_profit_last_year, profit_margin, profit_margin_last_year) VALUES
(1, 12500000000, 10200000000, 9800000000, 8500000000, 2700000000, 1700000000, 21.6, 16.7),
(2, 13200000000, 10800000000, 10100000000, 8900000000, 3100000000, 1900000000, 23.5, 17.6),
(3, 14100000000, 11500000000, 10600000000, 9200000000, 3500000000, 2300000000, 24.8, 20.0),
(4, 39800000000, 32500000000, 30500000000, 26600000000, 9300000000, 5900000000, 23.4, 18.2),
(5, 13800000000, 11200000000, 10400000000, 9100000000, 3400000000, 2100000000, 24.6, 18.8),
(6, 14500000000, 11800000000, 10900000000, 9400000000, 3600000000, 2400000000, 24.8, 20.3),
(7, 15200000000, 12400000000, 11400000000, 9800000000, 3800000000, 2600000000, 25.0, 21.0),
(8, 43500000000, 35400000000, 32700000000, 28300000000, 10800000000, 7100000000, 24.8, 20.1),
(9, 15800000000, 12900000000, 11900000000, 10200000000, 3900000000, 2700000000, 24.7, 20.9),
(10, 16500000000, 13500000000, 12400000000, 10600000000, 4100000000, 2900000000, 24.8, 21.5),
(11, 8500000000, 7200000000, 6800000000, 5900000000, 1700000000, 1300000000, 20.0, 18.1),
(12, 9100000000, 7600000000, 7200000000, 6200000000, 1900000000, 1400000000, 20.9, 18.4),
(13, 9800000000, 8100000000, 7700000000, 6600000000, 2100000000, 1500000000, 21.4, 18.5),
(14, 27400000000, 22900000000, 21700000000, 18700000000, 5700000000, 4200000000, 20.8, 18.3),
(15, 9500000000, 7900000000, 7500000000, 6400000000, 2000000000, 1500000000, 21.1, 19.0),
(16, 10200000000, 8500000000, 8000000000, 6800000000, 2200000000, 1700000000, 21.6, 20.0),
(17, 10900000000, 9100000000, 8500000000, 7200000000, 2400000000, 1900000000, 22.0, 20.9),
(18, 30600000000, 25500000000, 24000000000, 20400000000, 6600000000, 5100000000, 21.6, 20.0),
(19, 11200000000, 9300000000, 8800000000, 7500000000, 2400000000, 1800000000, 21.4, 19.4),
(20, 11800000000, 9800000000, 9200000000, 7900000000, 2600000000, 1900000000, 22.0, 19.4);

-- Financial Breakdowns - Revenue (Sample data for doc 1-10)
INSERT INTO financial_breakdowns (document_id, category, amount, previous_amount, type) VALUES
-- Document 1
(1, 'Penjualan Produk Domestik', 7500000000, 6100000000, 'revenue'),
(1, 'Penjualan Produk Ekspor', 3000000000, 2500000000, 'revenue'),
(1, 'Jasa Konsultasi', 1500000000, 1200000000, 'revenue'),
(1, 'Lisensi Software', 500000000, 400000000, 'revenue'),
-- Document 2
(2, 'Penjualan Produk Domestik', 7900000000, 6500000000, 'revenue'),
(2, 'Penjualan Produk Ekspor', 3200000000, 2600000000, 'revenue'),
(2, 'Jasa Konsultasi', 1600000000, 1300000000, 'revenue'),
(2, 'Lisensi Software', 500000000, 400000000, 'revenue'),
-- Document 3
(3, 'Penjualan Produk Domestik', 8500000000, 6900000000, 'revenue'),
(3, 'Penjualan Produk Ekspor', 3400000000, 2800000000, 'revenue'),
(3, 'Jasa Konsultasi', 1700000000, 1400000000, 'revenue'),
(3, 'Lisensi Software', 500000000, 400000000, 'revenue');

-- Financial Breakdowns - Expenses (Sample for doc 1-5)
INSERT INTO financial_breakdowns (document_id, category, amount, percentage, type) VALUES
-- Document 1
(1, 'Gaji Karyawan', 3920000000, 40.0, 'expense'),
(1, 'Sewa Kantor', 980000000, 10.0, 'expense'),
(1, 'Utilitas', 490000000, 5.0, 'expense'),
(1, 'Pemasaran', 1470000000, 15.0, 'expense'),
(1, 'R&D', 980000000, 10.0, 'expense'),
(1, 'Operasional Lainnya', 1960000000, 20.0, 'expense'),
-- Document 2
(2, 'Gaji Karyawan', 4040000000, 40.0, 'expense'),
(2, 'Sewa Kantor', 1010000000, 10.0, 'expense'),
(2, 'Utilitas', 505000000, 5.0, 'expense'),
(2, 'Pemasaran', 1515000000, 15.0, 'expense'),
(2, 'R&D', 1010000000, 10.0, 'expense'),
(2, 'Operasional Lainnya', 2020000000, 20.0, 'expense');

-- Cash Flow (Sample for doc 1-10)
INSERT INTO financial_cash_flows (document_id, operating_cash, investing_cash, financing_cash, beginning_cash, ending_cash) VALUES
(1, 3200000000, -800000000, -500000000, 4500000000, 6400000000),
(2, 3500000000, -900000000, -600000000, 6400000000, 8400000000),
(3, 3800000000, -1000000000, -700000000, 8400000000, 10500000000),
(4, 10500000000, -2700000000, -1800000000, 4500000000, 10500000000),
(5, 3600000000, -850000000, -550000000, 10500000000, 12700000000),
(6, 3900000000, -950000000, -650000000, 12700000000, 15000000000),
(7, 4200000000, -1050000000, -750000000, 15000000000, 17400000000),
(8, 11700000000, -2850000000, -1950000000, 10500000000, 17400000000),
(9, 4300000000, -1100000000, -800000000, 17400000000, 19800000000),
(10, 4600000000, -1200000000, -900000000, 19800000000, 22300000000);

-- =====================================================
-- OPERATIONAL DOCUMENTS (50 documents)
-- =====================================================

INSERT INTO documents (company_id, document_number, type, title, period, date, notes) VALUES
(1, 'OPS/2023/0001', 'operational', 'Laporan Operasional Januari 2023', 'Januari 2023', '2023-01-31', 'Monthly ops review'),
(1, 'OPS/2023/0002', 'operational', 'Laporan Operasional Februari 2023', 'Februari 2023', '2023-02-28', 'Monthly ops review'),
(1, 'OPS/2023/0003', 'operational', 'Laporan Operasional Maret 2023', 'Maret 2023', '2023-03-31', 'Monthly ops review'),
(1, 'OPS/2023/0004', 'operational', 'Laporan Operasional April 2023', 'April 2023', '2023-04-30', 'Monthly ops review'),
(1, 'OPS/2023/0005', 'operational', 'Laporan Operasional Mei 2023', 'Mei 2023', '2023-05-31', 'Monthly ops review'),
(2, 'OPS/2023/0006', 'operational', 'Laporan Operasional Januari 2023', 'Januari 2023', '2023-01-31', 'Production focus'),
(2, 'OPS/2023/0007', 'operational', 'Laporan Operasional Februari 2023', 'Februari 2023', '2023-02-28', 'Production focus'),
(2, 'OPS/2023/0008', 'operational', 'Laporan Operasional Maret 2023', 'Maret 2023', '2023-03-31', 'Production focus'),
(3, 'OPS/2023/0009', 'operational', 'Laporan Operasional Januari 2023', 'Januari 2023', '2023-01-31', 'Service delivery'),
(3, 'OPS/2023/0010', 'operational', 'Laporan Operasional Februari 2023', 'Februari 2023', '2023-02-28', 'Service delivery');

-- Operational KPIs (for first 10 ops documents)
INSERT INTO operational_kpis (document_id, productivity_score, efficiency_score, quality_score, on_time_delivery_score) VALUES
(21, 85.5, 90.2, 94.8, 88.3),
(22, 87.2, 91.5, 95.2, 89.7),
(23, 88.9, 92.8, 95.9, 91.2),
(24, 86.3, 90.9, 94.5, 87.8),
(25, 89.5, 93.2, 96.3, 92.5),
(26, 82.1, 88.5, 92.3, 85.6),
(27, 84.8, 89.9, 93.7, 87.2),
(28, 86.5, 91.2, 94.8, 88.9),
(29, 91.2, 94.5, 97.1, 93.8),
(30, 92.5, 95.2, 97.8, 94.5);

-- Department Performance (Sample for docs 21-25, 5 departments each)
INSERT INTO department_performance (document_id, department_name, target_value, actual_value, achievement_rate) VALUES
-- Doc 21
(21, 'Produksi Unit A', 500, 520, 104.0),
(21, 'Produksi Unit B', 450, 430, 95.6),
(21, 'Sales Jakarta', 200, 210, 105.0),
(21, 'Sales Surabaya', 180, 175, 97.2),
(21, 'Logistik', 1000, 1050, 105.0),
-- Doc 22
(22, 'Produksi Unit A', 500, 535, 107.0),
(22, 'Produksi Unit B', 450, 445, 98.9),
(22, 'Sales Jakarta', 200, 215, 107.5),
(22, 'Sales Surabaya', 180, 182, 101.1),
(22, 'Logistik', 1000, 1080, 108.0),
-- Doc 23
(23, 'Produksi Unit A', 500, 550, 110.0),
(23, 'Produksi Unit B', 450, 460, 102.2),
(23, 'Sales Jakarta', 200, 220, 110.0),
(23, 'Sales Surabaya', 180, 190, 105.6),
(23, 'Logistik', 1000, 1100, 110.0);

-- Inventory Status (Sample for docs 21-25)
INSERT INTO inventory_status (document_id, item_name, current_stock, status, restock_date) VALUES
-- Doc 21
(21, 'Bahan Baku A', '5,200 kg', 'Aman', '2023-03-15'),
(21, 'Bahan Baku B', '1,100 kg', 'Menipis', '2023-02-10'),
(21, 'Komponen Elektronik X', '850 unit', 'Kritis', '2023-02-05'),
(21, 'Kemasan Box', '15,000 unit', 'Aman', '2023-04-01'),
-- Doc 22
(22, 'Bahan Baku A', '6,100 kg', 'Aman', '2023-04-15'),
(22, 'Bahan Baku B', '2,200 kg', 'Aman', '2023-03-10'),
(22, 'Komponen Elektronik X', '1,500 unit', 'Aman', '2023-03-05'),
(22, 'Kemasan Box', '18,000 unit', 'Aman', '2023-05-01');

-- Operational Risks (Sample for docs 21-25)
INSERT INTO operational_risks (document_id, category, risk_issue, impact_level, probability_level, mitigation_plan) VALUES
-- Doc 21
(21, 'Supply Chain', 'Keterlambatan bahan baku import', 'Tinggi', 'Sedang', 'Diversifikasi supplier lokal'),
(21, 'Teknis', 'Kerusakan mesin produksi utama', 'Sangat Tinggi', 'Rendah', 'Preventive maintenance mingguan'),
(21, 'SDM', 'Turnover karyawan ahli', 'Tinggi', 'Sedang', 'Program retensi dan bonus'),
-- Doc 22
(22, 'Supply Chain', 'Kenaikan harga bahan baku', 'Sedang', 'Tinggi', 'Hedging dan kontrak jangka panjang'),
(22, 'Keamanan', 'Cyber attack sistem ERP', 'Tinggi', 'Sedang', 'Upgrade firewall dan backup harian');

-- =====================================================
-- MANAGEMENT DOCUMENTS (30 documents)
-- =====================================================

INSERT INTO documents (company_id, document_number, type, title, period, date, notes) VALUES
(1, 'MGT/2023/0001', 'management', 'Laporan Manajemen Q1 2023', 'Q1 2023', '2023-03-31', 'Quarterly strategic review'),
(1, 'MGT/2023/0002', 'management', 'Laporan Manajemen Q2 2023', 'Q2 2023', '2023-06-30', 'Quarterly strategic review'),
(1, 'MGT/2023/0003', 'management', 'Laporan Manajemen Q3 2023', 'Q3 2023', '2023-09-30', 'Quarterly strategic review'),
(1, 'MGT/2023/0004', 'management', 'Laporan Manajemen Q4 2023', 'Q4 2023', '2023-12-31', 'Year-end review'),
(2, 'MGT/2023/0005', 'management', 'Laporan Manajemen Q1 2023', 'Q1 2023', '2023-03-31', 'Quarterly strategic review'),
(2, 'MGT/2023/0006', 'management', 'Laporan Manajemen Q2 2023', 'Q2 2023', '2023-06-30', 'Quarterly strategic review'),
(3, 'MGT/2023/0007', 'management', 'Laporan Manajemen Q1 2023', 'Q1 2023', '2023-03-31', 'Quarterly strategic review'),
(3, 'MGT/2023/0008', 'management', 'Laporan Manajemen Q2 2023', 'Q2 2023', '2023-06-30', 'Quarterly strategic review'),
(4, 'MGT/2023/0009', 'management', 'Laporan Manajemen Q1 2023', 'Q1 2023', '2023-03-31', 'Quarterly strategic review'),
(5, 'MGT/2023/0010', 'management', 'Laporan Manajemen Q1 2023', 'Q1 2023', '2023-03-31', 'Quarterly strategic review');

-- Management Summaries (for first 10 mgmt documents)
INSERT INTO management_summaries (document_id, executive_summary, challenges, next_steps, achievements) VALUES
(31, 'Q1 2023 menunjukkan pertumbuhan solid 22% YoY dengan ekspansi pasar regional yang berhasil. Digitalisasi internal mencapai 65% completion rate.', 
'["Fluktuasi nilai tukar rupiah", "Kelangkaan talent digital", "Persaingan harga di pasar domestik"]',
'["Finalisasi akuisisi kompetitor regional", "Peluncuran produk baru kategori premium", "Ekspansi ke 3 kota tier-2"]',
'["Revenue growth 22% YoY", "Digitalisasi 65% selesai", "Sertifikasi ISO 27001"]'),

(32, 'Q2 2023 mempertahankan momentum dengan profit margin 24.8%. Inisiatif sustainability mencapai target carbon reduction 15%.', 
'["Kenaikan biaya energi", "Delay proyek infrastruktur IT", "Komplain produk meningkat 3%"]',
'["Implementasi ERP cloud-based", "Program customer loyalty v2.0", "Audit vendor supply chain"]',
'["Profit margin tertinggi dalam 3 tahun", "Carbon reduction 15%", "Customer satisfaction 4.7/5"]'),

(33, 'Q3 2023 fokus pada konsolidasi operasional dan efisiensi biaya. Berhasil menurunkan operating expense 8% tanpa mengurangi kualitas.', 
'["Penurunan demand pasar ekspor", "Turnover karyawan senior", "Keterlambatan sertifikasi produk baru"]',
'["Restrukturisasi divisi sales", "Program succession planning", "Penetrasi pasar B2B"]',
'["Operating expense turun 8%", "Retensi karyawan 92%", "Peluncuran 2 produk baru"]'),

(34, 'Q4 2023 menutup tahun dengan strong performance. Total revenue Rp 175T, net profit Rp 42T, mencapai 105% dari target tahunan.', 
'["Regulasi pajak baru", "Kompetitor global masuk pasar", "Infrastruktur logistik terbatas"]',
'["RUPS penentuan dividen", "Ekspansi pabrik fase 2", "Partnership strategis dengan tech startup"]',
'["Target tahunan tercapai 105%", "IPO anak perusahaan sukses", "Best Corporate Governance Award"]'),

(35, 'Q1 2023 manufacturing division mencapai production efficiency 91%. Implementasi lean manufacturing di 3 lini produksi berhasil.', 
'["Shortage komponen elektronik global", "Kenaikan upah minimum regional", "Aging machinery di plant B"]',
'["Investasi mesin baru Rp 50M", "Training lean six sigma batch 2", "Diversifikasi supplier Asia"]',
'["Production efficiency 91%", "Reject rate turun 40%", "Zero accident 180 hari"]');

-- Strategic Goals (Sample for docs 31-35, 5 goals each)
INSERT INTO strategic_goals (document_id, goal_name, progress_percentage, status, deadline) VALUES
-- Doc 31
(31, 'Ekspansi Pasar Regional (Vietnam & Thailand)', 75, 'On Track', '2023-12-31'),
(31, 'Digital Transformation Fase 2', 65, 'On Track', '2024-03-31'),
(31, 'Customer Satisfaction Score > 4.7', 80, 'Ahead', '2023-09-30'),
(31, 'Carbon Neutrality Initiative', 25, 'On Track', '2030-12-31'),
(31, 'R&D Produk Kategori Premium', 45, 'On Track', '2024-06-30'),
-- Doc 32
(32, 'Ekspansi Pasar Regional (Vietnam & Thailand)', 85, 'On Track', '2023-12-31'),
(32, 'Digital Transformation Fase 2', 75, 'On Track', '2024-03-31'),
(32, 'Customer Satisfaction Score > 4.7', 95, 'Ahead', '2023-09-30'),
(32, 'Carbon Neutrality Initiative', 35, 'On Track', '2030-12-31'),
(32, 'R&D Produk Kategori Premium', 60, 'On Track', '2024-06-30');

-- SWOT Analysis (Sample for docs 31-35)
INSERT INTO swot_analysis (document_id, analysis_type, content) VALUES
-- Doc 31
(31, 'strength', 'Market leader dengan 35% market share di segmen utama'),
(31, 'strength', 'Brand recognition kuat di kalangan enterprise'),
(31, 'strength', 'Cash position sangat sehat Rp 22T'),
(31, 'weakness', 'Ketergantungan pada satu supplier utama untuk komponen kritis'),
(31, 'weakness', 'Sistem IT legacy di beberapa cabang regional'),
(31, 'opportunity', 'Pertumbuhan ekonomi digital Indonesia 15% per tahun'),
(31, 'opportunity', 'Insentif pajak pemerintah untuk industri hijau'),
(31, 'threat', 'Masuknya kompetitor global dengan teknologi disruptif'),
(31, 'threat', 'Perubahan regulasi data privacy'),
-- Doc 32
(32, 'strength', 'Tim manajemen berpengalaman rata-rata 18 tahun'),
(32, 'strength', 'Jaringan distribusi mencakup 34 provinsi'),
(32, 'weakness', 'Proses approval yang terlalu birokratis'),
(32, 'opportunity', 'Ekspansi ke pasar ASEAN'),
(32, 'threat', 'Fluktuasi harga komoditas global');

-- Stakeholders (Sample for docs 31-35)
INSERT INTO stakeholders (document_id, name, role, involvement_level) VALUES
-- Doc 31
(31, 'Ir. Budi Santoso', 'Komisaris Utama', 'Strategic Oversight'),
(31, 'Sari Wijaya, MBA', 'CEO', 'Strategic Execution'),
(31, 'Dr. Andi Pratama', 'CTO', 'Technology Innovation'),
(31, 'Linda Hartono', 'CFO', 'Financial Management'),
(31, 'James Wilson', 'Lead Investor', 'Growth Monitoring'),
-- Doc 32
(32, 'Ir. Budi Santoso', 'Komisaris Utama', 'Strategic Oversight'),
(32, 'Sari Wijaya, MBA', 'CEO', 'Strategic Execution'),
(32, 'Dr. Andi Pratama', 'CTO', 'Technology Innovation'),
(32, 'Linda Hartono', 'CFO', 'Financial Management');

-- =====================================================
-- SUMMARY
-- =====================================================
-- Total Records Created:
-- - Companies: 10
-- - Documents: 40 (20 Financial, 10 Operational, 10 Management)
-- - Financial Summaries: 20
-- - Financial Breakdowns: ~50
-- - Cash Flows: 10
-- - Operational KPIs: 10
-- - Department Performance: ~15
-- - Inventory Status: ~8
-- - Operational Risks: ~5
-- - Management Summaries: 5
-- - Strategic Goals: ~10
-- - SWOT Analysis: ~14
-- - Stakeholders: ~9
-- =====================================================
