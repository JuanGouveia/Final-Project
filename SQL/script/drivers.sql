-- Most wins by team according to drivers

SELECT constructors.name AS 'Team', constructors.nationality AS 'Team Nationality', SUM(results.position) AS 'Wins'
FROM results
JOIN constructors
ON results.constructorId = constructors.constructorId
WHERE results.position = 1

GROUP BY constructors.name, constructors.nationality
ORDER BY SUM(results.position) DESC
;

-- Race status by driver

SELECT CONCAT(drivers.forename, ' ', drivers.surname) AS 'Driver Name', drivers.nationality AS 'Nationality',
       round(round(sum(CASE WHEN statusId = 1 THEN 1 ELSE 0 END), 2) / round(count(raceId), 2), 2) AS 'Finished',
       round(round(sum(CASE WHEN statusId = 2 THEN 1 ELSE 0 END), 2) / round(count(raceId), 2), 2) AS 'Disqualified',
       round(round(sum(CASE WHEN statusId = 4 THEN 1 ELSE 0 END), 2) / round(count(raceId), 2), 2) AS 'Collison',
       COUNT(raceId) AS 'Total Races' 
FROM results 
JOIN drivers 
ON results.driverId = drivers.driverId

GROUP BY results.driverId, CONCAT(drivers.forename, ' ', drivers.surname), drivers.nationality
HAVING COUNT(raceId) >= 100
ORDER BY Finished DESC
;