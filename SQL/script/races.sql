-- Top speed in a Grand Prix race

SELECT results.raceId AS 'Race ID', races.year AS 'Year', results.driverId AS 'Driver ID', results.fastestLapSpeed AS 'Fastest Lap Speed'
FROM results
JOIN races
ON results.raceId = races.raceId
WHERE results.fastestLapSpeed != ' '
;

-- Formula 1 race winners

SELECT races.year AS 'Season', drivers.driverId AS 'Driver ID', CONCAT(drivers.forename, ' ', drivers.surname) AS 'Name',
drivers.nationality AS 'Nationality', SUM(results.points) AS 'Points'
FROM results
JOIN drivers
ON results.driverId = drivers.driverId
JOIN races
ON results.raceId = races.raceId

GROUP BY races.year, drivers.driverId, CONCAT(drivers.forename, ' ', drivers.surname), drivers.nationality
HAVING SUM(results.points) = MAX(results.points)
ORDER BY races.year DESC

;