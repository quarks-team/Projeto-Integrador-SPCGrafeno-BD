# Projeto-Integrador-SPCGrafeno-BD
Repository dedicated to versioning the Database from the SPC Grafeno project with Quarks Team


# IA Score Calculation Documentation

## Table: `ia_score_data` (Processed Data for AI Model)

### Purpose:
This table stores the processed data required for the AI model to calculate scores for endorsers. The columns result from transformations of the raw data, including OneHot Encoding, grouping, and average calculations. The column names have been designed to be distinct from those in the client's original database for legal compliance.

### Attributes:

- **`score_entry_id`**: A unique identifier for each score calculation entry.
- **`supplier_reference_id`**: A reference to the `asset_parts` table that identifies the endorser associated with the transactions (previously `endorser_original_id`).
- **`segment_products_count`**: Number of duplicate bills related to products, derived from OneHot Encoding of the segment type (previously `products`).
- **`segment_services_count`**: Number of duplicate bills related to services, derived from OneHot Encoding of the segment type (previously `services`).
- **`successful_transactions`**: Number of duplicates that have been successfully completed (previously `finished`).
- **`voided_transactions`**: Number of duplicates that were canceled (a negative indicator for score calculation, previously `canceled`).
- **`ongoing_transactions`**: Number of duplicates that are still ongoing (a positive indicator for score calculation, previously `active`).
- **`overall_transactions`**: Total number of transactions, summing `successful_transactions`, `voided_transactions`, and `ongoing_transactions`, representing the endorser's entire transaction history (previously `total_transactions`).
- **`renegotiation_delay_days`**: Average delay in renegotiation, calculated as the difference between the original and new due dates (previously `average_aging_days`).
- **`last_completion_date`**: The most recent date when a duplicate bill was completed (previously `finished_at`).
- **`non_voided_transactions`**: The sum of ongoing and successful duplicates, indicating the reliability of the endorser (previously `not_canceled`).
- **`median_installment_amount`**: The median value of the installments for the duplicate bills (previously `installment_median`).
- **`record_last_updated`**: Timestamp of the last update of this entry, ensuring the AI model is using the most recent data.

---

### Final Notes:
- This table is optimized for AI consumption, with pre-processed data and key metrics ready for analysis.
- The segments (`segment_products_count`, `segment_services_count`) and transaction statuses (`successful_transactions`, `voided_transactions`, `ongoing_transactions`) are encoded to allow direct use by the AI model.
- Additional metrics, such as `renegotiation_delay_days` and `median_installment_amount`, are included to improve scoring accuracy.
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