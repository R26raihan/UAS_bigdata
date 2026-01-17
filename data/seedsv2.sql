-- =====================================================
-- SEED DATA V2 - ALTERNATIVE DATASET
-- Data perusahaan dan dokumen yang berbeda dari seeds.sql
-- =====================================================

-- Insert 10 Different Companies
INSERT INTO companies (name, address, phone, email, logo_url) VALUES
('PT. Teknologi Nusantara Prima', 'Jl. MH Thamrin No. 88, Jakarta Pusat 10350', '+62 21 3927001', 'contact@teknusantara.id', NULL),
('PT. Sumber Rejeki Makmur', 'Jl. Ahmad Yani No. 150, Surabaya 60234', '+62 31 8521234', 'info@sumberrejeki.co.id', NULL),
('PT. Cahaya Bintang Elektronik', 'Jl. Soekarno Hatta No. 789, Bandung 40286', '+62 22 7531456', 'sales@cahayabintang.com', NULL),
('PT. Mega Konstruksi Utama', 'Jl. Gatot Subroto Kav 18, Jakarta Selatan 12930', '+62 21 5251567', 'project@megakonstruksi.co.id', NULL),
('PT. Sarana Medika Sejahtera', 'Jl. Diponegoro No. 45, Semarang 50241', '+62 24 8461678', 'admin@saranamedika.id', NULL),
('PT. Agro Pangan Nusantara', 'Jl. Raya Bogor KM 35, Cibinong 16916', '+62 21 8751789', 'info@agropangan.co.id', NULL),
('PT. Samudra Logistik Internasional', 'Jl. Yos Sudarso No. 200, Medan 20115', '+62 61 6851890', 'ops@samudralogistik.com', NULL),
('PT. Kreasi Digital Mandiri', 'Jl. Imam Bonjol No. 61, Denpasar 80119', '+62 361 2341901', 'hello@kreasidigital.id', NULL),
('PT. Permata Tambang Resources', 'Jl. Jend A Yani Km 36, Balikpapan 76127', '+62 542 7652012', 'mining@permatatambang.co.id', NULL),
('PT. Edukasi Cerdas Indonesia', 'Jl. Gajah Mada No. 19-26, Yogyakarta 55112', '+62 274 5882123', 'info@edukasicerdas.id', NULL);

-- =====================================================
-- FINANCIAL DOCUMENTS (20 documents - 2024 data)
-- =====================================================

