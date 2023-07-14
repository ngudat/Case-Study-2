-- Active: 1685936542142@@127.0.0.1@3306@Case_Study
/* This table is to aggregate tne victims table and keep only the focused attributes */
CREATE TABLE IF NOT EXISTS Case_Study.Victim_Summary_2022 AS
	SELECT
			DISTINCT State, City_or_County ,
		sum(__Victims_Injured) as Injured,
		sum(__Victims_Killed) as Killed,
		sum(__Victims_Injured)+sum(__Victims_Killed) as Total
	FROM Case_Study.victims as vic
	group by State, City_or_County;

SELECT
		DISTINCT State, City_or_County ,
	sum(__Victims_Injured) as Injured,
	sum(__Victims_Killed) as Killed,
	sum(__Victims_Injured)+sum(__Victims_Killed) as Total
FROM Case_Study.victims as vic

group by State, `City_Or_County`;

/*An executable to exam the new table for errors*/
SELECT *
FROM Case_Study.Victim_Summary_2022
WHERE `State` = 'Texas';

/*An executable to the original table for comparison*/
SELECT *
FROM Case_Study.victims
WHERE State = 'Texas';

/*An executable to the uscities*/
SELECT *
FROM Case_Study.uscities;


/*This executable is aggregate by state and look at the count*/
SELECT State, Injured, Killed, Total
FROM Case_Study.Victim_Summary_2022 as vic_sum
GROUP BY State, Injured, Killed, Total;


/*This is to join the new victims table and the uscities table to examine population effects
- The problem with this is that there are multiple records of the same city and state which can cause repeats of the data.
- Let's aggregate the data more and have distinct state and city with the summation.
*/
CREATE TABLE IF NOT EXISTS Case_Study.violence_summary_2022 AS
	SELECT *
	FROM Case_Study.Victim_Summary_2022 as vic_sum
	LEFT JOIN Case_Study.uscities as usc 
	ON 
		(vic_sum.State = usc.state_name);

DROP TABLE uscities;

DROP TABLE violence_summary_2022;

SELECT *
FROM violence_summary_2022
WHERE `State` = 'Texas';

SELECT *
FROM violence_summary_2022
WHERE State = 'Texas' AND City_Or_County = 'Houston';
