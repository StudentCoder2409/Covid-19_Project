SELECT *
FROM dbo.CovidDeaths
WHERE continent is not null
order by 3,4

--SELECT *
--FROM dbo.CovidVaccinations
--order by 3,4

-- SELECT Data that we are going to be using

SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM dbo.CovidDeaths
WHERE continent is not null
order by 1,2

-- Looking at total_cases vs total_deaths
-- Shows likelyhood of dying if you contract the covid_19 in the United States 
SELECT Location, continent, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Death_Ratio
FROM dbo.CovidDeaths
WHERE continent is not null
AND location like '%states%'
order by 1,2

-- Looking at total cases vs population
-- Shows percentage of population got Covid
SELECT continent, location, date, total_cases, Population, (total_cases/population)*100 AS Confirmed_cases_in_USA
FROM dbo.CovidDeaths
WHERE location like '%states%'
AND continent is not null
order by 1,2


-- Looking at UnitedStates highest infection rate to compared to population
SELECT continent, MAX(total_cases) AS Highest_Infection_Count, Population, MAX((total_cases/population))*100 AS Confirmed_cases_in_USA
FROM dbo.CovidDeaths
WHERE location like '%states%'
AND continent is not null
GROUP BY continent,Population
order by Confirmed_cases_in_USA
--Shows about 9.77 %

---- Looking at Countries with highest infection rate to compared to population
SELECT continent, MAX(total_cases) AS Highest_Infection_Count, Population, MAX((total_cases/population))*100 AS Percent_population_infected
FROM dbo.CovidDeaths
--WHERE location like '%states%'
GROUP BY continent,Population
order by Percent_population_infected desc


-- Showing continent's with highest death count per population
SELECT continent, MAX(CAST(total_deaths AS INT)) AS Total_Death_Count
FROM dbo.CovidDeaths
--WHERE location like '%states%'
WHERE continent is not null
GROUP BY continent
order by Total_Death_Count desc

-- Showing continents with highest death count
SELECT continent, MAX(CAST(total_deaths AS INT)) AS Total_Death_Count
FROM dbo.CovidDeaths
--WHERE location like '%states%'
WHERE continent is not null
GROUP BY continent
order by Total_Death_Count desc

-- GLOBAL NUMBERS

SELECT SUM(new_cases) as total_cases, SUM(CAST(new_deaths AS INT)) as total_deaths, SUM(CAST(new_deaths AS INT))/SUM(new_cases)*100 as Death_Percentage
FROM dbo.CovidDeaths
--WHERE location like '%states%'
WHERE continent is not null
--GROUP BY date
order by 1,2


--Looking at total population vs vaccination
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(INT,vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location,dea.date)
AS Rolling_people_vaccinated
--, (Rolling_people_vaccinated/population)*100

FROM CovidVaccinations vac
JOIN CovidDeaths dea
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
order by 2,3

--USE CTE

WITH PopvsVac (Continent, location, date, population, new_vaccinations, Rolling_people_vaccinated)
AS (

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(INT,vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date)
AS Rolling_people_vaccinated
--, (Rolling_people_vaccinated/population)*100

FROM CovidVaccinations vac
JOIN CovidDeaths dea
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
--order by 2,3
)

SELECT *, (Rolling_people_vaccinated/population)*100
FROM PopvsVac




-- TEMP TABLE

DROP TABLE IF EXISTS #PercentPopulationVaccinated;

CREATE TABLE #PercentPopulationVaccinated
(
Continent nvarchar(255),
location nvarchar(255),
Date datetime,
population numeric(18,2),
new_vaccinations numeric(18,2),
Rolling_people_vaccinated numeric(18,2)
)

INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(INT,vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date)
AS Rolling_people_vaccinated
--, (Rolling_people_vaccinated/population)*100

FROM CovidVaccinations vac
JOIN CovidDeaths dea
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent is not null
order by 2,3

SELECT *, (Rolling_people_vaccinated * 1.0 / population) * 100
FROM #PercentPopulationVaccinated

-- CREATING VIEW TO STORE DATA

CREATE OR ALTER VIEW PercentPopulationVaccinated AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(INT,vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date)
AS Rolling_people_vaccinated
--, (Rolling_people_vaccinated/population)*100

FROM CovidVaccinations vac
JOIN CovidDeaths dea
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent is not null
--order by 2,3
