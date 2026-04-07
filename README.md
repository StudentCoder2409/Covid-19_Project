# 🦠 COVID-19 Data Analysis: Global Trends, Mortality, and Vaccination Insights

---

## 🔍 Objective
This project analyzes global COVID-19 data to uncover trends in infection rates, mortality, and vaccination progress. The goal is to transform raw datasets into actionable insights that support data-driven decision-making and resource allocation.

---

## 📊 Dataset
- Global COVID-19 dataset including:
  - Case counts (total & new cases)  
  - Death counts  
  - Population data  
  - Vaccination data  
- Data spans multiple countries and time periods  
- Source tables:
  - `CovidDeaths`
  - `CovidVaccinations`

---

## 🛠 Tools & Technologies
- **SQL (SQL Server)**  
  - Joins  
  - Aggregations  
  - Window Functions  
  - CTEs  
  - Temporary Tables  
  - Views  
- **Excel** (supporting analysis)  
- **Tableau / Power BI** (for dashboard integration via views)

---

## 🧹 Data Cleaning & Preparation
- Removed aggregate rows (e.g., global totals, income groups) to focus on country-level analysis  
- Filtered relevant columns for clarity and consistency  
- Standardized data types for accurate calculations  
- Prepared datasets for time-series and comparative analysis  

---

## 📈 Analysis Performed

### 1. Case Fatality Analysis
- Calculated the likelihood of death after infection  
- Derived **death percentage** per country over time  

### 2. Infection Rate vs Population
- Measured percentage of population infected  
- Compared infection penetration across regions  

### 3. Country-Level Infection Trends
- Identified countries with the highest infection rates  
- Example: The United States reached ~9.77% infection rate  

### 4. Global Infection Comparison
- Ranked countries by infection percentage  
- Highlighted regions with the most widespread outbreaks  

### 5. Death Count by Continent
- Aggregated total deaths by continent  
- Identified regions with the highest mortality impact  

### 6. Global Metrics
- Calculated global case totals and death percentages  
- Provided a high-level overview of pandemic severity  

### 7. Vaccination Progress Analysis
- Used **window functions** to calculate rolling vaccination totals  
- Tracked vaccination progress over time by country  

### 8. Population vs Vaccination (CTE)
- Built a **CTE** to calculate the percentage of the population vaccinated  
- Enabled time-series vaccination tracking  

### 9. Advanced SQL Techniques
- Implemented:
  - Window functions (`PARTITION BY`)  
  - Common Table Expressions (CTEs)  
  - Temporary tables  
  - Views for BI tools  

---

## 🔑 Key Insights
- Significant variation exists in infection and mortality rates across regions  
- Certain countries experienced disproportionately high infection penetration  
- Vaccination rollout speed varied widely between countries  
- Trends indicate multiple waves of infection over time  
- Data highlights regions that may require increased healthcare resources  

---

## 💡 Business Impact
- Enables **data-driven decision-making** for public health strategies  
- Supports **resource allocation planning** for high-risk regions  
- Demonstrates ability to transform raw data into **actionable insights**  
- Provides a scalable dataset for **dashboarding and reporting tools**  

---

## 📊 Data Modeling for Visualization
- Created SQL **views** for integration with Tableau / Power BI  
- Structured data to support dashboard development and reporting  

---

## 🚀 Skills Demonstrated
- Data cleaning and preprocessing  
- SQL querying (joins, aggregations, filtering)  
- Window functions and advanced SQL techniques  
- Exploratory data analysis (EDA)  
- Trend and time-series analysis  
- Data modeling for BI tools  
- Data storytelling and insight generation  
