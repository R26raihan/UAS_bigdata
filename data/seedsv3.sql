-- =====================================================
-- SEED DATA V3 - 2025 DATASET
-- Data perusahaan tahun 2025 dengan industri berbeda
-- =====================================================

-- Insert 10 Companies (2025 Focus Industries)
INSERT INTO companies (name, address, phone, email, logo_url) VALUES
('PT. Quantum Computing Indonesia', 'Jl. Rasuna Said Kav X-2, Jakarta Selatan 12950', '+62 21 2987001', 'info@quantumid.co.id', NULL),
('PT. Green Energy Solutions', 'Jl. Sudirman Kav 71, Jakarta Pusat 10220', '+62 21 5741234', 'contact@greenenergy.id', NULL),
('PT. Biotech Pharma Nusantara', 'Jl. Prof Dr Satrio Kav 3-5, Jakarta Selatan 12940', '+62 21 5781456', 'info@biotechpharma.co.id', NULL),
('PT. Smart City Infrastructure', 'Jl. TB Simatupang Kav 1, Jakarta Selatan 12560', '+62 21 7501567', 'project@smartcity.id', NULL),
('PT. Fintech Digital Wallet', 'Jl. Jend Sudirman Kav 25, Jakarta Pusat 12920', '+62 21 5201678', 'support@digitalwallet.id', NULL),
('PT. Aerospace Engineering Indo', 'Kawasan Industri KIIC, Karawang 41361', '+62 267 6401789', 'info@aerospaceindo.co.id', NULL),
('PT. Robotics Automation Systems', 'Jl. BSD Boulevard, Tangerang Selatan 15345', '+62 21 5371890', 'sales@roboticsauto.id', NULL),
('PT. Cyber Security Guardian', 'Jl. HR Rasuna Said Blok X-5, Jakarta Selatan 12950', '+62 21 5251901', 'security@cyberguardian.id', NULL),
('PT. Blockchain Solutions Asia', 'Jl. Gatot Subroto Kav 32-34, Jakarta Selatan 12950', '+62 21 5262012', 'hello@blockchainsol.asia', NULL),
('PT. Virtual Reality Studios', 'Jl. Senopati No. 86, Jakarta Selatan 12190', '+62 21 7272123', 'studio@vrstudios.id', NULL);

-- =====================================================
-- FINANCIAL DOCUMENTS (25 documents - 2025 data)
-- =====================================================

