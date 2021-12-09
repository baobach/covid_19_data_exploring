#Table 1
SELECT SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(New_Cases)*100 as death_percentage
FROM portfolio-project-334404.Covid_Dataset.Covid_Deaths
WHERE  continent is not null 
--Group By date
ORDER BY  1,2

#Table 2
SELECT location, SUM(new_deaths) AS total_deaths_count
FROM portfolio-project-334404.Covid_Dataset.Covid_Deaths
WHERE  continent is null 
and location not in ('World', 'European Union', 'International')
GROUP BY location
ORDER BY total_deaths_count desc

#Table 3
SELECT  location, population, MAX(total_cases) as highest_infection_count,  Max((total_cases/population))*100 as percent_infected_population
From portfolio-project-334404.Covid_Dataset.Covid_Deaths
Group by Location, Population
order by percent_infected_population desc

#Table 4
SELECT location, population, date, MAX(total_cases) as highest_infection_count,  Max((total_cases/population))*100 as percent_infected_population
From portfolio-project-334404.Covid_Dataset.Covid_Deaths
Group by Location, Population, date
order by percent_infected_population desc
