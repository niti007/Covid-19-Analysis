USE Covid



---------- select particular columns of the table------------

SELECT [location],[date],total_cases,new_cases,total_deaths,population FROM [dbo].[dboCovid deaths]
order by 1,2

---------Total cases vs Total death--------------------------


SELECT  [location],[date],total_cases,total_deaths,(total_deaths/total_cases)*100 as Pecentage_died 
FROM [dbo].[dboCovid deaths]
order by 5 desc

----------Looking at total cases vs Population----------------------

SELECT  [location],[date],total_cases,population,(total_cases/population)*100 as Pecentage_Cases
FROM [dbo].[dboCovid deaths]
where location like '%states%'
order by 5 desc

-------------Looking at countries with highest infection rate campared to population------------------------
SELECT [location],[population],MAX(total_cases) AS HIGHEST_INFECTION, MAX((TOTAL_CASES/POPULATION))*100 AS PERCENTAGE_CASES
FROM [dbo].[dboCovid deaths]
GROUP BY [location],[population]
ORDER BY PERCENTAGE_CASES DESC


------------Looking at countries with highest DEATH campared to population------------------------

SELECT [location],MAX(CAST(total_deaths AS INT)) AS TOTAL_DEATHS
FROM [dbo].[dboCovid deaths]
WHERE continent IS NOT NULL
GROUP BY [location] 
ORDER BY TOTAL_DEATHS DESC

------------Looking at CONTINENT with highest DEATH campared to population------------------------

SELECT continent,MAX(CAST(total_deaths AS INT)) AS TOTAL_DEATHS
FROM [dbo].[dboCovid deaths]
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TOTAL_DEATHS DESC


------------Looking at TOTAL CASES by date ------------------------

SELECT date,SUM(TOTAL_CASES) FROM [dbo].[dboCovid deaths]
GROUP BY date
ORDER BY 1

-----------------Looking at Total Population vs Vaccinations----------------------------------

select t1.continent,t1.location, t1.date,t1.population,
t2.new_vaccinations,sum(t2.new_vaccinations) over (partition by t1.location,T1.DATE) AS ROLLING_PEOPLE_VACCINATED
from [dbo].[dboCovid deaths]AS T1
INNER JOIN [dbo].[Covid_Vaccination] AS T2
ON
T1.location=T2.location AND
T1.date=T2.date
order by 2,3



-------------------CREATE VIEW FOR PERCENT POPULATION VACCINATED---------------------------------------------------

CREATE view percent_population_vaccinated as
select t1.continent,t1.location, t1.date,t1.population,
t2.new_vaccinations,sum(t2.new_vaccinations) over (partition by t1.location,T1.DATE) AS ROLLING_PEOPLE_VACCINATED
from [dbo].[dboCovid deaths]AS T1
INNER JOIN [dbo].[Covid_Vaccination] AS T2
ON
T1.location=T2.location AND
T1.date=T2.date
--order by 2,3






