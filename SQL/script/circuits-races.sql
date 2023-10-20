-- Number of Grand Prix per year

SELECT races.year AS 'Year', COUNT(races.round) AS 'Number of Grand Prix'
FROM races

GROUP BY year
ORDER BY year
;

-- Circuits that have inaugurated the championship

SELECT races.name AS 'Grand Prix Name', circuits.name AS 'Circuit Name', circuits.location AS 'City', circuits.country AS 'Country', 
count(*) as 'Opening Races Hosted'
FROM circuits
JOIN races
ON circuits.circuitId = races.circuitId
WHERE races.round = 1

GROUP BY races.name, circuits.name, circuits.location, circuits.country, races.name
ORDER BY count(*) DESC
;

-- 2023 Calendar

SELECT circuits.name AS 'Circuit Name', circuits.country AS 'Country'
FROM circuits
JOIN races
ON circuits.circuitId = races.circuitId
WHERE races.year = 2023

GROUP BY circuits.name, circuits.country
ORDER BY COUNT(races.round) DESC
;

-- Most popular Grand Prix

SELECT circuits.name AS 'Circuit Name', circuits.country AS 'Country', COUNT(races.round) as 'Races'
FROM circuits
JOIN races
ON circuits.circuitId = races.circuitId

GROUP BY circuits.name, circuits.country
ORDER BY Races desc
;

-- Most safety cars appearances per circuits

SELECT circuits.name AS 'Circuit Name', circuits.location AS 'City', circuits.country AS 'Country', COUNT(safety_car.safetyId) AS 'Safety Car Appearances'
FROM circuits
JOIN races
ON circuits.circuitId = races.circuitId
JOIN safety_car
ON races.raceId = safety_car.raceId

GROUP BY circuits.name, circuits.location, circuits.country
ORDER BY COUNT(safety_car.safetyId) DESC
;

-- Fastest race laps per year, circuit, country and driver

SELECT races.year AS 'Year', circuits.name AS 'Circuit Name', circuits.country AS 'Country', CONCAT(drivers.forename, ' ', drivers.surname) AS 'Driver Name',
lap_times.time AS 'Fastest Lap Time', MIN(lap_times.milliseconds) AS 'Fastest Lap Time (milliseconds)', lap_times.lap AS 'Lap'
FROM lap_times
JOIN races
ON lap_times.raceId = races.raceId
JOIN circuits
ON races.circuitId = circuits.circuitId
JOIN drivers
ON lap_times.driverId = drivers.driverId

WHERE (lap_times.raceId, lap_times.milliseconds)
IN (SELECT raceId, MIN(milliseconds) AS min_time
    FROM lap_times
    GROUP BY raceId
    )

GROUP BY races.year, circuits.name, circuits.country, CONCAT(drivers.forename, ' ', drivers.surname), lap_times.time, lap_times.lap
ORDER BY races.year DESC, circuits.name
;

