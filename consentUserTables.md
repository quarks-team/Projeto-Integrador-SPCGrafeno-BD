## Table: `users`
- **Purpose:** Stores user data, including LGPD (General Data Protection Law) consent status.
- **Columns:**
  - `id` (SERIAL, Primary Key): Auto-incremented integer ID, unique identifier for each user.
  - `username` (VARCHAR 255, NOT NULL, UNIQUE): Username of the user, must be unique.
  - `password` (VARCHAR 255, NOT NULL): User's password.
  - `email` (VARCHAR 255, NOT NULL, UNIQUE): User's email, must be unique.
  - `cnpj` (VARCHAR 20, NULL): CNPJ of the user, if applicable.
  - `consent_status` (BOOLEAN, DEFAULT FALSE): Indicates whether the user has given LGPD consent.
  - `consent_date` (TIMESTAMP, NULL): The date when the user gave consent.
  - `created_at` (TIMESTAMP, DEFAULT NOW()): When the user was created.
  - `updated_at` (TIMESTAMP, DEFAULT NOW()): When the user record was last updated.

---

## Table: `policies`
- **Purpose:** Stores policy data for LGPD.
- **Columns:**
  - `id` (SERIAL, Primary Key): Auto-incremented integer ID, unique identifier for each policy.
  - `name` (VARCHAR 255, NOT NULL): The name of the policy.
  - `description` (TEXT, NULL): Description of the policy.
  - `version` (INT, NOT NULL): Version number of the policy.
  - `is_active` (BOOLEAN, DEFAULT TRUE): Whether the policy is currently active.
  - `created_at` (TIMESTAMP, DEFAULT NOW()): When the policy was created.
  - `updated_at` (TIMESTAMP, DEFAULT NOW()): When the policy was last updated.
  - `excluded_at` (TIMESTAMP, NULL): Timestamp when the policy was last excluded (nullable).

---

## Table: `user_policies`
- **Purpose:** Tracks which policies have been accepted by which users (Many-to-Many relationship).
- **Columns:**
  - `id` (SERIAL, Primary Key): Auto-incremented integer ID, unique identifier for each user-policy record.
  - `user_id` (SERIAL, Foreign Key to `users.id`): The user who accepted the policy.
  - `policy_id` (SERIAL, Foreign Key to `policies.id`): The policy that was accepted.
  - `is_active` (BOOLEAN, DEFAULT FALSE): Whether the policy is currently active for the user.
  - `acceptance_date` (TIMESTAMP, DEFAULT NOW()): When the user accepted the policy.
  - **Constraints:**
    - `UNIQUE (user_id, policy_id)`: Ensures that each user can only accept a policy once.

---

## Table: `policy_logs`
- **Purpose:** Logs changes to the acceptance of policies for audit and legal compliance.
- **Columns:**
  - `id` (SERIAL, Primary Key): Auto-incremented integer ID, unique identifier for each log entry.
  - `user_id` (SERIAL, Foreign Key to `users.id`): The user associated with the policy change.
  - `policy_id` (SERIAL, Foreign Key to `policies.id`): The policy associated with the change.
  - `change_date` (TIMESTAMP, DEFAULT NOW()): When the change was made.
  - `previous_status` (VARCHAR 50, NULL): The previous status of the policy acceptance (e.g., "Accepted", "Revoked").
  - `new_status` (VARCHAR 50, NULL): The new status of the policy acceptance (e.g., "Accepted", "Revoked").
  - `change_type` (VARCHAR 50, NULL): Type of change (e.g., "Acceptance", "Revocation").
  - `user_email` (VARCHAR 255, NOT NULL): The email of the user at the time of the change.
  - **Constraints:**
    - No rows can be deleted from this table to ensure auditability.
