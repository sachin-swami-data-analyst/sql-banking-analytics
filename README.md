# sql-banking-analytics
A banking organization needs to monitor customer balances, transaction activity, account performance, and customer segments to identify high-value customers, dormant accounts, unusual transaction patterns, and cash-flow trends.
# 🏦 Banking Analytics SQL Project

## 📌 Project Overview

This project is a Banking Analytics SQL project designed to analyze customers, accounts, and transaction data.

The project demonstrates practical SQL techniques used for data analysis, reporting, data transformation, and business-oriented analysis.

---

## 📊 Key Business Questions

- Which customers have the highest total account balances?
- Which accounts have balances above the overall average?
- Which customer segments have the highest account balances?
- Which accounts have never recorded a transaction?
- Which accounts have the highest transaction activity?
- What is the net cash flow for each account?
- Which accounts rank highest within each customer segment?
- Which customers own multiple accounts?
- What are the highest and second-highest account balances?

  ---

## 🛠️ SQL Skills Demonstrated

- SELECT, WHERE, ORDER BY
- GROUP BY & HAVING
- INNER JOIN & LEFT JOIN
- Aggregate Functions
- CASE Statements
- NULL Handling
- Subqueries
- CTEs
- Window Functions
- ROW_NUMBER()
- RANK()
- DENSE_RANK()
- NTILE()
- LAG() & LEAD()
- FIRST_VALUE() & LAST_VALUE()
- Views
- Temporary Tables
- CTAS
- Stored Procedures
- Triggers
- Date & String Functions
  
  ---
  
## 🎯 Project Objectives

The main objectives of this project are:

- Analyze customer and account information
- Analyze transaction activity
- Identify high-value accounts and customers
- Calculate account and transaction metrics
- Categorize accounts based on balance
- Analyze transaction patterns
- Perform ranking and comparison analysis
- Handle NULL values and data formatting
- Create reusable SQL objects such as Views and Stored Procedures
- Demonstrate database automation using Triggers

---

## 🗂️ Data Domain

The project works with three major banking entities:

- **Customers**
- **Accounts**
- **Transactions**

---

## 🛠️ Tools & Technologies

- MySQL
- SQL
- MySQL Workbench

---

## 🧠 SQL Concepts Demonstrated

### 1. Row-Level SQL Analysis

The project uses SQL functions for:

- Text formatting
- String concatenation
- Username generation
- String length calculation
- Text replacement
- Numeric rounding
- Date extraction
- Date calculations
- Date formatting
- NULL handling
- `IFNULL()`
- `COALESCE()`
- `NULLIF()`
- `CASE` statements
- Data categorization

Example analysis includes creating cleaned customer names, generating usernames, calculating account opening durations, and categorizing account balances.

---

### 2. Aggregate Functions

The project uses:

- `SUM()`
- `AVG()`
- `COUNT()`
- `MIN()`
- `MAX()`
- `GROUP BY`
- `HAVING`

Transaction totals, average transaction amounts, transaction counts, and account balance statistics are calculated using aggregate functions.

---

### 3. Window Functions

The project demonstrates advanced window functions including:

- `ROW_NUMBER()`
- `RANK()`
- `DENSE_RANK()`
- `NTILE()`
- `LAG()`
- `LEAD()`
- `FIRST_VALUE()`
- `LAST_VALUE()`

These functions are used for ranking accounts, comparing transactions, calculating account-level metrics, and analyzing transaction sequences.

---

### 4. Subqueries

Subqueries are used to:

- Find accounts with balances above the average
- Identify customers who own accounts
- Find the highest account balance within each branch

---

### 5. Common Table Expressions (CTEs)

CTEs are used to simplify complex queries and perform multi-step analysis.

Examples include:

- Calculating total customer balances
- Ranking accounts within customer segments
- Calculating deposits and withdrawals
- Calculating net cash flow

---

### 6. Views

The project creates reusable views for:

- Customer total balances
- Dormant accounts
- Successful transactions with customer and account information

---

### 7. CTAS & Temporary Tables

The project demonstrates:

- Creating tables using `CREATE TABLE AS SELECT`
- Creating temporary tables
- Storing account-level transaction summaries
- Filtering high-transaction accounts

---

### 8. Stored Procedures

Stored procedures are created to retrieve:

- Customers based on customer segment
- Transaction history for a specific account
- Accounts below a specified balance

---

### 9. Triggers

The project demonstrates database automation using triggers for:

- Logging newly inserted transactions
- Preventing negative transaction amounts
- Automatically updating account balances after transactions

---
## 💡 Key Insights

The analysis of the banking dataset generated the following business insights:

- The dataset contains **40 customers, 60 accounts, and 100 transactions**.
- The total account balance across all accounts is **₹2.37 Crore**, with an average account balance of approximately **₹3.96 Lakhs**.
- **22 accounts** have balances above the overall average account balance.
- The **Retail customer segment** holds the highest total account balance at approximately **₹1.19 Crore**, followed by the Premium segment at approximately **₹1.07 Crore**.
- The top customer by total account balance holds approximately **₹17.33 Lakhs** across their accounts.
- **20 customers** own more than one account, highlighting opportunities for multi-account customer analysis.
- Transaction analysis shows **100 transactions**, of which **89 were successful**, **8 were pending**, and **3 were failed**.
- Deposits totaled approximately **₹16.16 Lakhs**, while withdrawals totaled approximately **₹6.61 Lakhs**, resulting in a **net deposit inflow of approximately ₹9.55 Lakhs** before considering other transaction types.
- **20 accounts** have no recorded transactions in the dataset and can be flagged for further dormant-account or customer-engagement analysis.
- Window functions were used to rank accounts within customer segments and identify high-value accounts.

---

## 📁 Project Structure

```text
sql-banking-analytics/
│
├── README.md
│
└── SQL/
    ├── SQL_Row_Level.sql
    ├── Window_Aggregation_Functions.sql
    └── Advance_SQL_Techniques.sql
