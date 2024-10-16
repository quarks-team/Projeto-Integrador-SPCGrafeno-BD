CREATE TABLE public.ai_score_results (
    result_id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Unique identifier for each result
    entry_date DATE NOT NULL,                             -- Date the data was processed
    final_score INTEGER NOT NULL,                         -- Final calculated score
    input_variables JSONB NOT NULL,                       -- Input variables used in the score calculation (stored as JSONB)
    endorser_name VARCHAR(255) NOT NULL,                  -- Name of the endorser
    record_status VARCHAR(50) DEFAULT 'active',           -- Status of the record (e.g., 'active', 'cancelled', 'finished')
    created_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Timestamp for when the record was created
);