INSERT INTO documents (company_id, document_number, type, title, period, date, notes) VALUES
-- Company 1 (Quantum Computing) - High-tech, high investment
(1, 'FIN/2025/Q001', 'financial', 'Laporan Keuangan Januari 2025', 'Januari 2025', '2025-01-31', 'R&D intensive period'),
(1, 'FIN/2025/Q002', 'financial', 'Laporan Keuangan Februari 2025', 'Februari 2025', '2025-02-28', 'R&D intensive period'),
(1, 'FIN/2025/Q003', 'financial', 'Laporan Keuangan Maret 2025', 'Maret 2025', '2025-03-31', 'R&D intensive period'),
(1, 'FIN/2025/Q004', 'financial', 'Laporan Keuangan Q1 2025', 'Q1 2025', '2025-03-31', 'First quarter consolidated'),
-- Company 2 (Green Energy) - Sustainable growth
(2, 'FIN/2025/G001', 'financial', 'Laporan Keuangan Januari 2025', 'Januari 2025', '2025-01-31', 'Renewable energy expansion'),
(2, 'FIN/2025/G002', 'financial', 'Laporan Keuangan Februari 2025', 'Februari 2025', '2025-02-28', 'Renewable energy expansion'),
(2, 'FIN/2025/G003', 'financial', 'Laporan Keuangan Q1 2025', 'Q1 2025', '2025-03-31', 'Quarterly performance'),
-- Company 3 (Biotech Pharma) - Healthcare innovation
(3, 'FIN/2025/B001', 'financial', 'Laporan Keuangan Januari 2025', 'Januari 2025', '2025-01-31', 'Drug development phase'),
(3, 'FIN/2025/B002', 'financial', 'Laporan Keuangan Februari 2025', 'Februari 2025', '2025-02-28', 'Drug development phase'),
(3, 'FIN/2025/B003', 'financial', 'Laporan Keuangan Maret 2025', 'Maret 2025', '2025-03-31', 'Drug development phase'),
(3, 'FIN/2025/B004', 'financial', 'Laporan Keuangan Q1 2025', 'Q1 2025', '2025-03-31', 'Quarterly review'),
-- Company 4 (Smart City) - Infrastructure
(4, 'FIN/2025/S001', 'financial', 'Laporan Keuangan Q1 2025', 'Q1 2025', '2025-03-31', 'Smart city projects'),
(4, 'FIN/2025/S002', 'financial', 'Laporan Keuangan Q2 2025', 'Q2 2025', '2025-06-30', 'Smart city projects'),
-- Company 5 (Fintech) - Digital finance
(5, 'FIN/2025/F001', 'financial', 'Laporan Keuangan Januari 2025', 'Januari 2025', '2025-01-31', 'Digital wallet growth'),
(5, 'FIN/2025/F002', 'financial', 'Laporan Keuangan Februari 2025', 'Februari 2025', '2025-02-28', 'Digital wallet growth'),
(5, 'FIN/2025/F003', 'financial', 'Laporan Keuangan Maret 2025', 'Maret 2025', '2025-03-31', 'Digital wallet growth'),
(5, 'FIN/2025/F004', 'financial', 'Laporan Keuangan Q1 2025', 'Q1 2025', '2025-03-31', 'Quarterly fintech'),
-- Company 6 (Aerospace) - Engineering
(6, 'FIN/2025/A001', 'financial', 'Laporan Keuangan Q1 2025', 'Q1 2025', '2025-03-31', 'Aerospace manufacturing'),
-- Company 7 (Robotics) - Automation
(7, 'FIN/2025/R001', 'financial', 'Laporan Keuangan Januari 2025', 'Januari 2025', '2025-01-31', 'Robotics deployment'),
(7, 'FIN/2025/R002', 'financial', 'Laporan Keuangan Februari 2025', 'Februari 2025', '2025-02-28', 'Robotics deployment'),
(7, 'FIN/2025/R003', 'financial', 'Laporan Keuangan Q1 2025', 'Q1 2025', '2025-03-31', 'Quarterly automation'),
-- Company 8 (Cyber Security)
(8, 'FIN/2025/C001', 'financial', 'Laporan Keuangan Januari 2025', 'Januari 2025', '2025-01-31', 'Security services'),
(8, 'FIN/2025/C002', 'financial', 'Laporan Keuangan Q1 2025', 'Q1 2025', '2025-03-31', 'Quarterly security'),
-- Company 9 (Blockchain)
(9, 'FIN/2025/BC001', 'financial', 'Laporan Keuangan Q1 2025', 'Q1 2025', '2025-03-31', 'Blockchain solutions'),
-- Company 10 (VR Studios)
(10, 'FIN/2025/V001', 'financial', 'Laporan Keuangan Januari 2025', 'Januari 2025', '2025-01-31', 'VR content production');

