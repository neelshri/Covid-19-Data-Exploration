--VIEWING ENTIRE DATA FOR BOTH THE TABLES

	select * from sql_portfolio..country_wise_covid_details 
	select * from sql_portfolio..country_wise_population_details
	select * from sql_portfolio..continent_wise_covid_data

-- JOINING THE TWO TABLES TO VIEW DATA TOGETHER

    select * from sql_portfolio..country_wise_covid_details cwcd
		join sql_portfolio..country_wise_population_details cwpd
			on cwcd.country_others= cwpd.country_others

-- INFECTION PERCENTAGE COUNTRY WISE
-- CHANGE COUNTRY OR ENTER PART OF COUNTRY NAME TO GET RESULT

	select  cwcd.country_others,cwcd.total_cases,cwpd.Population,
	(cwcd.total_cases/cwpd.Population)*100 as infection_percentage
		from sql_portfolio..country_wise_covid_details cwcd
			join sql_portfolio..country_wise_population_details cwpd
				on cwcd.country_others= cwpd.country_others
				--where cwcd.country_others like '%india%'
				order by 4 desc

-- DEATH PERCENTAGE COUNTRY WISE
-- CHANGE COUNTRY OR ENTER PART OF COUNTRY NAME TO GET RESULT

	select  cwcd.country_others,cwcd.total_deaths,cwpd.Population,
	(cwcd.total_deaths/cwpd.Population)*100 as death_percentage
		from sql_portfolio..country_wise_covid_details cwcd
			join sql_portfolio..country_wise_population_details cwpd
				on cwcd.country_others= cwpd.country_others
				--where cwcd.country_others like '%india%'
				order by 4 desc

-- RECOVERY RATE PERCENTAGE COUNTRY WISE
-- CHANGE COUNTRY OR ENTER PART OF COUNTRY NAME TO GET RESULT

	select  cwcd.country_others, cwcd.total_cases,cwcd.total_recovered,
	(cwcd.total_recovered/cwcd.total_cases)*100 as recovery_percentage
		from sql_portfolio..country_wise_covid_details cwcd
			--where cwcd.country_others like '%india%'
				order by 4 asc









