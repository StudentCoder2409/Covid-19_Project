# Covid-19_Project
# 🦠 COVID-19 Data Exploration (SQL Project)

## 📌 Overview

This project explores global COVID-19 data using SQL. The goal was to analyze trends in cases, deaths, and vaccinations while building strong SQL fundamentals and real-world data analysis skills.

---

## 🛠️ Tools Used

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

```sql
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

## 🚀 What I Learned

This project helped me understand how to:

* Work with real-world datasets
* Debug SQL errors and environment issues
* Use advanced SQL features for analysis
* Structure queries for readability and performance

---

## 🔧 Future Improvements

* Clean and format SQL scripts for readability
* Add more advanced queries and insights
* Connect to visualization tools like Tableau or Power BI
* Automate data pipeline for updates

---

## 💡 Notes

This project follows a hands-on learning approach, focusing on both technical SQL skills and problem-solving through debugging and iteration.

---
