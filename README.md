# sql-data-warehouse-project
Building a MySQL based modern data warehouse with integrated ETL, data modeling, and analytics.
# Data Warehouse Project

# Data Warehouse Project

## 📌 Overview

This project focuses on building a **Data Warehouse using MySQL**, following a layered **Bronze, Silver, and Gold architecture**.

The Data Warehouse integrates data coming from **CRM** and **ERP** source systems. The data is progressively processed through each layer, moving from raw source data to cleaned and standardized data, and finally to business-ready data for analytical consumption.

### Architecture

```text
CRM (CSV) ──────┐
                │
                ▼
ERP (CSV) ──────┤
                │
                ▼
        ┌─────────────────┐
        │  Bronze Layer   │
        │    Raw Data     │
        │     Tables      │
        └────────┬────────┘
                 │
                 ▼
        ┌─────────────────┐
        │  Silver Layer   │
        │ Cleaned &       │
        │ Standardized    │
        │     Tables      │
        └────────┬────────┘
                 │
                 ▼
        ┌─────────────────┐
        │   Gold Layer    │
        │ Business-Ready  │
        │      Views      │
        └────────┬────────┘
                 │
        ┌────────┼─────────┐
        ▼        ▼         ▼
       BI     Ad-Hoc      Machine
    Reporting  Queries    Learning
```

---

## 🗂️ Source Systems

The Data Warehouse receives data from two source systems:

### CRM

Customer Relationship Management data provided as **CSV files**.

### ERP

Enterprise Resource Planning data provided as **CSV files**.

The source data is loaded into the Bronze layer before any transformations are applied.

---

# 🥉 Bronze Layer

The Bronze layer stores the **raw data** coming directly from the source systems.

### Object Type

**Tables**

### Load

* Batch processing
* Full load
* Truncate & Insert

### Transformations

**None**

The purpose of the Bronze layer is to preserve the source data in its raw form and provide the initial layer of the Data Warehouse.

---

# 🥈 Silver Layer

The Silver layer contains **cleaned and standardized data**.

Data from the Bronze layer is transformed to improve its quality and consistency before being used by the Gold layer.

### Object Type

**Tables**

### Load

* Batch processing
* Full load
* Truncate & Insert

### Transformations

The Silver layer performs:

* Data cleaning
* Data standardization
* Data normalization
* Derived columns
* Data enrichment

### Data Model

No specific analytical data model is applied at this layer.

The Silver layer focuses primarily on preparing reliable and consistent data for the next stage.

---

# 🥇 Gold Layer

The Gold layer contains **business-ready data** prepared for analytical consumption.

Unlike the Bronze and Silver layers, the Gold layer uses **views** rather than physically loaded tables.

### Object Type

**Views**

### Load

**No physical load**

The Gold layer is built from the transformed Silver data.

### Transformations

The Gold layer performs higher-level transformations including:

* Data integration
* Aggregations
* Business logic

### Data Models

The Gold layer can organize business-ready data using:

* **Star Schema**
* **Flat Tables**
* **Aggregated Tables**

The purpose of this layer is to provide data in a format that is ready to be consumed by analytical tools and users.

---

# 📊 Data Consumption

The final Gold layer data can be consumed for different analytical purposes.

### BI & Reporting

Business intelligence and reporting tools can use the business-ready Gold layer to create reports and dashboards.

### Ad-Hoc SQL Queries

Users can directly query the Gold layer to perform exploratory and ad-hoc analysis.

### Machine Learning

The business-ready data can also serve as a data source for machine learning workflows.

---

# 🔄 Data Flow

The overall pipeline follows this process:

```text
        SOURCE SYSTEMS
       ┌───────────────┐
       │ CRM / ERP CSV │
       └───────┬───────┘
               │
               ▼
        ┌─────────────┐
        │   BRONZE    │
        │  Raw Tables │
        └──────┬──────┘
               │
               │ Cleaning
               │ Standardization
               │ Normalization
               │ Enrichment
               ▼
        ┌─────────────┐
        │   SILVER    │
        │ Clean Tables │
        └──────┬──────┘
               │
               │ Integration
               │ Aggregation
               │ Business Logic
               ▼
        ┌─────────────┐
        │    GOLD     │
        │  SQL Views  │
        └──────┬──────┘
               │
       ┌───────┼────────┐
       ▼       ▼        ▼
      BI     SQL      Machine
   Reporting Queries   Learning
```

---

# 🎯 Project Objectives

The main objectives of this project are to:

* Build a Data Warehouse using **MySQL**.
* Implement a **Bronze / Silver / Gold** architecture.
* Integrate data from **CRM and ERP** source systems.
* Load raw data into the Bronze layer.
* Clean and standardize data in the Silver layer.
* Apply business transformations in the Gold layer.
* Prepare business-ready data for analytical consumption.
* Practice Data Warehouse development using SQL.

---

# 🛠️ Technologies

* **MySQL**
* **SQL**
* **CSV**
* **Git & GitHub**

---

# 📂 Project Structure

```text
data-warehouse-project/
│
├── datasets/
│   ├── source_crm/
│   └── source_erp/
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

# 📚 Concepts Demonstrated

This project provides practical experience with:

* Data Warehousing
* ETL
* Bronze / Silver / Gold architecture
* Data Integration
* Data Cleaning
* Data Standardization
* Data Normalization
* Data Enrichment
* Derived Columns
* Aggregations
* Business Logic
* SQL Views
* Star Schema
* Flat Tables
* Aggregated Tables
* Batch Processing
* Full Load
* Data Analytics

---

## 👤 Author

**Anis Fegas**

This project is part of my learning journey in **Data Analytics, Business Intelligence, and Data Warehousing**.
