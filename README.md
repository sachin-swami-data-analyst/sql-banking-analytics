# sql-banking-analytics
Banking Analytics project using SQL to analyze customers, accounts, balances, and transaction activity.
# 🏦 Banking Analytics SQL Project

## 📌 Project Overview

This project is a Banking Analytics SQL project designed to analyze customers, accounts, and transaction data.

The project demonstrates practical SQL techniques used for data analysis, reporting, data transformation, and business-oriented analysis.

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
