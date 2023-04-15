Select Location, date, total_cases, new_cases, total_deaths, population
From IPortfolioProject..CovidDeaths
order by 1,2



--Looking at total cases vs Total deaths

Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From IPortfolioProject..CovidDeaths
order by 1,2

--For United States
Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From IPortfolioProject..CovidDeaths
Where location like '%states%'
order by 1,2

--Looking at Total Covid Cases Vs Population for United States
Select Location, date, total_cases, population, (total_cases/population)*100 as InfectedPercentage
From IPortfolioProject..CovidDeaths
Where location like '%states%'
order by 1,2


--Looking at countries with Highest Infection Rate compared to population
Select Location, population, max(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as InfectedPercentage
From IPortfolioProject..CovidDeaths
group by Location, population
order by InfectedPercentage desc


--Looking at countries with Highest Death Rate compared to population
Select Location, population, max(cast(total_deaths as int)) as SumOfDeathInCountry, Max((total_deaths/population))*100 as DeathPercentage
From IPortfolioProject..CovidDeaths
where continent is not null
group by Location, population
order by SumOfDeathInCountry desc



--Looking at continents with Highest Death Rate
Select continent, max(cast(total_deaths as int)) as SumOfDeathInCountry
From IPortfolioProject..CovidDeaths
where continent is not null
group by continent
order by SumOfDeathInCountry desc



--Looking at countries with Highest Death Rate compared to population
Select location, max(cast(total_deaths as int)) as SumOfDeathInCountry
From IPortfolioProject..CovidDeaths
where continent is null
group by location
order by SumOfDeathInCountry desc

--Global Numbers
Select SUM(new_cases) as TotalCases, SUM(cast(new_deaths as int)) as TotalDeaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From IPortfolioProject..CovidDeaths
where continent is not null 
order by 1,2


--Population that has received at least one covid vaccine
Select CD.continent, CD.location, CD.date, CD.population, CV.new_vaccinations, SUM(CONVERT(int,CV.new_vaccinations)) OVER (Partition by CD.Location Order by CD.location, CD.Date) as RollingPeopleVaccinated
From IPortfolioProject..CovidDeaths CD
Join IPortfolioProject..CovidVaccinations cv
	On CD.location = CV.location
	and CD.date = CV.date
where CD.continent is not null 
order by 2,3