INSERT INTO documents (company_id, document_number, type, title, period, date, notes) VALUES
-- Company 1 (Tech) - 2024 Monthly Reports
(1, 'FIN/2024/0101', 'financial', 'Laporan Keuangan Januari 2024', 'Januari 2024', '2024-01-31', 'Tech sector growth'),
(1, 'FIN/2024/0102', 'financial', 'Laporan Keuangan Februari 2024', 'Februari 2024', '2024-02-29', 'Tech sector growth'),
(1, 'FIN/2024/0103', 'financial', 'Laporan Keuangan Maret 2024', 'Maret 2024', '2024-03-31', 'Tech sector growth'),
(1, 'FIN/2024/0104', 'financial', 'Laporan Keuangan Q1 2024', 'Q1 2024', '2024-03-31', 'Quarterly consolidated'),
-- Company 2 (Trading) - 2024 Reports
(2, 'FIN/2024/0201', 'financial', 'Laporan Keuangan Januari 2024', 'Januari 2024', '2024-01-31', 'Trading performance'),
(2, 'FIN/2024/0202', 'financial', 'Laporan Keuangan Februari 2024', 'Februari 2024', '2024-02-29', 'Trading performance'),
(2, 'FIN/2024/0203', 'financial', 'Laporan Keuangan Q1 2024', 'Q1 2024', '2024-03-31', 'Quarterly review'),
-- Company 3 (Electronics) - 2024 Reports
(3, 'FIN/2024/0301', 'financial', 'Laporan Keuangan Januari 2024', 'Januari 2024', '2024-01-31', 'Electronics manufacturing'),
(3, 'FIN/2024/0302', 'financial', 'Laporan Keuangan Februari 2024', 'Februari 2024', '2024-02-29', 'Electronics manufacturing'),
(3, 'FIN/2024/0303', 'financial', 'Laporan Keuangan Maret 2024', 'Maret 2024', '2024-03-31', 'Electronics manufacturing'),
-- Company 4 (Construction) - 2024 Reports
(4, 'FIN/2024/0401', 'financial', 'Laporan Keuangan Q1 2024', 'Q1 2024', '2024-03-31', 'Construction projects'),
(4, 'FIN/2024/0402', 'financial', 'Laporan Keuangan Q2 2024', 'Q2 2024', '2024-06-30', 'Construction projects'),
-- Company 5 (Healthcare) - 2024 Reports
(5, 'FIN/2024/0501', 'financial', 'Laporan Keuangan Januari 2024', 'Januari 2024', '2024-01-31', 'Healthcare services'),
(5, 'FIN/2024/0502', 'financial', 'Laporan Keuangan Februari 2024', 'Februari 2024', '2024-02-29', 'Healthcare services'),
(5, 'FIN/2024/0503', 'financial', 'Laporan Keuangan Maret 2024', 'Maret 2024', '2024-03-31', 'Healthcare services'),
-- Company 6 (Agro) - 2024 Reports
(6, 'FIN/2024/0601', 'financial', 'Laporan Keuangan Q1 2024', 'Q1 2024', '2024-03-31', 'Agro business'),
(6, 'FIN/2024/0602', 'financial', 'Laporan Keuangan Q2 2024', 'Q2 2024', '2024-06-30', 'Agro business'),
-- Company 7 (Logistics) - 2024 Reports
(7, 'FIN/2024/0701', 'financial', 'Laporan Keuangan Januari 2024', 'Januari 2024', '2024-01-31', 'Logistics operations'),
(7, 'FIN/2024/0702', 'financial', 'Laporan Keuangan Februari 2024', 'Februari 2024', '2024-02-29', 'Logistics operations'),
(7, 'FIN/2024/0703', 'financial', 'Laporan Keuangan Q1 2024', 'Q1 2024', '2024-03-31', 'Quarterly summary');

-- Financial Summaries (for all 20 financial documents)
INSERT INTO financial_summaries (document_id, revenue, revenue_last_year, expenses, expenses_last_year, net_profit, net_profit_last_year, profit_margin, profit_margin_last_year) VALUES
-- Company 1 (Tech) - High growth, high margin
(1, 18500000000, 14200000000, 13900000000, 11500000000, 4600000000, 2700000000, 24.9, 19.0),
(2, 19800000000, 15100000000, 14800000000, 12200000000, 5000000000, 2900000000, 25.3, 19.2),
(3, 21200000000, 16500000000, 15700000000, 13100000000, 5500000000, 3400000000, 25.9, 20.6),
(4, 59500000000, 45800000000, 44400000000, 36800000000, 15100000000, 9000000000, 25.4, 19.6),
-- Company 2 (Trading) - Moderate growth, lower margin
(5, 25600000000, 22100000000, 22400000000, 19500000000, 3200000000, 2600000000, 12.5, 11.8),
(6, 27300000000, 23800000000, 23900000000, 21000000000, 3400000000, 2800000000, 12.5, 11.8),
(7, 78900000000, 68200000000, 69100000000, 60200000000, 9800000000, 8000000000, 12.4, 11.7),
-- Company 3 (Electronics) - Steady growth
(8, 32100000000, 28500000000, 26700000000, 24100000000, 5400000000, 4400000000, 16.8, 15.4),
(9, 34500000000, 30800000000, 28600000000, 26000000000, 5900000000, 4800000000, 17.1, 15.6),
(10, 36800000000, 32900000000, 30400000000, 27800000000, 6400000000, 5100000000, 17.4, 15.5),
-- Company 4 (Construction) - Project-based, variable
(11, 125000000000, 98000000000, 108000000000, 86000000000, 17000000000, 12000000000, 13.6, 12.2),
(12, 142000000000, 115000000000, 122000000000, 99000000000, 20000000000, 16000000000, 14.1, 13.9),
-- Company 5 (Healthcare) - Stable, high margin
(13, 15800000000, 13200000000, 11100000000, 9500000000, 4700000000, 3700000000, 29.7, 28.0),
(14, 16900000000, 14100000000, 11800000000, 10100000000, 5100000000, 4000000000, 30.2, 28.4),
(15, 18200000000, 15300000000, 12600000000, 10900000000, 5600000000, 4400000000, 30.8, 28.8),
-- Company 6 (Agro) - Seasonal variation
(16, 45600000000, 39800000000, 38200000000, 34100000000, 7400000000, 5700000000, 16.2, 14.3),
(17, 52300000000, 46100000000, 43500000000, 39200000000, 8800000000, 6900000000, 16.8, 15.0),
-- Company 7 (Logistics) - Volume-based
(18, 22400000000, 19100000000, 19600000000, 17200000000, 2800000000, 1900000000, 12.5, 9.9),
(19, 24100000000, 20600000000, 21000000000, 18500000000, 3100000000, 2100000000, 12.9, 10.2),
(20, 69800000000, 59200000000, 60900000000, 53400000000, 8900000000, 5800000000, 12.8, 9.8);

