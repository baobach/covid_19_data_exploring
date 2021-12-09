#Continents with the highest death count by population
SELECT continent, max(total_deaths) as total_death_count
FROM portfolio-project-334404.Covid_Dataset.Covid_Deaths
WHERE continent is not null 
GROUP BY continent
ORDER BY total_death_count desc 

#Global number cases vs deaths
SELECT date, sum(new_cases) as total_cases, sum(new_deaths) as total_deaths, sum(new_deaths)/sum(new_cases)*100 as death_percentage
FROM portfolio-project-334404.Covid_Dataset.Covid_Deaths
WHERE continent is not null
GROUP BY date
ORDER BY 1,2

#Global vaccinated rate using CTE
#CTE
WITH pop_vs_vac as 
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(vac.new_vaccinations) over(partition by dea.location order by dea.location, dea.date) as total_vaccinated
FROM portfolio-project-334404.Covid_Dataset.Covid_Vaccinations vac
JOIN portfolio-project-334404.Covid_Dataset.Covid_Deaths dea
    ON dea.location = vac.location
    and dea.date = vac.date
WHERE dea.continent is not null
)
#ORDER BY 2,3
SELECT *, (total_vaccinated/population)*100 as vaccinated_percentage
FROM pop_vs_vac

#Create view for data visual
CREATE VIEW portfolio-project-334404.Covid_Dataset.vaccinated_rate as
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(vac.new_vaccinations) over(partition by dea.location order by dea.location, dea.date) as total_vaccinated
FROM portfolio-project-334404.Covid_Dataset.Covid_Vaccinations vac
JOIN portfolio-project-334404.Covid_Dataset.Covid_Deaths dea
    ON dea.location = vac.location
    and dea.date = vac.date
WHERE dea.continent is not null
#ORDER BY 2,3
