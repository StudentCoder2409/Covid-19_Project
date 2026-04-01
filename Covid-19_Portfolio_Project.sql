/* =========================================================
   PROJECT: COVID-19 Data Analysis Portfolio Project
   AUTHOR: StudentCoder2409
   DESCRIPTION:
   This project analyzes global COVID-19 trends including:
   - Infection rates
   - Death rates
   - Vaccination progress
   - Population impact
   ========================================================= */


/* =========================================================
   SECTION 1: DATA CLEANING & FILTERING
   ========================================================= */

-- Filter out aggregate rows (e.g., World, income groups)
SELECT *
FROM dbo.CovidDeaths
WHERE continent IS NOT NULL
ORDER BY location, date;


/* =========================================================
   SECTION 2: CORE DATA SELECTION
   ========================================================= */

-- Selecting relevant columns for analysis
SELECT 
    location,
    date,
    total_cases,
    new_cases,
    total_deaths,
    population
FROM dbo.CovidDeaths
WHERE continent IS NOT NULL
ORDER BY location, date;


/* =========================================================
   SECTION 3: CASE VS DEATH ANALYSIS
   ========================================================= */

-- Insight:
-- Calculates likelihood of death after infection (case fatality rate)
SELECT 
    location,
    continent,
    date,
    total_cases,
    total_deaths,
    (total_deaths * 1.0 / total_cases) * 100 AS death_percentage
FROM dbo.CovidDeaths
WHERE continent IS NOT NULL
  AND location LIKE '%states%'
ORDER BY location, date;


/* =========================================================
   SECTION 4: CASES VS POPULATION
   ========================================================= */

-- Insight:
-- Shows what percentage of the population has been infected
SELECT 
    continent,
    location,
    date,
    total_cases,
    population,
    (total_cases * 1.0 / population) * 100 AS percent_population_infected
FROM dbo.CovidDeaths
WHERE continent IS NOT NULL
  AND location LIKE '%states%'
ORDER BY location, date;


/* =========================================================
   SECTION 5: HIGHEST INFECTION RATE (USA)
   ========================================================= */

-- Insight:
-- Maximum infection rate in the United States (~9.77%)
SELECT 
    location,
    MAX(total_cases) AS highest_infection_count,
    population,
    MAX((total_cases * 1.0 / population)) * 100 AS percent_population_infected
FROM dbo.CovidDeaths
WHERE continent IS NOT NULL
  AND location LIKE '%states%'
GROUP BY location, population
ORDER BY percent_population_infected DESC;


/* =========================================================
   SECTION 6: GLOBAL INFECTION COMPARISON
   ========================================================= */

-- Insight:
-- Identifies countries with the highest infection rates
SELECT 
    location,
    MAX(total_cases) AS highest_infection_count,
    population,
    MAX((total_cases * 1.0 / population)) * 100 AS percent_population_infected
FROM dbo.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY percent_population_infected DESC;


/* =========================================================
   SECTION 7: DEATH COUNT BY CONTINENT
   ========================================================= */

-- Insight:
-- Highlights continents with the highest total deaths
SELECT 
    continent,
    MAX(CAST(total_deaths AS INT)) AS total_death_count
FROM dbo.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY total_death_count DESC;


/* =========================================================
   SECTION 8: GLOBAL METRICS
   ========================================================= */

-- Insight:
-- Global death percentage across all reported cases
SELECT 
    SUM(new_cases) AS total_cases,
    SUM(CAST(new_deaths AS INT)) AS total_deaths,
    (SUM(CAST(new_deaths AS INT)) * 1.0 / SUM(new_cases)) * 100 AS death_percentage
FROM dbo.CovidDeaths
WHERE continent IS NOT NULL;


/* =========================================================
   SECTION 9: VACCINATION ANALYSIS (WINDOW FUNCTION)
   ========================================================= */

-- Insight:
-- Running total of vaccinations per country
SELECT 
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM(CONVERT(INT, vac.new_vaccinations)) 
        OVER (PARTITION BY dea.location ORDER BY dea.date) 
        AS rolling_people_vaccinated
FROM dbo.CovidVaccinations vac
JOIN dbo.CovidDeaths dea
    ON dea.location = vac.location
   AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY dea.location, dea.date;


/* =========================================================
   SECTION 10: CTE - POPULATION VS VACCINATION
   ========================================================= */

-- Insight:
-- Percentage of population vaccinated over time
WITH PopVsVac AS (
    SELECT 
        dea.continent,
        dea.location,
        dea.date,
        dea.population,
        vac.new_vaccinations,
        SUM(CONVERT(INT, vac.new_vaccinations)) 
            OVER (PARTITION BY dea.location ORDER BY dea.date) 
            AS rolling_people_vaccinated
    FROM dbo.CovidVaccinations vac
    JOIN dbo.CovidDeaths dea
        ON dea.location = vac.location
       AND dea.date = vac.date
    WHERE dea.continent IS NOT NULL
)

SELECT *,
       (rolling_people_vaccinated * 1.0 / population) * 100 AS percent_vaccinated
FROM PopVsVac;


/* =========================================================
   SECTION 11: TEMP TABLE APPROACH
   ========================================================= */

DROP TABLE IF EXISTS #PercentPopulationVaccinated;

CREATE TABLE #PercentPopulationVaccinated (
    continent NVARCHAR(255),
    location NVARCHAR(255),
    date DATETIME,
    population NUMERIC(18,2),
    new_vaccinations NUMERIC(18,2),
    rolling_people_vaccinated NUMERIC(18,2)
);

INSERT INTO #PercentPopulationVaccinated
SELECT 
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM(CONVERT(INT, vac.new_vaccinations)) 
        OVER (PARTITION BY dea.location ORDER BY dea.date)
FROM dbo.CovidVaccinations vac
JOIN dbo.CovidDeaths dea
    ON dea.location = vac.location
   AND dea.date = vac.date
WHERE dea.continent IS NOT NULL;

-- Insight:
-- Final vaccination percentage using temp table
SELECT *,
       (rolling_people_vaccinated * 1.0 / population) * 100 AS percent_vaccinated
FROM #PercentPopulationVaccinated;


/* =========================================================
   SECTION 12: VIEW CREATION (FOR DASHBOARDS)
   ========================================================= */

-- Insight:
-- This view can be used in Tableau / Power BI
CREATE OR ALTER VIEW PercentPopulationVaccinated AS
SELECT 
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM(CONVERT(INT, vac.new_vaccinations)) 
        OVER (PARTITION BY dea.location ORDER BY dea.date) 
        AS rolling_people_vaccinated
FROM dbo.CovidVaccinations vac
JOIN dbo.CovidDeaths dea
    ON dea.location = vac.location
   AND dea.date = vac.date
WHERE dea.continent IS NOT NULL;