-- Financial Breakdowns - Revenue (Sample for docs 1-10)
INSERT INTO financial_breakdowns (document_id, category, amount, previous_amount, type) VALUES
-- Doc 1 (Tech)
(1, 'Software Licensing', 9250000000, 7100000000, 'revenue'),
(1, 'Cloud Services (SaaS)', 5550000000, 4260000000, 'revenue'),
(1, 'Consulting Services', 2775000000, 2130000000, 'revenue'),
(1, 'Training & Support', 925000000, 710000000, 'revenue'),
-- Doc 2 (Tech)
(2, 'Software Licensing', 9900000000, 7550000000, 'revenue'),
(2, 'Cloud Services (SaaS)', 5940000000, 4530000000, 'revenue'),
(2, 'Consulting Services', 2970000000, 2265000000, 'revenue'),
(2, 'Training & Support', 990000000, 755000000, 'revenue'),
-- Doc 5 (Trading)
(5, 'Penjualan Grosir', 15360000000, 13260000000, 'revenue'),
(5, 'Penjualan Retail', 7680000000, 6630000000, 'revenue'),
(5, 'Distribusi Regional', 2560000000, 2210000000, 'revenue'),
-- Doc 8 (Electronics)
(8, 'Komponen Elektronik', 19260000000, 17100000000, 'revenue'),
(8, 'Perakitan Produk', 9630000000, 8550000000, 'revenue'),
(8, 'After Sales Service', 3210000000, 2850000000, 'revenue');

-- Financial Breakdowns - Expenses (Sample for docs 1-5)
INSERT INTO financial_breakdowns (document_id, category, amount, percentage, type) VALUES
-- Doc 1 (Tech)
(1, 'Gaji & Tunjangan', 5560000000, 40.0, 'expense'),
(1, 'Server & Infrastructure', 2085000000, 15.0, 'expense'),
(1, 'Marketing Digital', 1390000000, 10.0, 'expense'),
(1, 'R&D', 2780000000, 20.0, 'expense'),
(1, 'Operasional', 2085000000, 15.0, 'expense'),
-- Doc 5 (Trading)
(5, 'Pembelian Barang Dagang', 11200000000, 50.0, 'expense'),
(5, 'Gaji Karyawan', 4480000000, 20.0, 'expense'),
(5, 'Sewa Gudang & Toko', 2240000000, 10.0, 'expense'),
(5, 'Transportasi & Logistik', 2240000000, 10.0, 'expense'),
(5, 'Marketing & Promosi', 2240000000, 10.0, 'expense');

-- Cash Flow (Sample for docs 1-10)
INSERT INTO financial_cash_flows (document_id, operating_cash, investing_cash, financing_cash, beginning_cash, ending_cash) VALUES
(1, 5200000000, -1800000000, -900000000, 8500000000, 11000000000),
(2, 5600000000, -2000000000, -1000000000, 11000000000, 13600000000),
(3, 6100000000, -2200000000, -1100000000, 13600000000, 16400000000),
(4, 16900000000, -6000000000, -3000000000, 8500000000, 16400000000),
(5, 3800000000, -1200000000, -600000000, 12000000000, 14000000000),
(6, 4000000000, -1300000000, -700000000, 14000000000, 16000000000),
(7, 11600000000, -3700000000, -1900000000, 12000000000, 18000000000),
(8, 6200000000, -2100000000, -1100000000, 15000000000, 18000000000),
(9, 6700000000, -2300000000, -1200000000, 18000000000, 21200000000),
(10, 7200000000, -2500000000, -1300000000, 21200000000, 24600000000);