-- Financial Summaries (for all 25 financial documents)
INSERT INTO financial_summaries (document_id, revenue, revenue_last_year, expenses, expenses_last_year, net_profit, net_profit_last_year, profit_margin, profit_margin_last_year) VALUES
-- Company 1 (Quantum Computing) - High R&D, negative profit initially
(1, 8500000000, 5200000000, 12300000000, 9800000000, -3800000000, -4600000000, -44.7, -88.5),
(2, 9200000000, 5800000000, 13100000000, 10500000000, -3900000000, -4700000000, -42.4, -81.0),
(3, 10100000000, 6500000000, 13800000000, 11200000000, -3700000000, -4700000000, -36.6, -72.3),
(4, 27800000000, 17500000000, 39200000000, 31500000000, -11400000000, -14000000000, -41.0, -80.0),
-- Company 2 (Green Energy) - Growing profitability
(5, 42300000000, 35100000000, 36500000000, 31200000000, 5800000000, 3900000000, 13.7, 11.1),
(6, 45800000000, 38200000000, 39200000000, 33800000000, 6600000000, 4400000000, 14.4, 11.5),
(7, 132400000000, 110500000000, 113900000000, 98200000000, 18500000000, 12300000000, 14.0, 11.1),
-- Company 3 (Biotech Pharma) - High margin healthcare
(8, 28700000000, 22100000000, 18900000000, 15800000000, 9800000000, 6300000000, 34.1, 28.5),
(9, 31200000000, 24500000000, 20400000000, 17200000000, 10800000000, 7300000000, 34.6, 29.8),
(10, 33900000000, 26800000000, 22100000000, 18700000000, 11800000000, 8100000000, 34.8, 30.2),
(11, 93800000000, 73400000000, 61400000000, 51700000000, 32400000000, 21700000000, 34.5, 29.6),
-- Company 4 (Smart City) - Large infrastructure projects
(12, 285000000000, 215000000000, 248000000000, 189000000000, 37000000000, 26000000000, 13.0, 12.1),
(13, 325000000000, 255000000000, 281000000000, 223000000000, 44000000000, 32000000000, 13.5, 12.5),
-- Company 5 (Fintech) - Transaction-based, high volume
(14, 52100000000, 38200000000, 41700000000, 32400000000, 10400000000, 5800000000, 20.0, 15.2),
(15, 56800000000, 42100000000, 45400000000, 35700000000, 11400000000, 6400000000, 20.1, 15.2),
(16, 61500000000, 46300000000, 49100000000, 39200000000, 12400000000, 7100000000, 20.2, 15.3),
(17, 170400000000, 126600000000, 136200000000, 107300000000, 34200000000, 19300000000, 20.1, 15.2),
-- Company 6 (Aerospace) - High-value, low volume
(18, 178000000000, 142000000000, 156000000000, 128000000000, 22000000000, 14000000000, 12.4, 9.9),
-- Company 7 (Robotics) - Growing automation market
(19, 38500000000, 28900000000, 30800000000, 24700000000, 7700000000, 4200000000, 20.0, 14.5),
(20, 42300000000, 32100000000, 33800000000, 27400000000, 8500000000, 4700000000, 20.1, 14.6),
(21, 123100000000, 93200000000, 98400000000, 79600000000, 24700000000, 13600000000, 20.1, 14.6),
-- Company 8 (Cyber Security) - Subscription-based
(22, 24600000000, 18200000000, 17200000000, 13500000000, 7400000000, 4700000000, 30.1, 25.8),
(23, 75300000000, 56100000000, 52600000000, 41800000000, 22700000000, 14300000000, 30.1, 25.5),
-- Company 9 (Blockchain) - Emerging technology
(24, 18900000000, 12400000000, 16100000000, 11200000000, 2800000000, 1200000000, 14.8, 9.7),
-- Company 10 (VR Studios) - Content creation
(25, 15700000000, 11200000000, 13300000000, 10100000000, 2400000000, 1100000000, 15.3, 9.8);

-- Financial Breakdowns - Revenue (Sample for docs 1-10)
INSERT INTO financial_breakdowns (document_id, category, amount, previous_amount, type) VALUES
-- Doc 1 (Quantum Computing)
(1, 'Quantum Computing Services', 4250000000, 2600000000, 'revenue'),
(1, 'Research Grants & Funding', 2550000000, 1560000000, 'revenue'),
(1, 'Consulting Services', 1275000000, 780000000, 'revenue'),
(1, 'IP Licensing', 425000000, 260000000, 'revenue'),
-- Doc 5 (Green Energy)
(5, 'Solar Panel Installation', 16920000000, 14040000000, 'revenue'),
(5, 'Wind Energy Projects', 12690000000, 10530000000, 'revenue'),
(5, 'Energy Storage Systems', 8460000000, 7020000000, 'revenue'),
(5, 'Maintenance Services', 4230000000, 3510000000, 'revenue'),
-- Doc 8 (Biotech Pharma)
(8, 'Pharmaceutical Products', 17220000000, 13260000000, 'revenue'),
(8, 'Clinical Trial Services', 5740000000, 4420000000, 'revenue'),
(8, 'Biotech Research', 4305000000, 3315000000, 'revenue'),
(8, 'Licensing Revenue', 1435000000, 1105000000, 'revenue'),
-- Doc 14 (Fintech)
(14, 'Transaction Fees', 26050000000, 19100000000, 'revenue'),
(14, 'Merchant Services', 15630000000, 11460000000, 'revenue'),
(14, 'Interest Income', 7815000000, 5730000000, 'revenue'),
(14, 'Premium Subscriptions', 2605000000, 1910000000, 'revenue');

