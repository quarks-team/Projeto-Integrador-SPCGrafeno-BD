# Projeto-Integrador-SPCGrafeno-BD
Repository dedicated to versioning the Database from the SPC Grafeno project with Quarks Team

### Additional Information:
- **Primary Key**: `result_id` is the primary key and uniquely identifies each result.
- **Constraints**: The `final_score` column is constrained to ensure the score is between 1 and 1000.
- **Default Values**: 
  - `record_status` defaults to `'active'`.
  - `created_timestamp` defaults to the current timestamp (`CURRENT_TIMESTAMP`).### Table: `ai_score_results`

This table stores the AI-generated score results, along with relevant metadata and input data. Below is the detailed description of each column.

| Column Name        | Data Type     | Description                                                                 |
|--------------------|---------------|-----------------------------------------------------------------------------|
| `result_id`        | `UUID`        | A unique identifier for each result. Automatically generated using `gen_random_uuid()`. |
| `entry_date`       | `DATE`        | The date when the input data was processed by the AI model.                  |
| `final_score`      | `INTEGER`     | The final score calculated by the AI. |
| `input_variables`  | `JSONB`       | The input variables used in the score calculation, stored in JSONB format to allow complex data structures. |
| `endorser_name`    | `VARCHAR(255)`| The name of the endorser (or participant) associated with the score result.  |
| `record_status`    | `VARCHAR(50)` | The status of the record, indicating whether the result is active, canceled, or finished. Defaults to `active`. |
| `created_timestamp`| `TIMESTAMP`   | The timestamp indicating when the record was created. Defaults to the current timestamp when the record is inserted. |

### Additional Information:
- **Primary Key**: `result_id` is the primary key and uniquely identifies each result.
- **Default Values**: 
  - `record_status` defaults to `'active'`.
  - `created_timestamp` defaults to the current timestamp (`CURRENT_TIMESTAMP`).