-- =====================================================
-- OPERATIONAL DOCUMENTS (15 documents)
-- =====================================================

INSERT INTO documents (company_id, document_number, type, title, period, date, notes) VALUES
(1, 'OPS/2024/0101', 'operational', 'Laporan Operasional Januari 2024', 'Januari 2024', '2024-01-31', 'Tech operations'),
(1, 'OPS/2024/0102', 'operational', 'Laporan Operasional Februari 2024', 'Februari 2024', '2024-02-29', 'Tech operations'),
(2, 'OPS/2024/0201', 'operational', 'Laporan Operasional Januari 2024', 'Januari 2024', '2024-01-31', 'Trading operations'),
(2, 'OPS/2024/0202', 'operational', 'Laporan Operasional Februari 2024', 'Februari 2024', '2024-02-29', 'Trading operations'),
(3, 'OPS/2024/0301', 'operational', 'Laporan Operasional Januari 2024', 'Januari 2024', '2024-01-31', 'Manufacturing ops'),
(4, 'OPS/2024/0401', 'operational', 'Laporan Operasional Q1 2024', 'Q1 2024', '2024-03-31', 'Construction projects'),
(5, 'OPS/2024/0501', 'operational', 'Laporan Operasional Januari 2024', 'Januari 2024', '2024-01-31', 'Healthcare services'),
(6, 'OPS/2024/0601', 'operational', 'Laporan Operasional Q1 2024', 'Q1 2024', '2024-03-31', 'Agro production'),
(7, 'OPS/2024/0701', 'operational', 'Laporan Operasional Januari 2024', 'Januari 2024', '2024-01-31', 'Logistics delivery'),
(8, 'OPS/2024/0801', 'operational', 'Laporan Operasional Januari 2024', 'Januari 2024', '2024-01-31', 'Digital services'),
(9, 'OPS/2024/0901', 'operational', 'Laporan Operasional Q1 2024', 'Q1 2024', '2024-03-31', 'Mining operations'),
(10, 'OPS/2024/1001', 'operational', 'Laporan Operasional Januari 2024', 'Januari 2024', '2024-01-31', 'Education services'),
(3, 'OPS/2024/0302', 'operational', 'Laporan Operasional Februari 2024', 'Februari 2024', '2024-02-29', 'Manufacturing ops'),
(5, 'OPS/2024/0502', 'operational', 'Laporan Operasional Februari 2024', 'Februari 2024', '2024-02-29', 'Healthcare services'),
(7, 'OPS/2024/0702', 'operational', 'Laporan Operasional Februari 2024', 'Februari 2024', '2024-02-29', 'Logistics delivery');

-- Operational KPIs (for all 15 operational documents)
INSERT INTO operational_kpis (document_id, productivity_score, efficiency_score, quality_score, on_time_delivery_score) VALUES
(21, 93.2, 95.8, 97.5, 94.3),
(22, 94.5, 96.2, 98.1, 95.7),
(23, 78.5, 82.3, 88.9, 81.2),
(24, 80.2, 84.1, 90.3, 83.5),
(25, 88.7, 91.5, 94.2, 89.8),
(26, 76.3, 79.8, 85.6, 78.9),
(27, 96.8, 98.2, 99.1, 97.5),
(28, 82.1, 86.7, 91.3, 84.6),
(29, 91.5, 93.8, 96.2, 92.7),
(30, 89.3, 92.1, 95.4, 90.8),
(31, 71.2, 75.6, 82.3, 73.8),
(32, 94.7, 96.9, 98.6, 95.2),
(33, 89.9, 92.6, 95.1, 91.3),
(34, 97.2, 98.8, 99.3, 98.1),
(35, 92.8, 94.5, 97.2, 93.6);

