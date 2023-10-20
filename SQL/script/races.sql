-- Top average speed in a Grand Prix race

SELECT Year, `Circuit Name`, `Country`, `Driver Name`, `Fastest Lap Speed (KMH)`, Lap
FROM (SELECT races.year AS 'Year', circuits.name AS 'Circuit Name', circuits.country AS 'Country',
      CONCAT(drivers.forename, ' ', drivers.surname) AS 'Driver Name', results.fastestLapSpeed AS 'Fastest Lap Speed (KMH)',
      results.fastestLap AS 'Lap', ROW_NUMBER() OVER (PARTITION BY races.year, circuits.name ORDER BY results.fastestLapSpeed DESC) AS row_num
      FROM circuits
      JOIN races
      ON circuits.circuitId = races.circuitId
      JOIN results
      ON races.raceId = results.raceId
      JOIN drivers
      ON results.driverId = drivers.driverId
      ) AS subquery
WHERE row_num = 1

ORDER BY Year DESC, `Circuit Name`
;

-- Formula 1 race winners

SELECT CONCAT(drivers.forename, ' ', drivers.surname) AS 'Driver Name', drivers.nationality AS 'Driver Nationality', SUM(results.position) AS 'Wins'
FROM results
JOIN drivers
ON results.driverId = drivers.driverId
WHERE results.position = 1

GROUP BY CONCAT(drivers.forename, ' ', drivers.surname), drivers.nationality
ORDER BY SUM(results.position) DESC
;