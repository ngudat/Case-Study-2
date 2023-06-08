CREATE TABLE IF NOT EXISTS Case_Study.Victim_Summary_2022 AS
	SELECT
		Incident_Date ,State, City_Or_County,
		sum(__Victims_Injured) as Injured,
		sum(__Victims_Killed) as Killed,
		(sum(__Victims_Injured)+sum(__Victims_Killed)) as Total
	FROM Case_Study.victims as vic
	group by Incident_Date, State, City_Or_County;

SELECT distinct State, Injured, Killed, Total
FROM Case_Study.Victim_Summary_2022 as vic_sum
GROUP BY State, Injured, Killed, Total;

SELECT *
FROM Case_Study.Victim_Summary_2022 as vic_sum
LEFT JOIN Case_Study.uscities as usc 
ON 
	(State = state_name);