-- Department Performance (Sample for docs 21-30, varied departments)
INSERT INTO department_performance (document_id, department_name, target_value, actual_value, achievement_rate) VALUES
-- Doc 21 (Tech - Software Development)
(21, 'Development Team Alpha', 120, 135, 112.5),
(21, 'Development Team Beta', 100, 108, 108.0),
(21, 'QA & Testing', 80, 88, 110.0),
(21, 'DevOps', 50, 54, 108.0),
(21, 'Customer Support', 300, 315, 105.0),
-- Doc 23 (Trading - Sales)
(23, 'Sales Region Jakarta', 500, 485, 97.0),
(23, 'Sales Region Surabaya', 400, 420, 105.0),
(23, 'Sales Region Medan', 300, 285, 95.0),
(23, 'Warehouse Operations', 2000, 2100, 105.0),
-- Doc 25 (Electronics - Production)
(25, 'Assembly Line 1', 800, 850, 106.3),
(25, 'Assembly Line 2', 750, 720, 96.0),
(25, 'Quality Control', 200, 210, 105.0),
(25, 'Packaging', 800, 840, 105.0),
-- Doc 27 (Healthcare - Patient Services)
(27, 'Outpatient Services', 1500, 1620, 108.0),
(27, 'Emergency Room', 400, 425, 106.3),
(27, 'Laboratory', 800, 850, 106.3),
(27, 'Radiology', 300, 315, 105.0);

-- Inventory Status (Sample for docs 21-30)
INSERT INTO inventory_status (document_id, item_name, current_stock, status, restock_date) VALUES
-- Doc 21 (Tech)
(21, 'Server Hardware', '45 unit', 'Aman', '2024-06-15'),
(21, 'Network Equipment', '120 unit', 'Aman', '2024-05-20'),
(21, 'Laptop Development', '15 unit', 'Menipis', '2024-02-10'),
-- Doc 23 (Trading)
(23, 'Produk Kategori A', '8,500 unit', 'Aman', '2024-04-01'),
(23, 'Produk Kategori B', '2,200 unit', 'Menipis', '2024-02-15'),
(23, 'Produk Kategori C', '450 unit', 'Kritis', '2024-02-05'),
-- Doc 25 (Electronics)
(25, 'PCB Components', '12,000 unit', 'Aman', '2024-05-01'),
(25, 'Microchip Type X', '850 unit', 'Kritis', '2024-02-08'),
(25, 'Casing Material', '5,500 unit', 'Aman', '2024-04-15'),
-- Doc 27 (Healthcare)
(27, 'Medical Supplies - Disposable', '25,000 unit', 'Aman', '2024-03-01'),
(27, 'Pharmaceutical Stock A', '1,200 box', 'Menipis', '2024-02-12'),
(27, 'Laboratory Reagents', '350 liter', 'Kritis', '2024-02-07');

-- Operational Risks (Sample for docs 21-30)
INSERT INTO operational_risks (document_id, category, risk_issue, impact_level, probability_level, mitigation_plan) VALUES
-- Doc 21 (Tech)
(21, 'Teknologi', 'Server downtime akibat overload', 'Tinggi', 'Sedang', 'Load balancing dan cloud backup'),
(21, 'SDM', 'Brain drain developer senior', 'Sangat Tinggi', 'Sedang', 'Stock option dan career path jelas'),
(21, 'Keamanan', 'Data breach customer', 'Sangat Tinggi', 'Rendah', 'Penetration testing bulanan'),
-- Doc 23 (Trading)
(23, 'Supply Chain', 'Disruption pasokan dari supplier utama', 'Tinggi', 'Sedang', 'Multi-supplier strategy'),
(23, 'Pasar', 'Penurunan daya beli konsumen', 'Sedang', 'Tinggi', 'Diversifikasi produk dan segmen'),
-- Doc 25 (Electronics)
(25, 'Produksi', 'Shortage komponen global', 'Sangat Tinggi', 'Tinggi', 'Buffer stock 3 bulan'),
(25, 'Kualitas', 'Defect rate meningkat', 'Tinggi', 'Rendah', 'Six Sigma implementation'),
-- Doc 27 (Healthcare)
(27, 'Regulasi', 'Perubahan standar akreditasi', 'Tinggi', 'Sedang', 'Tim compliance dedicated'),
(27, 'Operasional', 'Kekurangan tenaga medis spesialis', 'Sangat Tinggi', 'Tinggi', 'Partnership dengan universitas');

