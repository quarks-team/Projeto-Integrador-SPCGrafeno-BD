CREATE TABLE ia_duplicate_prediction (
    id UUID PRIMARY KEY,                       -- Unique record identifier
    installment INT NOT NULL,                  -- Installment duration in months
    month_due_date INT NOT NULL,               -- Month of due date (1 to 12)
    quarter_due_date INT NOT NULL,             -- Quarter of due date (1 to 4)

    -- Payment locations (One-Hot Encoding of states)
    payment_place_sp BOOLEAN DEFAULT FALSE,    -- São Paulo
    payment_place_rj BOOLEAN DEFAULT FALSE,    -- Rio de Janeiro
    payment_place_mg BOOLEAN DEFAULT FALSE,    -- Minas Gerais
    payment_place_rs BOOLEAN DEFAULT FALSE,    -- Rio Grande do Sul

    -- Segments (One-Hot Encoding of segments)
    segment_financial BOOLEAN DEFAULT FALSE,   -- Financial
    segment_commercial BOOLEAN DEFAULT FALSE,  -- Commercial
    segment_industrial BOOLEAN DEFAULT FALSE,  -- Industrial
    segment_educational BOOLEAN DEFAULT FALSE, -- Educational

    -- Duplicate types (One-Hot Encoding of types)
    kind_receivable BOOLEAN DEFAULT FALSE,     -- Receivable
    kind_invoice BOOLEAN DEFAULT FALSE,        -- Invoice
    kind_check BOOLEAN DEFAULT FALSE,          -- Check

    result INT NOT NULL,                       -- Target variable (1 for finalized, 0 for canceled)

    -- Index for optimizing prediction-related queries
    CONSTRAINT chk_result CHECK (result IN (0, 1))
);

-- Create an index on the result column to optimize queries
CREATE INDEX idx_result ON transformed_duplicates (result);
