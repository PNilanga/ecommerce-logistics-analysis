# E-Commerce Delivery Logistics & Customer Satisfaction Audit

## 📌 Executive Summary
This project analyzes the logistics performance of a Brazilian e-commerce company (Olist) to determine the impact of shipping delays on customer satisfaction. Using **Python**, **PostgreSQL**, and **Power BI**, I built an automated data pipeline and interactive dashboard that identified critical bottlenecks in the supply chain. 

**Key Findings:**
* **Delays Destroy Reviews:** Verified a massive correlation between shipping delays and negative customer feedback (Average score dropped from 4.21 for on-time orders to 2.55 for delayed orders).
* **The Problematic Category:** Identified "Bed, Bath, and Table" (bulky/fragile items) as the product category suffering the highest volume of logistical failures.
* **Geographic Bottlenecks:** Mapped delivery failures and isolated São Paulo (SP) and Rio de Janeiro (RJ) as the primary regions requiring immediate carrier contract renegotiations.

---

## 🛠️ Tech Stack & Architecture
* **Data Ingestion (ETL):** Python (Pandas, SQLAlchemy)
* **Database Engine:** PostgreSQL
* **Data Transformation:** Advanced SQL (CTEs, Window Functions, Type Casting)
* **Data Visualization:** Power BI

---

## 🚀 Methodology

### 1. Automated Data Ingestion
Instead of manually configuring schemas and using GUI import tools, I wrote a Python script to automate the data loading process. The script uses Pandas to infer the schema from raw CSVs and SQLAlchemy to bulk-load over 100,000 rows into a local PostgreSQL database, ensuring idempotency (`if_exists='replace'`).

### 2. Data Modeling & Extraction
To answer the core business questions, I wrote a Master SQL Query utilizing **Common Table Expressions (CTEs)** to create a clean, analytical dataset. 
* Extracted delivery timeframes by calculating the epoch difference between timestamps.
* Engineered a new categorical feature (`delivery_status`) to flag 'Delayed' vs. 'On Time' orders.
* Handled data type mismatches (explicit `::TIMESTAMP` casting) and safely merged 5 relational tables (`Orders`, `Customers`, `Reviews`, `Products`, `Order_Items`) using `LEFT JOIN`s to prevent data loss.

### 3. Business Intelligence Dashboard
Connected the transformed SQL output to **Power BI** to build an interactive operations dashboard.
* Handled **Schema Drift** and data type errors within Power Query Editor to ensure accurate aggregations (averages vs. counts).
* Designed targeted visualizations including a clustered bar chart for product categories and a geographic heatmap to isolate regional logistics failures.

---

## 📂 Repository Structure
* `load_data.py`: The Python script used to automate the CSV-to-PostgreSQL pipeline.
* `master_query.sql`: The SQL script containing the CTEs and joins used to model the data.
* `Dashboard_Screenshot.png`: A high-resolution image of the final Power BI report.
* `/data`: (Note: Raw CSV files are not uploaded due to size limits, but can be found on Kaggle under the 'Olist E-Commerce Dataset').
