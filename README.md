# 🦠 COVID-19 Data Exploration (SQL Project)

## 📌 Overview

This project explores global COVID-19 data using SQL. The goal was to analyze trends in cases, deaths, and vaccinations while building strong SQL fundamentals and real-world data analysis skills.

---

## 🛠️ Tools Used

* Microsoft Excel
* Microsoft SQL Server
* SQL Server Management Studio (SSMS)

---

## 📊 Key Concepts Practiced

* Joins (combining multiple datasets)
* Common Table Expressions (CTEs)
* Window Functions (`OVER`, `PARTITION BY`)
* Temporary Tables
* Views
* Data Aggregation and Filtering

---

## 🔍 Key Analysis Performed

* Total cases vs total deaths
* Infection rate compared to population
* Countries with highest infection rates
* Rolling vaccination totals over time
* Percentage of population vaccinated

---

## 🧠 Example Insight

Used window functions to calculate a rolling number of vaccinated individuals per country:

```
SUM(CONVERT(INT, vac.new_vaccinations)) 
OVER (PARTITION BY dea.location ORDER BY dea.date)
```

---

## 📁 Project Structure

* `CovidDeaths` table
* `CovidVaccinations` table
* SQL queries for analysis
* View: `PercentPopulationVaccinated`

---

## 🚧 Work in Progress

This project is still being actively refined. Current improvements in progress include:

* Cleaning and standardizing data for more accurate analysis
* Improving query structure and readability
* Adding more advanced analytical queries

Additionally, a **Tableau dashboard is currently in development** to visualize key insights from this dataset and make the analysis more interactive.

---

## 🚀 What I Learned

This project helped me understand how to:

* Work with real-world datasets
* Debug SQL Server Management Studio (SSMS) issues and connection errors
* Create a working SQL environment ("sandbox") for analysis
* Successfully import and manage data from Excel into SQL Server
* Use advanced SQL features for analysis
* Structure queries for readability and performance

---

## 🔧 Future Improvements

* Further optimize queries for performance
* Expand analysis with deeper insights
* Complete and publish Tableau dashboard
* Build a more automated workflow for data updates

---

