# 🍽️ Public Health Compliance Food Inspection Analysis

**End-to-End Food Safety Analytics Platform (Chicago & Dallas)**

---

## 📌 Project Overview

Food safety inspections are a critical public-health mechanism, especially in large metropolitan areas with thousands of food establishments. However, inspection datasets are often **fragmented, inconsistent, and difficult to analyze across jurisdictions**.

This project builds a **scalable, production-grade food inspection analytics platform** that unifies inspection data from **Chicago** and **Dallas**, cleans and standardizes it using **modern data engineering best practices**, and delivers **actionable insights** through analytics-ready models and dashboards.

The platform enables stakeholders to:

* Analyze inspection outcomes and compliance trends
* Identify high-risk establishments and violation hotspots
* Compare inspection patterns across cities
* Support data-driven public health decision-making

The solution is implemented using the **Medallion Architecture (Bronze → Silver → Gold)** and demonstrates an **end-to-end analytics pipeline**, from raw ingestion to BI visualization.

---

## 🧠 Key Objectives

* Integrate heterogeneous inspection datasets with **different schemas and violation formats**
* Apply **robust data profiling, cleansing, and transformation**
* Design a **dimensional data model** optimized for analytics
* Ensure **auditability, scalability, and reproducibility**
* Deliver **interactive dashboards** for exploratory and operational insights

---

## 🛠️ Tools & Technologies

| Layer         | Technology                          | Purpose                               |
| ------------- | ----------------------------------- | ------------------------------------- |
| Orchestration | **Azure Data Factory**              | Ingestion & pipeline control          |
| Storage       | **Azure Data Lake Gen2**            | Raw & curated storage (Bronze/Silver) |
| Processing    | **Databricks (PySpark)**            | Cleaning, parsing, transformations    |
| Modeling      | **ER Studio**                       | Dimensional schema design             |
| Warehousing   | **Snowflake**                       | Gold layer analytics & Dynamic Tables |
| Visualization | **Tableau**                         | Interactive dashboards                |
| Profiling     | **Alteryx, Excel, ydata-profiling** | Data quality assessment               |

---

## 🗂️ Datasets

### 📍 Chicago Food Inspections

* Source: Chicago Department of Public Health
* Format: **Long format**
* Violations stored as **pipe-separated free-text strings**
* Includes **risk categories (Risk 1–3)** and inspection results

### 📍 Dallas Food Inspections

* Source: Dallas Code Compliance Services
* Format: **Wide format**
* Up to **25 violation blocks per inspection**
* Geographic coordinates embedded in text fields

> These datasets differ significantly in structure, requiring **custom city-specific transformation pipelines** before unification.
>  

---

## 🏗️ Architecture – Medallion Pattern

```
Raw CSV Files
     ↓
[ Bronze Layer ]
Azure Data Lake (Raw, Unmodified Data)
     ↓
[ Silver Layer ]
Cleaned, Standardized Parquet Files (Databricks)
     ↓
[ Gold Layer ]
Analytics-Ready Facts & Dimensions (Snowflake)
     ↓
Tableau Dashboards
```

### Why Medallion Architecture?

* Clear separation of concerns
* Reprocessing without data loss
* Scalable for additional cities or years
* Audit-friendly and production-ready

---

## 🔍 Data Profiling & Quality Assessment

Before transformations, extensive profiling was conducted to evaluate:

* Null distributions and sparsity
* Data type inconsistencies
* Schema mismatches across years
* Violation density and frequency
* Geographic completeness

### Key Findings

* Dallas violation columns beyond Violation 5 were **>99% null**
* Chicago violations required **regex-based parsing**
* ZIP codes frequently stored as floats
* Mixed date and score formats across datasets

Profiling informed **selective transformations**, avoiding unnecessary computation and preserving data integrity.

---

## 🧹 Data Cleaning & Transformation

### Dallas (Wide → Long)

* Unpivoted violation blocks into analyzable structures
* Extracted latitude & longitude via regex
* Normalized address components into a single field
* Converted scores and dates to proper types

### Chicago (Text Parsing)

* Split pipe-separated violation strings
* Extracted violation codes, descriptions, and comments
* Standardized risk levels and inspection results
* Filled missing geographic and administrative fields

Transformations were implemented using:

* **PySpark notebooks in Databricks**
* **Reusable, modular logic** for maintainability

---

## 🧪 Staging & Integration

### Databricks Notebooks (Execution Order)

1. **Chicago_Data_Transformation.ipynb**

   * Reads Silver-layer Chicago Parquet
   * Cleans, parses, standardizes
   * Writes to `stg_chicago` (Snowflake)

2. **Dallas_Data_Transformation.ipynb**

   * Processes wide Dallas data
   * Normalizes violations & geolocation
   * Writes to `stg_dallas` (Snowflake)

3. **Merge_Dallas_Chicago_Data.ipynb**

   * Combines both staging tables
   * Adds:

     * `source` (Chicago / Dallas)
     * `job_id` (UUID)
     * `load_dt` (ingestion timestamp)
   * Outputs unified `stg_final_table`

---

## 🧱 Dimensional Modeling (Gold Layer)

From the unified staging table:

* Facts and dimensions are loaded using **Snowflake Dynamic Tables**
* Supports **incremental refresh and dependency tracking**

### Example Entities

* `fact_inspections`
* `dim_establishment`
* `dim_location`
* `dim_violation`
* `dim_date`

This model enables:

* Fast analytical queries
* Clean joins for BI tools
* Historical trend analysis

---

## 📊 Tableau Dashboards


<img width="1899" height="949" alt="Violation Dashboard" src="https://github.com/user-attachments/assets/038ece89-a844-4323-b7cc-4e4dd8da3188" />


The dashboards provide:

* Inspection outcome distributions
* Risk-based hotspot analysis
* Violation frequency and severity trends
* Facility-level compliance views
* Geographic clustering of failed inspections

Designed for **public health officials, analysts, and policymakers** to quickly surface risk patterns and prioritize interventions.

---

## 🔐 Auditability & Governance

Every record is tagged with:

* `job_id` – unique pipeline execution
* `load_dt` – ingestion timestamp
* `source` – originating city

This ensures:

* Full lineage tracking
* Reproducibility
* Compliance with analytics best practices

---

## 🚀 How to Run the Project

### Prerequisites

* Azure account (ADF + Data Lake)
* Databricks workspace
* Snowflake warehouse
* Tableau Desktop or Server

### High-Level Steps

1. Ingest raw CSV/TSV files into **Bronze Layer**
2. Run ADF pipeline to produce **Silver Parquet**
3. Execute Databricks notebooks (Chicago → Dallas → Merge)
4. Run Snowflake Dynamic Table SQL
5. Connect Tableau to Gold tables

---

## 🌟 Key Highlights

* End-to-end **data engineering + analytics** project
* Handles **real-world messy government data**
* Modular, scalable, and city-agnostic design
* Strong emphasis on **data quality and profiling**
* Production-style architecture suitable for enterprise use

---

## 📌 Future Enhancements

* Add additional cities and inspection agencies
* Automate violation severity scoring
* Integrate predictive risk modeling
* Deploy dashboards to Tableau Server / Power BI Service
* Add alerting for high-risk establishments
