CREATE TABLE public.ai_score_results (
    result_id UUID PRIMARY KEY DEFAULT gen_random_uuid(), -- Unique identifier for each result
    final_score INTEGER NOT NULL,                         -- Final calculated score
    input_variables JSONB NOT NULL,                       -- Input variables used in the score calculation (stored as JSONB)
    endorser_name VARCHAR(255) NOT NULL,                  -- Name of the endorser
    created_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp for when the record was created
    cnpj VARCHAR(20) NULL
);
