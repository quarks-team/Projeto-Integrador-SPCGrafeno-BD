-- Table for Users
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),  -- Unique identifier for each user
    username VARCHAR(255) NOT NULL,                  -- Username
    password VARCHAR(255) NOT NULL,                  -- User's password
    email VARCHAR(255) NOT NULL UNIQUE,              -- User's email
    cnpj VARCHAR(20),                                -- CNPJ, if applicable
    consent_status BOOLEAN DEFAULT FALSE,            -- LGPD consent status
    consent_date TIMESTAMP,                          -- Date when consent was given
    created_at TIMESTAMP DEFAULT NOW(),              -- Timestamp when the user was created
    updated_at TIMESTAMP DEFAULT NOW()                -- Timestamp when the user was last updated
);

-- Table for Policies
CREATE TABLE policies (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),   -- Unique identifier for each policy
    name VARCHAR(255) NOT NULL,                      -- Policy name
    description TEXT,                                -- Policy description
    version INT NOT NULL,                            -- Version of the policy
    is_active BOOLEAN DEFAULT TRUE,                  -- Soft delete: whether the policy is active
    created_at TIMESTAMP DEFAULT NOW(),              -- Timestamp when the policy was created
    updated_at TIMESTAMP DEFAULT NOW()                -- Timestamp when the policy was last updated
);

-- Many-to-Many Table for Users and Policies
CREATE TABLE user_policies (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),   -- Unique identifier for this user-policy link
    user_id UUID REFERENCES users(id),               -- Foreign key to users (no ON DELETE CASCADE)
    policy_id UUID REFERENCES policies(id),           -- Foreign key to policies (no ON DELETE CASCADE)
    is_active BOOLEAN DEFAULT FALSE,                  -- Whether the policy is still active for the user
    acceptance_date TIMESTAMP DEFAULT NOW(),         -- Timestamp of when the user accepted the policy
    updated_at TIMESTAMP DEFAULT NOW()                -- Last updated timestamp
);

-- Table for logging changes to policy acceptance
-- No rows can be deleted; this ensures auditability for legal compliance
CREATE TABLE policy_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),   -- Unique identifier for each log entry
    user_id UUID REFERENCES users(id),               -- Foreign key to users (no ON DELETE CASCADE)
    policy_id UUID REFERENCES policies(id),           -- Foreign key to policies (no ON DELETE CASCADE)
    change_date TIMESTAMP DEFAULT NOW(),             -- Timestamp when the change happened
    previous_status VARCHAR(50),                     -- Previous status (e.g., "Accepted", "Revoked")
    new_status VARCHAR(50),                          -- New status (e.g., "Accepted", "Revoked")
    change_type VARCHAR(50),                         -- Type of change (e.g., "Acceptance", "Revocation")
    user_email VARCHAR(255) NOT NULL                 -- Email of the user at the time of acceptance
);