-- =====================================================
-- MANAGEMENT DOCUMENTS (15 documents)
-- =====================================================

INSERT INTO documents (company_id, document_number, type, title, period, date, notes) VALUES
(1, 'MGT/2024/0101', 'management', 'Laporan Manajemen Q1 2024', 'Q1 2024', '2024-03-31', 'Strategic review'),
(2, 'MGT/2024/0201', 'management', 'Laporan Manajemen Q1 2024', 'Q1 2024', '2024-03-31', 'Strategic review'),
(3, 'MGT/2024/0301', 'management', 'Laporan Manajemen Q1 2024', 'Q1 2024', '2024-03-31', 'Strategic review'),
(4, 'MGT/2024/0401', 'management', 'Laporan Manajemen Q1 2024', 'Q1 2024', '2024-03-31', 'Strategic review'),
(5, 'MGT/2024/0501', 'management', 'Laporan Manajemen Q1 2024', 'Q1 2024', '2024-03-31', 'Strategic review'),
(6, 'MGT/2024/0601', 'management', 'Laporan Manajemen Q1 2024', 'Q1 2024', '2024-03-31', 'Strategic review'),
(7, 'MGT/2024/0701', 'management', 'Laporan Manajemen Q1 2024', 'Q1 2024', '2024-03-31', 'Strategic review'),
(8, 'MGT/2024/0801', 'management', 'Laporan Manajemen Q1 2024', 'Q1 2024', '2024-03-31', 'Strategic review'),
(9, 'MGT/2024/0901', 'management', 'Laporan Manajemen Q1 2024', 'Q1 2024', '2024-03-31', 'Strategic review'),
(10, 'MGT/2024/1001', 'management', 'Laporan Manajemen Q1 2024', 'Q1 2024', '2024-03-31', 'Strategic review'),
(1, 'MGT/2024/0102', 'management', 'Laporan Manajemen Q2 2024', 'Q2 2024', '2024-06-30', 'Mid-year review'),
(2, 'MGT/2024/0202', 'management', 'Laporan Manajemen Q2 2024', 'Q2 2024', '2024-06-30', 'Mid-year review'),
(3, 'MGT/2024/0302', 'management', 'Laporan Manajemen Q2 2024', 'Q2 2024', '2024-06-30', 'Mid-year review'),
(4, 'MGT/2024/0402', 'management', 'Laporan Manajemen Q2 2024', 'Q2 2024', '2024-06-30', 'Mid-year review'),
(5, 'MGT/2024/0502', 'management', 'Laporan Manajemen Q2 2024', 'Q2 2024', '2024-06-30', 'Mid-year review');

-- Management Summaries (for all 15 management documents)
INSERT INTO management_summaries (document_id, executive_summary, challenges, next_steps, achievements) VALUES
(36, 'Q1 2024 menandai era baru transformasi digital dengan pertumbuhan revenue 30% YoY. Cloud migration mencapai 85% completion dengan zero downtime.', 
'["Kompetisi ketat dari startup fintech", "Talent acquisition di bidang AI/ML", "Skalabilitas infrastruktur cloud"]',
'["Akuisisi startup AI lokal", "Ekspansi ke pasar enterprise", "Launch platform API terbuka"]',
'["Revenue growth 30% YoY", "Cloud migration 85%", "Customer base naik 45%"]'),

(37, 'Q1 2024 trading division mencapai volume transaksi tertinggi dengan Rp 78.9T. Ekspansi ke 15 kota baru berhasil dilakukan.', 
'["Margin tertekan kompetisi e-commerce", "Biaya logistik meningkat 12%", "Regulasi perdagangan online baru"]',
'["Optimasi supply chain dengan AI", "Partnership dengan marketplace", "Private label development"]',
'["Volume transaksi record high", "Ekspansi 15 kota", "Market share naik 3.2%"]'),

(38, 'Q1 2024 electronics manufacturing mencapai production efficiency 91.5%. Investasi automation Rp 120M mulai memberikan hasil.', 
'["Shortage chip global berlanjut", "Kenaikan biaya energi 18%", "Persaingan harga dari China"]',
'["Diversifikasi supplier chip", "Solar panel installation", "Focus on premium segment"]',
'["Production efficiency 91.5%", "Automation ROI 15%", "Export growth 28%"]'),

