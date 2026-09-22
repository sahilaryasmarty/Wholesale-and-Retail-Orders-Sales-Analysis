<div align="center">

# 📊 SQL Sales & Product Supplier Analysis

### Turning raw sales data into meaningful business insights with MySQL

[![SQL](https://img.shields.io/badge/SQL-MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Analysis](https://img.shields.io/badge/Focus-Business%20Analytics-6C63FF?style=for-the-badge)](#-project-overview)
[![Dataset](https://img.shields.io/badge/Data-Kaggle-20BEFF?style=for-the-badge&logo=kaggle&logoColor=white)](https://www.kaggle.com/)

</div>

---

## 🧭 Table of Contents

- [📌 Project Overview](#-project-overview)
- [🎯 Objectives](#-objectives)
- [🗂️ Dataset Information](#️-dataset-information)
- [🛠️ Tools & SQL Skills](#️-tools--sql-skills)
- [🧩 Project Structure](#-project-structure)
- [🔍 Analysis Areas](#-analysis-areas)
- [💡 Key Business Insights](#-key-business-insights)
- [📈 Business Value](#-business-value)
- [🏁 Conclusion](#-conclusion)
- [🚀 How to Use](#-how-to-use)
- [👤 Author](#-author)

---

## 📌 Project Overview

This project explores sales and product-supplier data using **MySQL**. It examines customer purchasing activity, product and category performance, supplier contributions, revenue, estimated costs and profit, and delivery trends.

The project contains **52 analytical SQL questions** followed by **10 business-insight queries**. It demonstrates how structured queries can turn raw business records into clear summaries that support reporting and business understanding.

> 📍 **Data source:** Kaggle  
> 🗄️ **Database:** `sales_db`  
> 📋 **Tables:** `orders`, `product_supplier`

---

## 🎯 Objectives

- 👥 Measure order activity and unique customer participation.
- 🛍️ Identify products and categories contributing to sales.
- 💰 Summarize sales revenue and estimate cost and profit.
- 🏢 Compare supplier sales and product portfolios.
- 📅 Explore yearly and monthly sales patterns.
- 🚚 Examine delivery durations and unusually long deliveries.
- 🧾 Identify customers with high total spending.
- 🔎 Find catalog products that have no matching orders.
- 📊 Convert query results into concise business insights.

---

## 🗂️ Dataset Information

| Dataset table | Records stated in project | Description |
|---|---:|---|
| `orders` | 185,013 | Order, customer, product, quantity, price, cost and delivery fields |
| `product_supplier` | 5,504 | Product, category, product-line and supplier information |

### 🔗 Relationship

The analysis joins the two tables using the shared `product_id` field:

```sql
SELECT
    o.order_id,
    o.product_id,
    p.product_name,
    o.quantity_ordered,
    o.total_retail_price
FROM orders AS o
INNER JOIN product_supplier AS p
    ON o.product_id = p.product_id;
```

---

## 🛠️ Tools & SQL Skills

### Tools
- 🐬 **MySQL** — querying and analysis
- 🖥️ **MySQL Workbench** — running and reviewing SQL queries
- 🐙 **GitHub** — project documentation and version control

### SQL concepts demonstrated

`SELECT` · `WHERE` · `DISTINCT` · `ORDER BY` · `LIMIT` · `GROUP BY` · `HAVING` · `CASE` · `INNER JOIN` · `LEFT JOIN` · `IS NULL` · `SUBQUERIES` · `COUNT()` · `SUM()` · `AVG()` · `MIN()` · `MAX()` · `DATEDIFF()` · `YEAR()` · `MONTH()` · arithmetic calculations

---

## 🧩 Project Structure

The SQL script is organized into a guided sequence:

| Section | What it covers |
|---|---|
| 1 | Basic data exploration |
| 2 | Sales and revenue analysis |
| 3 | Customer analysis |
| 4 | Product performance |
| 5 | Sales classification |
| 6 | Time-based sales analysis |
| 7 | Delivery performance |
| 8 | Supplier analysis |
| 9 | Product and supplier joins |
| 10 | Advanced analysis with subqueries |
| 11 | Estimated cost and profit |
| 12 | Business insights and findings |
| 13 | Project conclusion |

---

## 🔍 Analysis Areas

### 👥 Customer Analysis
- Total and unique customers
- Customer status distribution
- Sales and average order value by status
- Highest-spending customers
- Customers spending above the average

### 🛍️ Product & Category Analysis
- Products ordered and total quantity sold
- Top products by revenue
- Sales and quantity by category
- Product sales-volume classification
- Products listed in the catalog with no orders

### 🏢 Supplier Analysis
- Product counts by supplier
- Supplier country and product-line summaries
- Supplier sales contribution
- Top suppliers by sales

### 💵 Revenue, Cost & Profit
- Total retail sales and average order value
- Estimated cost using quantity and unit cost
- Estimated profit by product and category
- Overall estimated revenue, cost and profit

### 📅 Time & Delivery Analysis
- Earliest and latest order dates
- Orders by year and month
- Monthly sales trends
- Average and maximum delivery duration
- Orders with delivery times above the average

---

## 💡 Key Business Insights

The following findings are transcribed from the project’s recorded insight notes. Values should be checked against the final query outputs before publication.

| # | Business question | Recorded finding |
|---:|---|---|
| 1 | Which customer status generates the highest sales? | **Silver** — 12,884,922.29 in total sales |
| 2 | Which products generate the highest revenue? | The recorded top 10 include Family Holiday 4, Hurricane 4, Family Holiday 6, Expedition Dome 3, Comfort Shelter, and five other products listed in the SQL insight section. |
| 3 | Which category generates the highest sales? | **Outdoors** — 5,688,483.11 in total sales |
| 4 | Which product has the highest quantity sold? | **Petanque Balls Chromium 8-pack** — 1,700 units |
| 5 | Which supplier generates the highest sales? | **Eclipse Inc** — 3,681,765.17 |
| 6 | Which supplier has the largest product portfolio? | **Eclipse Inc** — 1,115 products |
| 7 | Which months have the highest and lowest sales? | Highest: **December 2021** — 930,156.18. Lowest: **September 2017** — 210,577.34. |
| 8 | What is the delivery-time finding? | Recorded average: **1.0568 days**; longest: **30 days**, order **123352157**. The notes also mention many unusually long deliveries in the 25–30 day range. |
| 9 | Which product has the highest estimated profit? | **Family Holiday 4** — 282,460.50 |
| 10 | Which customer spends above the average? | Customer **7766** — 6,826.30, identified in the notes as above average. |

> ⚠️ **Validation note:** The recorded average delivery time of 1.0568 days appears inconsistent with the same notes describing many deliveries of 25–30 days. Re-run the query and verify the result, date fields, and any null or invalid dates before treating it as a final finding. The other figures and rankings are also project notes, not independently recalculated here.

---

## 📈 Business Value

This analysis can help readers explore:

- Where sales are concentrated across customer statuses, products and categories.
- Which suppliers account for substantial sales or product breadth.
- How sales vary over time.
- Which products have no recorded orders.
- How order value, estimated profitability and delivery duration can be examined with SQL.

These are analytical observations from the dataset; they do not by themselves establish causes or guarantee future performance.

---

## 🏁 Conclusion

This project demonstrates the practical use of **MySQL for business data analysis**. Through 52 SQL questions and 10 focused business insights, it explores customer activity, product performance, supplier contributions, sales trends, estimated costs and profits, and delivery timelines.

The work applies foundational and intermediate SQL techniques—including aggregation, grouping, filtering, conditional logic, joins and subqueries—to organize business data into interpretable results.

Overall, the project showcases how SQL can support structured exploration, reporting and data-informed business understanding.

---

## 🚀 How to Use

1. Download or clone this repository.
2. Open the `.sql` project file in **MySQL Workbench**.
3. Ensure the `sales_db` database and both tables (`orders` and `product_supplier`) are available.
4. Run the script in sections, reviewing each result set.
5. Verify the recorded business insights against the query outputs.

```sql
USE sales_db;
```

> 💡 Run the queries against the matching dataset schema. Column names and data types must match those used in the script.

---

## 👤 Author

<div align="center">

### **Sahil Arya**

*SQL • Data Analysis • Business Insights*

</div>

---

<div align="center">

⭐ If you find this project useful, consider giving the repository a star!

**Made with 💙 and SQL**

</div>
