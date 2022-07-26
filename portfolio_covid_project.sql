-- To view the entire data 
select * 
from portfolio_project..covid_deaths
order by 3,4

select * 
from portfolio_project..covid_vaccinations
order by 3,4

-- Focusing on the data we are going to use
-- location, date, population, total_deaths,total_cases, new_cases

select location, date, population, total_deaths,total_cases, new_cases
from portfolio_project..covid_deaths 
order by 1,2

-- Total Cases vs Total Deaths as per country

select location, date, population, total_deaths,total_cases,(total_deaths/total_cases)*100 as death_percentage
from portfolio_project..covid_deaths
where location like '%India%'
order by 1,2

--looking at the total cases vs population
--to determine infection percentage

select location, date, population, total_cases,(total_cases/population)*100 as infection_percentage
from portfolio_project..covid_deaths
--where location like '%India%'
order by 1,2

-- To determine the countries with the maximum infection rate

select distinct location, population,max(total_cases) as max_cases,max((total_cases/population))*100 as latest_infection_rate
from portfolio_project..covid_deaths
--where location like '%India%'
group by location,population
order by latest_infection_rate desc


--To determine countries with Highest death count per country

select location,population, max(cast(total_deaths as bigint)) as totaldeaths from portfolio_project..covid_deaths 
where continent is null 
--AND location like '%india%'
--where continent is null
group by location , population
order by 1,2

--To determine countries with Highest death count per continent

select continent, max(cast(total_deaths as bigint)) as totaldeaths from portfolio_project..covid_deaths 
where continent is not null 
--AND location like '%india%'
--where continent is null
group by continent 
order by totaldeaths desc	

-- Global Numbers

	select date,sum(cast(total_deaths as int)) as total_deaths_ww, sum(total_cases) as total_cases_ww, 
	(sum(cast(total_deaths as int))/sum(total_cases))*100 as death_percent_ww
	from portfolio_project..covid_deaths
	where continent is not null
	group by date
	order by 1,2


-- Vaccincations Per day

select dea.continent, dea.location,dea.date , dea.population, vac.new_vaccinations , 
sum(convert(int, vac.new_vaccinations )) over (partition by dea.location order by dea.loacation,dea.date ) as rolling_vaccinations
	from portfolio_project..covid_vaccinations vac
	join portfolio_project..covid_deaths dea
			on dea.location = vac.location and
			dea.date= vac.date
where dea.continent is not null
order by dea.location

-- using CTE

with popvsvac(continent,location,date,population,new_vaccinations,rolling_vaccinations)
as
(select dea.continent, dea.location,dea.date , dea.population, vac.new_vaccinations , 
sum(cast(vac.new_vaccinations as bigint)) over (partition by dea.location order by dea.date ) as rolling_vaccinations
	from portfolio_project..covid_vaccinations vac
	join portfolio_project..covid_deaths dea
			on dea.location = vac.location and
			dea.date= vac.date
where dea.continent is not null
--order by dea.location
)

select *, (rolling_vaccinations/population)*100 as vaccination_percentage from popvsvac order by location,date


select dea.location,dea.date, dea.population, 
(total_vaccinations - cast(new_vaccinations as bigint))/dea.population *100 as pop_vs_vac

from portfolio_project..covid_vaccinations vac
join portfolio_project..covid_deaths dea
			on dea.location = vac.location and
			dea.date= vac.date
order by dea.location,dea.date






