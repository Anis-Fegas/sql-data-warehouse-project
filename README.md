# sql-data-warehouse-project
Building a MySQL based modern data warehouse with integrated ETL, data modeling, and analytics.
# Data Warehouse Project

##  Overview

This project focuses on building a **Data Warehouse** using SQL, following a layered architecture based on the **Bronze, Silver, and Gold layers**.

The project covers the process of taking raw data, cleaning and transforming it, and preparing it for analytical use.

The main workflow is:

**Source Data → Bronze → Silver → Gold**

---

##  Architecture

The Data Warehouse is organized into three layers:

###  Bronze Layer

The Bronze layer stores the data in its **raw form**.

The goal of this layer is to load the source data into the Data Warehouse while keeping it as close as possible to the original source.

No major business transformations are applied at this stage.

---

###  Silver Layer

The Silver layer contains **cleaned and transformed data**.

This layer is used to address data quality issues and prepare the data for further processing.

Typical transformations include:

* Cleaning data
* Standardizing values
* Handling inconsistent data
* Correcting data types
* Removing or handling invalid records
* Applying required transformations

---

###  Gold Layer

The Gold layer contains the **final business-ready data**.

It is designed to provide structured data that can be used for analysis and reporting.

The Gold layer represents the final stage of the Data Warehouse pipeline.

---

##  Data Flow

```text
                Source Data
                     │
                     ▼
              ┌─────────────┐
              │   Bronze    │
              │ Raw Data    │
              └──────┬──────┘
                     │
                     ▼
              ┌─────────────┐
              │   Silver    │
              │ Cleaned &   │
              │ Transformed │
              └──────┬──────┘
                     │
                     ▼
              ┌─────────────┐
              │    Gold     │
              │ Business-   │
              │ Ready Data  │
              └─────────────┘
```

---

##  Project Objectives

The main objectives of this project are to:

* Build a Data Warehouse using SQL.
* Implement a Bronze/Silver/Gold architecture.
* Load raw source data into the Bronze layer.
* Clean and transform data in the Silver layer.
* Prepare the final analytical data in the Gold layer.
* Apply data quality checks throughout the process.
* Practice real-world Data Warehouse development concepts.

---

##  Technologies

* **SQL**
* **MySQL / MariaDB**
* **Git & GitHub**

---

##  Project Structure

```text
data-warehouse-project/
│
├── datasets/
│
├── scripts/
│   ├── bronze/
│   ├── silver/
│   └── gold/
│
├── tests/
│
├── docs/
│
└── README.md
```

---

##  Data Quality

Data quality is considered throughout the different layers of the Data Warehouse.

The project includes checks and transformations to identify and handle issues such as:

* NULL values
* Duplicate data
* Invalid values
* Inconsistent formats
* Incorrect data types
* Data consistency issues

---

##  Concepts Practiced

This project provides practical experience with:

* Data Warehousing
* ETL
* Bronze / Silver / Gold architecture
* Data Cleaning
* Data Transformation
* Data Quality
* SQL
* Data Modeling
* Analytical Data Preparation

---

##  Project Workflow

```text
1. Load source data
        ↓
2. Build Bronze layer
        ↓
3. Clean and transform data
        ↓
4. Build Silver layer
        ↓
5. Transform data for analytical use
        ↓
6. Build Gold layer
        ↓
7. Validate the final Data Warehouse
```

---

##  Author

**Anis Fegas**

This project is part of my learning journey in **Data Analytics, Business Intelligence, and Data Warehousing**.
