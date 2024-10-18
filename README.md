# Projeto-Integrador-SPCGrafeno-BD
Repository dedicated to versioning the Database from the SPC Grafeno project with Quarks Team


# IA Score Calculation Documentation

## Table: `ia_duplicate_prediction` (Processed Data for AI Model)

### Purpose:
This table stores the processed data required for the AI model to predict the outcome of duplicate bills. The data results from transformations of the raw input, including OneHot Encoding of categorical fields and calculation of transaction metrics. This table is specifically designed for AI consumption, facilitating the model's ability to predict whether a bill will be finalized or canceled.

### Attributes:

- **`id`**: A unique identifier for each duplicate bill entry.
- **`installment`**: Duration of the installment plan, measured in months.
- **`month_due_date`**: The month in which the duplicate bill is due. Values range from 1 (January) to 12 (December).
- **`quarter_due_date`**: The quarter of the year when the bill is due (1 to 4).
- **`payment_place_ `**: One-Hot Encoded columns representing different payment locations based on geographic regions (states or cities).
- **`segment_ `**: One-Hot Encoded columns representing different business segments related to the bill (such as retail, services, etc.).
- **`kind_ `**: One-Hot Encoded columns representing the different types of bills (e.g., product vs. service).
- **`result`**: The target variable for prediction, indicating whether a bill was finalized (1) or canceled (0).

---

### Final Notes:
- This table is optimized for use in AI models. The inclusion of One-Hot Encoded fields allows for effective consumption of categorical variables.
- Key features, such as the segmentation of bills and the status of transactions, provide the model with the necessary information for accurate predictions.
- The `result` column serves as the dependent variable in training and evaluating AI models to predict the outcome of duplicate bills.
- *Indexes*: An index has been created on the `result` field to optimize query performance for AI model predictions.

# AI Score Calculation Documentation

## Table: `ia_score_model_data` (Processed Data for AI Model)

### Purpose:
This table contains the processed data necessary for the AI model to calculate scores for endorsers. The data has been transformed from raw form into key metrics through processes such as OneHot Encoding, grouping, and averaging. The column names differ from those in the client's original database for legal compliance.

| Column Name               | Data Type       | Description                                                                                          |
|---------------------------|-----------------|------------------------------------------------------------------------------------------------------|
| `score_entry_id`           | UUID            | Unique identifier for each score entry. Automatically generated using `gen_random_uuid()`.            |
| `supplier_reference_id`    | UUID            | Reference to the endorser (previously `endorser_original_id`).                                        |
| `segment_products_count`   | INT             | Number of product-related duplicate transactions (previously `products`).                             |
| `segment_services_count`   | INT             | Number of service-related duplicate transactions (previously `services`).                             |
| `successful_transactions`  | INT             | Number of successfully completed duplicate transactions (previously `finished`).                      |
| `voided_transactions`      | INT             | Number of canceled duplicate transactions (previously `canceled`).                                    |
| `ongoing_transactions`     | INT             | Number of active duplicate transactions still in progress (previously `active`).                      |
| `overall_transactions`     | INT             | Total number of transactions, summing successful, voided, and ongoing transactions (previously `total_transactions`). |
| `renegotiation_delay_days` | DECIMAL(10, 2)  | Average delay in renegotiations (previously `average_aging_days`).                                    |
| `non_voided_transactions`  | INT             | Number of non-canceled duplicate transactions (previously `not_canceled`).                            |
| `median_installment_amount`| DECIMAL(15, 2)  | Median value of the installment amounts for duplicate transactions (previously `installment_median`). |
| `score`                    | DECIMAL(6, 2)   | Calculated score for the endorser based on input metrics.                                             |


### Attributes:

- **`score_entry_id`**: `UUID`  
  A unique identifier for each score calculation entry. Automatically generated using `gen_random_uuid()`.

- **`supplier_reference_id`**: `UUID`  
  A reference to the `asset_parts` table, identifying the endorser associated with the transactions (formerly `endorser_original_id`).

