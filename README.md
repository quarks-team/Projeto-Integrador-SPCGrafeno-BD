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