(39, 'Q1 2024 construction projects senilai Rp 2.5T berhasil diselesaikan tepat waktu. Backlog order mencapai Rp 8.7T untuk 2024-2025.', 
'["Kenaikan harga material 22%", "Shortage tenaga ahli konstruksi", "Weather delays di Q1"]',
'["Hedging material prices", "Training center establishment", "BIM technology adoption"]',
'["Projects completed Rp 2.5T", "Backlog Rp 8.7T", "Safety record 365 days"]'),

(40, 'Q1 2024 healthcare services melayani 48,500 pasien dengan patient satisfaction 4.8/5. Telemedicine adoption mencapai 35%.', 
'["Kekurangan dokter spesialis", "Biaya medical equipment tinggi", "Regulasi BPJS yang ketat"]',
'["Partnership dengan FK universitas", "Leasing equipment", "Expand telemedicine services"]',
'["Patient satisfaction 4.8/5", "Telemedicine 35%", "Accreditation KARS Paripurna"]'),

(41, 'Q1 2024 agro business mencapai harvest 125,000 ton dengan kualitas premium 78%. Organic certification untuk 40% lahan berhasil diperoleh.', 
'["Cuaca ekstrem El Nino", "Harga pupuk naik 25%", "Pest outbreak di region timur"]',
'["Climate-smart agriculture", "Organic fertilizer production", "Crop insurance expansion"]',
'["Harvest 125,000 ton", "Organic cert 40%", "Export approval EU market"]'),

(42, 'Q1 2024 logistics operations menangani 2.8 juta shipment dengan on-time delivery 92.7%. Fleet electrification mencapai 15%.', 
'["Fuel cost volatility", "Driver shortage 18%", "Last-mile delivery challenges"]',
'["EV fleet expansion", "Driver training academy", "Micro-fulfillment centers"]',
'["Shipment 2.8M", "On-time 92.7%", "EV fleet 15%"]'),

(43, 'Q1 2024 digital creative services revenue Rp 59.5T dengan client retention 94%. International projects mencapai 22% dari total revenue.', 
'["Project scope creep", "Talent retention di creative team", "Payment terms negotiation"]',
'["Project management tools upgrade", "Stock option program", "Retainer model expansion"]',
'["Revenue Rp 59.5T", "Client retention 94%", "International 22%"]'),

(44, 'Q1 2024 mining operations menghasilkan 450,000 ton dengan safety incident rate terendah dalam 5 tahun. ESG compliance 96%.', 
'["Commodity price fluctuation", "Environmental permit renewal", "Community relations"]',
'["Price hedging strategy", "CSR program enhancement", "Reclamation acceleration"]',
'["Production 450K ton", "Safety record best", "ESG compliance 96%"]'),

(45, 'Q1 2024 education services melayani 12,500 siswa dengan learning outcome improvement 18%. Digital learning platform adoption 88%.', 
'["Teacher quality inconsistency", "Infrastructure aging", "Competition from online platforms"]',
'["Teacher certification program", "Campus renovation phase 2", "Hybrid learning model"]',
'["Students 12,500", "Learning outcome +18%", "Digital adoption 88%"]');

-- Strategic Goals (Sample for docs 36-45, 4 goals each)
INSERT INTO strategic_goals (document_id, goal_name, progress_percentage, status, deadline) VALUES
-- Doc 36 (Tech)
(36, 'AI/ML Product Launch', 65, 'On Track', '2024-09-30'),
(36, 'Enterprise Client Acquisition 50+', 42, 'On Track', '2024-12-31'),
(36, 'Cloud Infrastructure 100%', 85, 'Ahead', '2024-06-30'),
(36, 'IPO Preparation', 30, 'On Track', '2025-12-31'),
-- Doc 37 (Trading)
(37, 'Omnichannel Integration', 55, 'On Track', '2024-12-31'),
(37, 'Private Label 20% Revenue', 25, 'On Track', '2025-06-30'),
(37, 'Warehouse Automation', 40, 'At Risk', '2024-09-30'),
(37, 'Sustainability Packaging 100%', 60, 'On Track', '2024-12-31'),
-- Doc 38 (Electronics)
(38, 'Production Capacity +30%', 48, 'On Track', '2024-12-31'),
(38, 'Export Market Share 35%', 52, 'On Track', '2024-12-31'),
(38, 'R&D IoT Products', 38, 'On Track', '2025-03-31'),
(38, 'ISO 14001 Certification', 75, 'Ahead', '2024-06-30');

