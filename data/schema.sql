-- Companies Table
CREATE TABLE companies (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address TEXT,
    phone VARCHAR(50),
    email VARCHAR(100),
    logo_url TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Documents Table (Header info for all document types)
CREATE TABLE documents (
    id SERIAL PRIMARY KEY,
    company_id BIGINT UNSIGNED REFERENCES companies(id),
    document_number VARCHAR(50) UNIQUE,
    type VARCHAR(50) NOT NULL CHECK (type IN ('financial', 'operational', 'management', 'custom')),
    title VARCHAR(255) NOT NULL,
    period VARCHAR(100),
    date DATE,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Financial Data
CREATE TABLE financial_summaries (
    id SERIAL PRIMARY KEY,
    document_id BIGINT UNSIGNED REFERENCES documents(id) ON DELETE CASCADE,
    revenue DECIMAL(20, 2),
    revenue_last_year DECIMAL(20, 2),
    expenses DECIMAL(20, 2),
    expenses_last_year DECIMAL(20, 2),
    net_profit DECIMAL(20, 2),
    net_profit_last_year DECIMAL(20, 2),
    profit_margin DECIMAL(5, 2),
    profit_margin_last_year DECIMAL(5, 2)
);

CREATE TABLE financial_breakdowns (
    id SERIAL PRIMARY KEY,
    document_id BIGINT UNSIGNED REFERENCES documents(id) ON DELETE CASCADE,
    category VARCHAR(255) NOT NULL,
    amount DECIMAL(20, 2),
    previous_amount DECIMAL(20, 2), -- For YoY comparison
    percentage DECIMAL(5, 2), -- For expense breakdown
    type VARCHAR(50) CHECK (type IN ('revenue', 'expense', 'asset_current', 'asset_fixed', 'liability', 'equity'))
);

CREATE TABLE financial_cash_flows (
    id SERIAL PRIMARY KEY,
    document_id BIGINT UNSIGNED REFERENCES documents(id) ON DELETE CASCADE,
    operating_cash DECIMAL(20, 2),
    investing_cash DECIMAL(20, 2),
    financing_cash DECIMAL(20, 2),
    beginning_cash DECIMAL(20, 2),
    ending_cash DECIMAL(20, 2)
);

CREATE TABLE financial_trends (
    id SERIAL PRIMARY KEY,
    document_id BIGINT UNSIGNED REFERENCES documents(id) ON DELETE CASCADE,
    period_label VARCHAR(50), -- e.g., "Jan 2024"
    revenue DECIMAL(20, 2),
    profit DECIMAL(20, 2),
    sort_order INTEGER -- To keep months in order
);

-- Operational Data
CREATE TABLE operational_kpis (
    id SERIAL PRIMARY KEY,
    document_id BIGINT UNSIGNED REFERENCES documents(id) ON DELETE CASCADE,
    productivity_score DECIMAL(5, 2),
    efficiency_score DECIMAL(5, 2),
    quality_score DECIMAL(5, 2),
    on_time_delivery_score DECIMAL(5, 2)
);

CREATE TABLE department_performance (
    id SERIAL PRIMARY KEY,
    document_id BIGINT UNSIGNED REFERENCES documents(id) ON DELETE CASCADE,
    department_name VARCHAR(100),
    target_value INTEGER,
    actual_value INTEGER,
    achievement_rate DECIMAL(5, 2)
);

CREATE TABLE inventory_status (
    id SERIAL PRIMARY KEY,
    document_id BIGINT UNSIGNED REFERENCES documents(id) ON DELETE CASCADE,
    item_name VARCHAR(255),
    current_stock VARCHAR(100),
    status VARCHAR(50) CHECK (status IN ('Aman', 'Menipis', 'Kritis')),
    restock_date DATE
);

CREATE TABLE operational_risks (
    id SERIAL PRIMARY KEY,
    document_id BIGINT UNSIGNED REFERENCES documents(id) ON DELETE CASCADE,
    category VARCHAR(100),
    risk_issue TEXT,
    impact_level VARCHAR(50),
    probability_level VARCHAR(50),
    mitigation_plan TEXT
);

-- Management Data
CREATE TABLE management_summaries (
    id SERIAL PRIMARY KEY,
    document_id BIGINT UNSIGNED REFERENCES documents(id) ON DELETE CASCADE,
    executive_summary TEXT,
    challenges JSON, -- Array of strings stored as JSON
    next_steps JSON, -- Array of strings stored as JSON
    achievements JSON -- Array of strings stored as JSON
);

CREATE TABLE strategic_goals (
    id SERIAL PRIMARY KEY,
    document_id BIGINT UNSIGNED REFERENCES documents(id) ON DELETE CASCADE,
    goal_name VARCHAR(255),
    progress_percentage INTEGER,
    status VARCHAR(50), -- On Track, At Risk, Ahead
    deadline DATE
);

CREATE TABLE swot_analysis (
    id SERIAL PRIMARY KEY,
    document_id BIGINT UNSIGNED REFERENCES documents(id) ON DELETE CASCADE,
    analysis_type VARCHAR(20) CHECK (analysis_type IN ('strength', 'weakness', 'opportunity', 'threat')),
    content TEXT
);

CREATE TABLE stakeholders (
    id SERIAL PRIMARY KEY,
    document_id BIGINT UNSIGNED REFERENCES documents(id) ON DELETE CASCADE,
    name VARCHAR(100),
    role VARCHAR(100),
    involvement_level VARCHAR(100)
);