-- Financial Breakdowns - Expenses (Sample for docs 1-5)
INSERT INTO financial_breakdowns (document_id, category, amount, percentage, type) VALUES
-- Doc 1 (Quantum Computing)
(1, 'R&D Quantum Hardware', 4920000000, 40.0, 'expense'),
(1, 'Scientist Salaries', 3690000000, 30.0, 'expense'),
(1, 'Lab Equipment & Facilities', 2460000000, 20.0, 'expense'),
(1, 'Patent & IP Legal', 1230000000, 10.0, 'expense'),
-- Doc 5 (Green Energy)
(5, 'Solar Panel Procurement', 14600000000, 40.0, 'expense'),
(5, 'Installation Labor', 7300000000, 20.0, 'expense'),
(5, 'Engineering & Design', 5475000000, 15.0, 'expense'),
(5, 'Project Management', 3650000000, 10.0, 'expense'),
(5, 'Marketing & Sales', 5475000000, 15.0, 'expense');

-- Cash Flow (Sample for docs 1-10)
INSERT INTO financial_cash_flows (document_id, operating_cash, investing_cash, financing_cash, beginning_cash, ending_cash) VALUES
(1, -2800000000, -3500000000, 8000000000, 12000000000, 13700000000),
(2, -2900000000, -3800000000, 0, 13700000000, 7000000000),
(3, -2700000000, -4000000000, 10000000000, 7000000000, 10300000000),
(4, -8400000000, -11300000000, 18000000000, 12000000000, 10300000000),
(5, 6500000000, -8500000000, 5000000000, 18000000000, 21000000000),
(6, 7200000000, -9200000000, 0, 21000000000, 19000000000),
(7, 20200000000, -26400000000, 5000000000, 18000000000, 16800000000),
(8, 11000000000, -3800000000, -2000000000, 25000000000, 30200000000),
(9, 12100000000, -4200000000, -2200000000, 30200000000, 35900000000),
(10, 13200000000, -4600000000, -2400000000, 35900000000, 42100000000);

-- =====================================================
-- OPERATIONAL DOCUMENTS (15 documents)
-- =====================================================

INSERT INTO documents (company_id, document_number, type, title, period, date, notes) VALUES
(1, 'OPS/2025/Q001', 'operational', 'Laporan Operasional Januari 2025', 'Januari 2025', '2025-01-31', 'Quantum lab operations'),
(2, 'OPS/2025/G001', 'operational', 'Laporan Operasional Januari 2025', 'Januari 2025', '2025-01-31', 'Energy installation'),
(3, 'OPS/2025/B001', 'operational', 'Laporan Operasional Januari 2025', 'Januari 2025', '2025-01-31', 'Clinical trials'),
(4, 'OPS/2025/S001', 'operational', 'Laporan Operasional Q1 2025', 'Q1 2025', '2025-03-31', 'Smart city deployment'),
(5, 'OPS/2025/F001', 'operational', 'Laporan Operasional Januari 2025', 'Januari 2025', '2025-01-31', 'Fintech platform'),
(6, 'OPS/2025/A001', 'operational', 'Laporan Operasional Q1 2025', 'Q1 2025', '2025-03-31', 'Aerospace production'),
(7, 'OPS/2025/R001', 'operational', 'Laporan Operasional Januari 2025', 'Januari 2025', '2025-01-31', 'Robotics assembly'),
(8, 'OPS/2025/C001', 'operational', 'Laporan Operasional Januari 2025', 'Januari 2025', '2025-01-31', 'Security monitoring'),
(9, 'OPS/2025/BC001', 'operational', 'Laporan Operasional Q1 2025', 'Q1 2025', '2025-03-31', 'Blockchain network'),
(10, 'OPS/2025/V001', 'operational', 'Laporan Operasional Januari 2025', 'Januari 2025', '2025-01-31', 'VR production'),
(1, 'OPS/2025/Q002', 'operational', 'Laporan Operasional Februari 2025', 'Februari 2025', '2025-02-28', 'Quantum research'),
(2, 'OPS/2025/G002', 'operational', 'Laporan Operasional Februari 2025', 'Februari 2025', '2025-02-28', 'Energy projects'),
(3, 'OPS/2025/B002', 'operational', 'Laporan Operasional Februari 2025', 'Februari 2025', '2025-02-28', 'Drug development'),
(5, 'OPS/2025/F002', 'operational', 'Laporan Operasional Februari 2025', 'Februari 2025', '2025-02-28', 'Transaction processing'),
(7, 'OPS/2025/R002', 'operational', 'Laporan Operasional Februari 2025', 'Februari 2025', '2025-02-28', 'Robot deployment');

