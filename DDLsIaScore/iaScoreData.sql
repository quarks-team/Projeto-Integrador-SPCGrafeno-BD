-- Table to store processed data for AI Score Calculation
CREATE TABLE ia_score_data (
    score_entry_id UUID PRIMARY KEY, -- Unique ID for each score entry
    supplier_reference_id UUID NOT NULL, -- Reference to the endorser (previously 'endorser_original_id')
    segment_products_count INT, -- Number of product-related duplicates (previously 'products')
    segment_services_count INT, -- Number of service-related duplicates (previously 'services')
    successful_transactions INT, -- Number of finished duplicates (previously 'finished')
    voided_transactions INT, -- Number of canceled duplicates (previously 'canceled')
    ongoing_transactions INT, -- Number of active duplicates (previously 'active')
    overall_transactions INT, -- Total number of transactions (previously 'total_transactions')
    renegotiation_delay_days DECIMAL(10, 2), -- Average aging delay (previously 'average_aging_days')
    last_completion_date DATE, -- Date of the most recent completed duplicate (previously 'finished_at')
    non_voided_transactions INT, -- Number of non-canceled duplicates (previously 'not_canceled')
    median_installment_amount DECIMAL(15, 2), -- Median installment amount (previously 'installment_median')
    record_last_updated TIMESTAMP DEFAULT NOW() -- Timestamp for when the record was last updated
);