-- Number of Grand Prix per year

SELECT * FROM races
;

SELECT year AS 'Year', COUNT(round) AS 'Number of Grand Prix'
FROM races

GROUP BY year
ORDER BY year
;

-- Circuits that have inaugurated the championship

SELECT circuits.name AS 'Circuit Name', circuits.location AS 'City', circuits.country AS 'Country', count(*) as 'Opening Races Hosted', races.name AS 'Grand Prix Name'
FROM circuits
INNER JOIN races
ON circuits.circuitId = races.circuitId
WHERE races.round = 1

GROUP BY circuits.name, circuits.location, circuits.country, races.name
ORDER BY count(*) DESC
;

-- 2023 Races

SELECT circuits.name AS 'Circuit Name', circuits.country AS 'Country'
FROM circuits
INNER JOIN races
ON circuits.circuitId = races.circuitId
WHERE races.year = 2023

GROUP BY circuits.name, circuits.country
ORDER BY COUNT(races.round) DESC
;

-- Most popular Grand Prix

SELECT circuits.name AS 'Name', circuits.country AS 'Country', COUNT(races.round) as 'Races'
FROM circuits
INNER JOIN races
ON circuits.circuitId = races.circuitId

GROUP BY circuits.name, circuits.country
ORDER BY Races desc
;

-- Record of laps per circuit and year

SELECT lap_times.raceId AS 'Race ID', lap_times.driverId AS 'Driver ID', lap_times.time AS 'Time', MIN(lap_times.milliseconds) AS 'Elapsed', races.year AS 'Year', circuits.name AS 'Name', circuits.country AS 'Country'
FROM lap_times
JOIN races
ON lap_times.raceId = races.raceId
JOIN circuits
ON races.circuitId = circuits.circuitId

GROUP BY lap_times.raceId, lap_times.driverId, lap_times.time, races.year, circuits.name, circuits.country
ORDER BY elapsed DESC
;