-- Operational KPIs (for all 15 operational documents)
INSERT INTO operational_kpis (document_id, productivity_score, efficiency_score, quality_score, on_time_delivery_score) VALUES
(26, 68.5, 72.3, 78.9, 71.2), -- Quantum (early stage, lower scores)
(27, 88.7, 91.5, 94.8, 89.3), -- Green Energy
(28, 95.2, 97.1, 98.9, 96.5), -- Biotech (highly regulated, high quality)
(29, 82.3, 85.7, 90.1, 84.6), -- Smart City
(30, 98.5, 99.2, 99.8, 98.9), -- Fintech (automated systems)
(31, 76.8, 80.2, 88.5, 79.1), -- Aerospace (complex manufacturing)
(32, 91.3, 93.8, 96.2, 92.7), -- Robotics
(33, 99.1, 99.5, 99.9, 99.3), -- Cyber Security (critical systems)
(34, 85.6, 88.9, 92.3, 87.2), -- Blockchain
(35, 89.2, 91.7, 94.5, 90.8), -- VR Studios
(36, 71.2, 75.8, 81.3, 73.5), -- Quantum Feb
(37, 90.1, 92.8, 95.6, 91.2), -- Green Energy Feb
(38, 96.5, 98.2, 99.2, 97.3), -- Biotech Feb
(39, 98.9, 99.4, 99.9, 99.1), -- Fintech Feb
(40, 92.7, 94.9, 97.1, 93.8); -- Robotics Feb

-- Department Performance (Sample for docs 26-35)
INSERT INTO department_performance (document_id, department_name, target_value, actual_value, achievement_rate) VALUES
-- Doc 26 (Quantum Computing)
(26, 'Quantum Research Lab', 50, 38, 76.0),
(26, 'Algorithm Development', 40, 35, 87.5),
(26, 'Hardware Engineering', 30, 22, 73.3),
(26, 'Patent Filing', 10, 12, 120.0),
-- Doc 27 (Green Energy)
(27, 'Solar Installation Team A', 25, 28, 112.0),
(27, 'Solar Installation Team B', 25, 26, 104.0),
(27, 'Wind Turbine Maintenance', 15, 16, 106.7),
(27, 'Energy Storage Setup', 20, 22, 110.0),
-- Doc 28 (Biotech)
(28, 'Clinical Trial Phase I', 100, 105, 105.0),
(28, 'Clinical Trial Phase II', 80, 85, 106.3),
(28, 'Drug Manufacturing', 500, 520, 104.0),
(28, 'Quality Assurance', 200, 210, 105.0),
-- Doc 30 (Fintech)
(30, 'Transaction Processing', 50000000, 52500000, 105.0),
(30, 'Customer Onboarding', 250000, 268000, 107.2),
(30, 'Fraud Detection', 1000000, 1050000, 105.0),
(30, 'Customer Support', 150000, 158000, 105.3);

-- Inventory Status (Sample for docs 26-35)
INSERT INTO inventory_status (document_id, item_name, current_stock, status, restock_date) VALUES
-- Doc 26 (Quantum)
(26, 'Quantum Processors', '8 unit', 'Kritis', '2025-03-15'),
(26, 'Cryogenic Cooling Systems', '12 unit', 'Aman', '2025-06-01'),
(26, 'Specialized Sensors', '45 unit', 'Menipis', '2025-02-20'),
-- Doc 27 (Green Energy)
(27, 'Solar Panels 500W', '8,500 unit', 'Aman', '2025-04-01'),
(27, 'Inverters Industrial', '450 unit', 'Aman', '2025-03-15'),
(27, 'Battery Storage 100kWh', '85 unit', 'Menipis', '2025-02-25'),
-- Doc 28 (Biotech)
(28, 'Active Pharmaceutical Ingredient', '2,500 kg', 'Aman', '2025-05-01'),
(28, 'Lab Reagents Grade A', '850 liter', 'Aman', '2025-03-10'),
(28, 'Sterile Vials', '125,000 unit', 'Aman', '2025-04-15'),
-- Doc 30 (Fintech)
(30, 'Server Capacity (TB)', '5,000 TB', 'Aman', '2025-06-01'),
(30, 'Security Tokens', '250,000 unit', 'Aman', '2025-04-01'),
(30, 'Backup Systems', '25 unit', 'Menipis', '2025-02-28');

