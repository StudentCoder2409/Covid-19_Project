# 🦠 COVID-19 Data Exploration (SQL Project)

## 📌 Overview

This project analyzes global COVID-19 data using SQL to uncover trends in infection rates, mortality, and vaccination progress.

The focus of this project is to demonstrate **real-world data analysis skills**, including data cleaning, transformation, and exploratory analysis using SQL Server.

---

## 🛠️ Tools & Technologies

* Microsoft Excel (data source & preprocessing)
* Microsoft SQL Server (data storage & querying)
* SQL Server Management Studio (SSMS)

---

## 📊 Core Skills Demonstrated

* SQL Joins (multi-table data integration)
* Common Table Expressions (CTEs)
* Window Functions (`OVER`, `PARTITION BY`)
* Temporary Tables
* View Creation for reporting
* Data Aggregation & Filtering
* Data Cleaning & Type Conversion

---

## 🔍 Analysis Highlights

* **Case Fatality Rate**
  Calculated likelihood of death after infection across regions

* **Infection Rate vs Population**
  Identified countries with the highest percentage of population infected

* **Global Trends**
  Aggregated worldwide case and death statistics

* **Vaccination Progress**
  Tracked cumulative vaccinations using window functions

* **Population Vaccination Percentage**
  Measured vaccine rollout effectiveness over time

---

## 🧠 Example (Window Function)

```sql
SUM(CONVERT(INT, vac.new_vaccinations)) 
OVER (PARTITION BY dea.location ORDER BY dea.date)
```

This calculates a **running total of vaccinations per country**, enabling time-series analysis of vaccine distribution.

---

## 📁 Project Structure

* `CovidDeaths` — case, death, and population data
* `CovidVaccinations` — vaccination data
* SQL queries for analysis
* View: `PercentPopulationVaccinated` (for BI tools like Tableau)

---

## 📈 Key Insights

* Infection rates varied significantly across countries, with some exceeding **~9% of total population**
* Death rates were not uniform, indicating differences in healthcare response and reporting
* Vaccination rollouts showed **clear upward trends over time**, with large variance between countries
* Window functions provided an efficient way to analyze cumulative metrics without subqueries

---

## 🚧 Work in Progress

This project is actively being improved:

* Refining data cleaning for higher accuracy
* Improving query structure and performance
* Expanding analysis with deeper insights

📊 A **Tableau dashboard is currently in development** to visualize key findings and enhance interactivity.

---

## 🚀 What I Learned

* How to work with real-world, imperfect datasets
* Debugging and managing SQL Server environments (SSMS)
* Importing and structuring data from Excel into SQL
* Writing scalable, readable, and analytical SQL queries
* Applying SQL to solve real business-style problems

---

## 🔧 Future Improvements

* Optimize queries for performance and scalability
* Add advanced analytical queries (trend analysis, comparisons)
* Publish Tableau dashboard
* Automate data pipeline for updates

---