-- SWOT Analysis (Sample for docs 36-45)
INSERT INTO swot_analysis (document_id, analysis_type, content) VALUES
-- Doc 36 (Tech)
(36, 'strength', 'Teknologi proprietary AI/ML yang unggul'),
(36, 'strength', 'Tim engineering 200+ developer berpengalaman'),
(36, 'strength', 'Cash runway 24 bulan tanpa funding'),
(36, 'weakness', 'Brand awareness rendah di segment enterprise'),
(36, 'weakness', 'Sales team masih terbatas 15 orang'),
(36, 'opportunity', 'Digital transformation budget perusahaan naik 40%'),
(36, 'opportunity', 'Government smart city projects'),
(36, 'threat', 'Big tech global masuk pasar Indonesia'),
(36, 'threat', 'Regulasi data localization'),
-- Doc 37 (Trading)
(37, 'strength', 'Network distribusi 150+ kota'),
(37, 'strength', 'Relationship supplier 500+ vendor'),
(37, 'weakness', 'Sistem IT masih partially manual'),
(37, 'opportunity', 'E-commerce penetration masih 12%'),
(37, 'threat', 'Marketplace dominance'),
-- Doc 38 (Electronics)
(38, 'strength', 'Manufacturing capacity 1.2M unit/tahun'),
(38, 'strength', 'Quality certification ISO 9001, 14001'),
(38, 'weakness', 'Dependency pada imported chips 80%'),
(38, 'opportunity', 'Government incentive untuk local manufacturing'),
(38, 'threat', 'Trade war impact on component supply');

-- Stakeholders (Sample for docs 36-45)
INSERT INTO stakeholders (document_id, name, role, involvement_level) VALUES
-- Doc 36 (Tech)
(36, 'Dr. Ahmad Fauzi', 'CEO & Founder', 'Strategic Direction'),
(36, 'Sarah Kusuma, M.Sc', 'CTO', 'Technology Leadership'),
(36, 'Benny Wijaya', 'CFO', 'Financial Strategy'),
(36, 'Linda Chen', 'VP Engineering', 'Product Development'),
-- Doc 37 (Trading)
(37, 'Hendra Gunawan', 'Direktur Utama', 'Business Strategy'),
(37, 'Siti Nurhaliza', 'Direktur Operasional', 'Operations Management'),
(37, 'Rudi Hartono', 'Direktur Keuangan', 'Financial Control'),
-- Doc 38 (Electronics)
(38, 'Ir. Bambang Suryanto', 'President Director', 'Corporate Strategy'),
(38, 'Dewi Lestari, MBA', 'Manufacturing Director', 'Production Excellence'),
(38, 'Kevin Tan', 'Export Director', 'International Business'),
-- Doc 39 (Construction)
(39, 'Ir. Agus Salim, MT', 'CEO', 'Project Oversight'),
(39, 'Rina Kusumawati', 'COO', 'Operational Excellence'),
(39, 'Darmawan Putra', 'Project Director', 'Delivery Management');

-- =====================================================
-- SUMMARY V2
-- =====================================================
-- Total Records Created:
-- - Companies: 10 (different from seeds.sql)
-- - Documents: 50 (20 Financial, 15 Operational, 15 Management)
-- - Financial Summaries: 20
-- - Financial Breakdowns: ~30
-- - Cash Flows: 10
-- - Operational KPIs: 15
-- - Department Performance: ~20
-- - Inventory Status: ~12
-- - Operational Risks: ~9
-- - Management Summaries: 10
-- - Strategic Goals: ~12
-- - SWOT Analysis: ~18
-- - Stakeholders: ~13
-- 
-- TOTAL ESTIMATED RECORDS: ~180+
-- =====================================================