-- Operational Risks (Sample for docs 26-35)
INSERT INTO operational_risks (document_id, category, risk_issue, impact_level, probability_level, mitigation_plan) VALUES
-- Doc 26 (Quantum)
(26, 'Teknologi', 'Quantum decoherence instability', 'Sangat Tinggi', 'Tinggi', 'Advanced error correction algorithms'),
(26, 'SDM', 'Shortage of quantum physicists', 'Sangat Tinggi', 'Tinggi', 'University partnerships and training'),
(26, 'Finansial', 'R&D cost overrun', 'Tinggi', 'Sedang', 'Phased funding and milestone-based release'),
-- Doc 27 (Green Energy)
(27, 'Regulasi', 'Policy changes on renewable subsidies', 'Tinggi', 'Sedang', 'Diversified revenue streams'),
(27, 'Operasional', 'Weather-dependent installation delays', 'Sedang', 'Tinggi', 'Flexible scheduling and buffer time'),
-- Doc 28 (Biotech)
(28, 'Regulasi', 'FDA approval delays', 'Sangat Tinggi', 'Sedang', 'Early engagement with regulators'),
(28, 'Kualitas', 'Contamination in manufacturing', 'Sangat Tinggi', 'Rendah', 'ISO cleanroom standards'),
-- Doc 30 (Fintech)
(30, 'Keamanan', 'Cyber attack on payment systems', 'Sangat Tinggi', 'Tinggi', 'Multi-layer security and real-time monitoring'),
(30, 'Regulasi', 'New fintech regulations', 'Tinggi', 'Tinggi', 'Compliance team and legal advisory');

-- =====================================================
-- MANAGEMENT DOCUMENTS (10 documents)
-- =====================================================

INSERT INTO documents (company_id, document_number, type, title, period, date, notes) VALUES
(1, 'MGT/2025/Q001', 'management', 'Laporan Manajemen Q1 2025', 'Q1 2025', '2025-03-31', 'Quantum strategy'),
(2, 'MGT/2025/G001', 'management', 'Laporan Manajemen Q1 2025', 'Q1 2025', '2025-03-31', 'Green energy growth'),
(3, 'MGT/2025/B001', 'management', 'Laporan Manajemen Q1 2025', 'Q1 2025', '2025-03-31', 'Biotech pipeline'),
(4, 'MGT/2025/S001', 'management', 'Laporan Manajemen Q1 2025', 'Q1 2025', '2025-03-31', 'Smart city expansion'),
(5, 'MGT/2025/F001', 'management', 'Laporan Manajemen Q1 2025', 'Q1 2025', '2025-03-31', 'Fintech dominance'),
(6, 'MGT/2025/A001', 'management', 'Laporan Manajemen Q1 2025', 'Q1 2025', '2025-03-31', 'Aerospace contracts'),
(7, 'MGT/2025/R001', 'management', 'Laporan Manajemen Q1 2025', 'Q1 2025', '2025-03-31', 'Robotics automation'),
(8, 'MGT/2025/C001', 'management', 'Laporan Manajemen Q1 2025', 'Q1 2025', '2025-03-31', 'Cybersecurity leadership'),
(9, 'MGT/2025/BC001', 'management', 'Laporan Manajemen Q1 2025', 'Q1 2025', '2025-03-31', 'Blockchain adoption'),
(10, 'MGT/2025/V001', 'management', 'Laporan Manajemen Q1 2025', 'Q1 2025', '2025-03-31', 'VR content strategy');

-- Management Summaries (for all 10 management documents)
INSERT INTO management_summaries (document_id, executive_summary, challenges, next_steps, achievements) VALUES
(41, 'Q1 2025 marks breakthrough in quantum computing with 256-qubit system achieving 99.9% fidelity. Despite Rp 11.4T loss, investor confidence remains strong with Rp 18T Series C funding secured.', 
'["Quantum decoherence at scale", "Talent war with global tech giants", "Commercialization timeline uncertainty"]',
'["Launch quantum cloud platform beta", "Hire 50 quantum engineers", "Patent 25 quantum algorithms"]',
'["256-qubit system operational", "Series C funding Rp 18T", "5 Fortune 500 partnerships"]'),

