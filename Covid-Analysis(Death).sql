CREATE TABLE CovidDeaths (
	iso_code   character varying,
    continent character varying,
    location character varying,
    date character varying,
    population character varying,
    total_cases bigint,
    new_cases integer,
    total_deaths integer,
    new_deaths integer,
    total_death_per_million double precision,
    new_death_per_million double precision,
    reproduction_rate double precision,
    icu_patients integer,
    hosp_patients integer,
    weekly_icu_admissions integer,
    weekly_hosp_admissions integer
);
ALTER TABLE "coviddeaths" RENAME TO "Covid-Deaths";
ALTER TABLE "CovidVaccination" RENAME TO "Covid-Vaccination";

SELECT * FROM "Covid-Deaths";



CREATE TABLE "Covid-Vaccination" (
    iso_code character varying,
    continent character varying,
    location character varying,
    date character varying,
    total_tests bigint,
    new_tests bigint,
    positive_rate double precision,
    tests_per_case double precision,
    tests_units character varying,
    total_vaccinations bigint,
    people_vaccinated bigint,
    people_fully_vaccinated bigint,
    total_boosters bigint,
    new_vaccinations bigint,
    stringency_index double precision,
    population_density double precision,
    median_age double precision,
    aged_65_older double precision,
    aged_70_older double precision,
    gdp_per_capita double precision,
    extreme_poverty double precision,
    cardiovasc_death_rate double precision,
    diabetes_prevalence double precision,
    handwashing_facilities double precision,
    life_expectancy double precision,
    human_development_index double precision,
    excess_mortality_cumulative double precision,
    excess_mortality double precision
);

select * from "Covid-Vaccination";










1. Datewise likelihood of dying due to covid-totalcases vs totaldeath in india?
Solution:

select date,total_cases,total_deaths from "Covid-Deaths"
where location like '%India%'

2. Total % of Deaths Out of entire population in india?
Solution:

select (max(total_deaths)/avg(cast(population as integer)) * 100) from "Covid-Deaths"
where location like '%India'

--select total_deaths,population from "Covid-Deaths" where location like '%India'
(total deaths+population)(531564+1417173120)*100
the result 0.03750875545818989300


3. Total % of Deaths Out of entire population in india in separately?
Solution:
SELECT 
    total_deaths,
    population
FROM 
    "Covid-Deaths" 
WHERE 
    location LIKE '%India';

4. Country with Highest death as a % of population?
Solution:
SELECT 
    location, 
    (MAX(total_deaths) / AVG(CAST(population AS bigint)) * 100) AS percentage
FROM 
    "Covid-Deaths"
GROUP BY 
    location 
ORDER BY 
    percentage DESC;


5. Total percentage of Covid positive cases in india?
Solution:

SELECT 
    (max(total_cases) / avg(CAST(population AS bigint))) * 100 AS percentage_of_positive_cases_in_India
FROM 
    "Covid-Deaths"
WHERE 
    location LIKE '%India';




6.Total percentage of Covid positive cases in world?
Solution:
SELECT 
    location, (max(total_cases) / avg(CAST(population AS bigint))) * 100 AS percentage_of_positive_cases_in_India
FROM 
    "Covid-Deaths"
group by	
	location
order by
	percentage_of_positive_cases_in_India desc;




7. Can you please tell me continent wise of positive cases?
Solution:
SELECT 
    location,
    MAX(total_cases) AS total_case 
FROM 
    "Covid-Deaths" 
WHERE 
    continent IS NULL 
GROUP BY 
    location 
ORDER BY 
    MAX(total_cases) DESC;



8. Can you please give the output of  continent wise of death?
Solution:

SELECT 
    location,
    MAX(total_deaths) AS total_death
FROM 
    "Covid-Deaths" 
WHERE 
    continent IS NULL 
GROUP BY 
    location 
ORDER BY 
    MAX(total_deaths) DESC;

9. What are the daily newcases vs hospitalizations vs icu_patients in india?
Solution:

select date,new_cases,hosp_patients,icu_patients 
from "Covid-Deaths"
where location='India';


10. How many country wise total vaccinated persons?
Solution:
SELECT 
    "Covid-Deaths".location AS country,
    MAX("Covid-Vaccination".people_fully_vaccinated) AS Fully_vaccinated 
FROM 
    "Covid-Deaths" 
JOIN 
    "Covid-Vaccination" 
ON 
    "Covid-Deaths".iso_code = "Covid-Vaccination".iso_code 
    AND "Covid-Deaths".date = "Covid-Vaccination".date 
WHERE 
    "Covid-Deaths".continent IS NOT NULL 
GROUP BY 
    country 
ORDER BY 
    Fully_vaccinated DESC;








