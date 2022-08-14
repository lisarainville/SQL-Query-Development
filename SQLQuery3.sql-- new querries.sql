--total vaccines and administered boosters per continent and region
Begin Tran
select continent, location, MAX(cast(total_vaccinations as bigint)) AS TotalVaccinesPerContinent, MAX([total_boosters])
as TotalBoosters , people_fully_vaccinated
from dbo.[covidVaccinations$]
where continent is not null
group by continent,location,people_fully_vaccinated

RollBack
----------------still working on this one 
select DEA.date,DEA.continent,DEA.location, population, new_cases
from   dbo.[covid deaths]as DEA
join dbo.covidVaccinations$ as VAC
on VAC.continent = DEA.continent
and VAC.location = DEA.location
group by  DEA.continent, DEA.location,population,DEA.date,new_cases