(42, 'Q1 2025 renewable energy installations reach 2.5 GW capacity with Rp 18.5T profit. Government carbon credit program provides additional Rp 3.2T revenue stream.', 
'["Grid integration complexity", "Energy storage cost still high", "Regulatory approval delays"]',
'["Deploy 1 GW battery storage", "Expand to 10 new provinces", "Green hydrogen pilot project"]',
'["2.5 GW capacity installed", "Carbon credits Rp 3.2T", "PROPER Emas certification"]'),

(43, 'Q1 2025 biotech pipeline shows 3 drugs in Phase III trials with Rp 32.4T profit. FDA fast-track designation received for cancer immunotherapy.', 
'["Clinical trial recruitment", "Manufacturing scale-up complexity", "Regulatory pathway uncertainty"]',
'["Submit NDA for lead drug", "Build GMP facility Rp 500M", "Expand to gene therapy"]',
'["3 drugs Phase III", "FDA fast-track approval", "Profit margin 34.5%"]'),

(44, 'Q1 2025 smart city projects worth Rp 285T deployed across 8 cities. AI-powered traffic management reduces congestion 35% in pilot areas.', 
'["Multi-stakeholder coordination", "Legacy infrastructure integration", "Data privacy concerns"]',
'["Scale to 15 cities", "Launch smart waste management", "5G network integration"]',
'["8 cities deployed", "Traffic reduction 35%", "Energy savings 28%"]'),

(45, 'Q1 2025 fintech platform processes 850M transactions worth Rp 1,250T. User base reaches 45M with 20.1% profit margin sustained.', 
'["Regulatory compliance burden", "Fraud detection at scale", "Competition from banks"]',
'["Launch crypto trading", "Expand to MSME lending", "AI fraud prevention v2"]',
'["850M transactions", "45M users", "Profit Rp 34.2T"]'),

(46, 'Q1 2025 aerospace division secures Rp 450T defense contract. First Indonesian-made commercial aircraft component achieves FAA certification.', 
'["Supply chain for aerospace-grade materials", "Certification timeline", "Skilled workforce shortage"]',
'["Deliver first aircraft components", "Expand to satellite parts", "Training center launch"]',
'["Rp 450T defense contract", "FAA certification", "Export to 5 countries"]'),

(47, 'Q1 2025 robotics deployment reaches 5,000 units across manufacturing sector. Automation-as-a-Service model generates Rp 24.7T profit.', 
'["Customer adoption resistance", "Integration with legacy systems", "Maintenance network scaling"]',
'["Launch collaborative robots", "Expand to healthcare sector", "AI vision system upgrade"]',
'["5,000 robots deployed", "Profit Rp 24.7T", "Customer retention 96%"]'),

(48, 'Q1 2025 cybersecurity platform protects 2,500 enterprise clients. Zero-day threat detection AI prevents 12,000 attacks with 99.9% accuracy.', 
'["Evolving threat landscape", "Talent shortage in security", "Client budget constraints"]',
'["Launch SOC-as-a-Service", "Expand to OT security", "Threat intelligence platform"]',
'["2,500 clients protected", "12K attacks prevented", "Profit margin 30.1%"]'),

(49, 'Q1 2025 blockchain network processes 2.5M transactions daily. Enterprise adoption grows 180% with supply chain traceability as killer app.', 
'["Scalability limitations", "Energy consumption concerns", "Regulatory uncertainty"]',
'["Layer-2 scaling solution", "Green blockchain initiative", "Government partnership"]',
'["2.5M daily transactions", "Enterprise growth 180%", "15 industry verticals"]'),

(50, 'Q1 2025 VR content production reaches 250 hours of premium content. Metaverse platform attracts 1.2M monthly active users.', 
'["Content production cost", "Hardware adoption rate", "Platform fragmentation"]',
'["Launch VR education platform", "Partner with telcos for 5G", "Expand to enterprise training"]',
'["250 hours content", "1.2M MAU", "5 brand partnerships"]');