- **`segment_products_count`**: `INT`  
  The number of product-related duplicate transactions, derived from OneHot Encoding of the segment type (formerly `products`).

- **`segment_services_count`**: `INT`  
  The number of service-related duplicate transactions, also derived from OneHot Encoding of the segment type (formerly `services`).

- **`successful_transactions`**: `INT`  
  The count of duplicate transactions that were successfully completed (formerly `finished`).

- **`voided_transactions`**: `INT`  
  The count of duplicate transactions that were canceled (negative indicator for scoring, formerly `canceled`).

- **`ongoing_transactions`**: `INT`  
  The count of ongoing duplicate transactions (positive indicator for scoring, formerly `active`).

- **`overall_transactions`**: `INT`  
  The total number of transactions, including `successful_transactions`, `voided_transactions`, and `ongoing_transactions`, representing the endorser's entire transaction history (formerly `total_transactions`).

- **`renegotiation_delay_days`**: `DECIMAL(10, 2)`  
  The average delay in renegotiation, calculated as the difference between the original and renegotiated due dates (formerly `average_aging_days`).

- **`non_voided_transactions`**: `INT`  
  The total number of non-canceled transactions, which includes ongoing and successful duplicates, indicating the reliability of the endorser (formerly `not_canceled`).

- **`median_installment_amount`**: `DECIMAL(15, 2)`  
  The median installment amount across duplicate transactions (formerly `installment_median`).

- **`score`**: `DECIMAL(6, 2)`  
  The final score calculated for the endorser based on all the processed input variables.

---

### Final Notes:
- The table is optimized for AI model consumption, ensuring that the data is pre-processed and structured to allow efficient score calculation.
- The segments (`segment_products_count`, `segment_services_count`) and transaction statuses (`successful_transactions`, `voided_transactions`, `ongoing_transactions`) have been encoded to be readily usable by the AI model.
- The inclusion of metrics like `renegotiation_delay_days` and `median_installment_amount` enhances the accuracy and robustness of the score calculation.


# Data Dictionary - AI Score

This document provides the detailed data dictionary for the `ai_score_results` table, which stores the results of the AI scoring process for endorsers. Each column is described with its data type and purpose.

## Table: `ai_score_results`

| Column Name        | Data Type   | Description                                                                                     |
|--------------------|-------------|-------------------------------------------------------------------------------------------------|
| `result_id`        | UUID        | Unique identifier for each result. Automatically generated using `gen_random_uuid()`.            |
| `entry_date`       | DATE        | The date when the input data was processed by the AI model.                                      |
| `final_score`      | INTEGER     | The final calculated score for the endorser. This value represents the outcome of the scoring process. |
| `input_variables`  | JSONB       | A JSONB object storing the input variables used in the score calculation for the endorser.       |
| `endorser_name`    | VARCHAR(255)| The name of the endorser whose score is being calculated.                                       |
| `created_timestamp`| TIMESTAMP   | Timestamp indicating when the record was created in the database. Defaults to `CURRENT_TIMESTAMP`. |

### Column Details:

- **`result_id`**: This is a unique identifier for each entry in the table, generated automatically using the `gen_random_uuid()` function. It ensures that each result can be uniquely referenced.
  
- **`entry_date`**: Represents the date when the input variables were processed and the score was calculated. This field is required and helps track when the data was handled.

- **`final_score`**: The final score given to the endorser based on the input variables. The score is an integer value and reflects the endorser's overall rating or performance.

- **`input_variables`**: Stores all the input data used to calculate the score. This data is stored in JSONB format to provide flexibility in representing various input fields used by the AI model.

- **`endorser_name`**: The name of the endorser whose score was calculated. This field helps identify the individual or entity associated with the score.

- **`created_timestamp`**: Automatically logs the timestamp when the record was created in the database. This field uses the `CURRENT_TIMESTAMP` function to capture the precise time of creation.