-- Strategic Goals (Sample for docs 41-50, 4 goals each)
INSERT INTO strategic_goals (document_id, goal_name, progress_percentage, status, deadline) VALUES
-- Doc 41 (Quantum)
(41, 'Quantum Cloud Platform Launch', 45, 'On Track', '2025-09-30'),
(41, 'Commercial Quantum Algorithm Library', 35, 'On Track', '2025-12-31'),
(41, 'Quantum Supremacy Demonstration', 60, 'Ahead', '2025-06-30'),
(41, 'Series D Funding Rp 50T', 20, 'On Track', '2026-06-30'),
-- Doc 42 (Green Energy)
(42, 'Renewable Capacity 5 GW', 50, 'On Track', '2025-12-31'),
(42, 'Battery Storage 500 MWh', 35, 'On Track', '2025-12-31'),
(42, 'Green Hydrogen Pilot', 25, 'On Track', '2026-06-30'),
(42, 'Carbon Neutral Operations', 65, 'Ahead', '2025-12-31'),
-- Doc 43 (Biotech)
(43, 'FDA Approval Lead Drug', 75, 'Ahead', '2025-09-30'),
(43, 'Phase III Trials Completion', 60, 'On Track', '2025-12-31'),
(43, 'GMP Facility Operational', 40, 'On Track', '2026-03-31'),
(43, 'Gene Therapy Platform', 30, 'On Track', '2026-12-31');

-- SWOT Analysis (Sample for docs 41-50)
INSERT INTO swot_analysis (document_id, analysis_type, content) VALUES
-- Doc 41 (Quantum)
(41, 'strength', 'World-class quantum research team 85 PhDs'),
(41, 'strength', 'Proprietary error correction algorithms'),
(41, 'strength', 'Strong investor backing Rp 45T total'),
(41, 'weakness', 'No revenue-generating products yet'),
(41, 'weakness', 'High burn rate Rp 3.5T per quarter'),
(41, 'opportunity', 'Quantum computing market CAGR 35%'),
(41, 'opportunity', 'Government quantum initiative funding'),
(41, 'threat', 'IBM and Google quantum dominance'),
(41, 'threat', 'Quantum winter if breakthroughs delay'),
-- Doc 42 (Green Energy)
(42, 'strength', '2.5 GW installed capacity leadership'),
(42, 'strength', 'Vertically integrated supply chain'),
(42, 'weakness', 'Weather-dependent revenue'),
(42, 'opportunity', 'Net zero commitments by corporates'),
(42, 'threat', 'Subsidy policy changes'),
-- Doc 45 (Fintech)
(45, 'strength', '45M user base largest in Indonesia'),
(45, 'strength', 'AI fraud detection 99.9% accuracy'),
(45, 'weakness', 'Regulatory compliance cost high'),
(45, 'opportunity', 'Financial inclusion 50% unbanked'),
(45, 'threat', 'Big tech entering fintech');

-- Stakeholders (Sample for docs 41-50)
INSERT INTO stakeholders (document_id, name, role, involvement_level) VALUES
-- Doc 41 (Quantum)
(41, 'Prof. Dr. Siti Aminah', 'Chief Quantum Scientist', 'Research Leadership'),
(41, 'David Chen, PhD', 'CEO', 'Strategic Vision'),
(41, 'Rina Kusuma', 'CFO', 'Funding & Finance'),
(41, 'Dr. Budi Santoso', 'VP Engineering', 'Product Development'),
-- Doc 42 (Green Energy)
(42, 'Ir. Agus Wijaya, MT', 'CEO', 'Business Strategy'),
(42, 'Sarah Lestari', 'CTO', 'Technology Innovation'),
(42, 'Michael Tan', 'COO', 'Operations Excellence'),
-- Doc 45 (Fintech)
(45, 'Kevin Susanto', 'CEO & Founder', 'Product Vision'),
(45, 'Linda Hartono', 'CFO', 'Financial Strategy'),
(45, 'Dr. Ahmad Fauzi', 'Chief Risk Officer', 'Risk Management'),
(45, 'Jessica Wong', 'Chief Compliance Officer', 'Regulatory Affairs');

-- =====================================================
-- SUMMARY V3
-- =====================================================
-- Total Records Created:
-- - Companies: 10 (2025 focus: Quantum, Green Energy, Biotech, etc.)
-- - Documents: 50 (25 Financial, 15 Operational, 10 Management)
-- - Financial Summaries: 25
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
-- TOTAL ESTIMATED RECORDS: ~190+
-- YEAR: 2025 (Future-focused industries)
-- =====================================================
