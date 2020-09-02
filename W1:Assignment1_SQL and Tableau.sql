SELECT * FROM planes;
SELECT * FROM flights;

#1. How many airplanes have listed speeds?
-- 23 airplanes have listed speeds.

SELECT COUNT(*) 
FROM planes
WHERE speed IS NOT null;

#What is the minimum listed speed?
-- The minimum listed speed is 90.

SELECT MIN(speed) AS 'minimum speed'
FROM planes;

#What is the maximum listed speed?
-- The maximum listed speed is 432.

SELECT MAX(speed) AS 'maximum speed'
FROM planes;

#2. What is the total distance flown by all of the planes in January 2013?
-- The total distance flown by all planes in Jan 2013 is 27188805.

SELECT SUM(distance)
FROM flights
WHERE year=2013
and month=1;

#What is the total distance flown by all of the planes in January 2013 
-- where the tailnum is missing?
-- The total distance flown by all planes in Jan  2013 without the tailnum
-- is 81763.

SELECT SUM(distance)
FROM flights
WHERE year=2013
and month=1
and (tailnum IS NULL OR tailnum='');

#What is the total distance flown for all planes on July 5, 2013 grouped 
-- by aircraft manufacturer?  Write this statement first using an INNER JOIN,
-- then using a LEFT OUTER JOIN. How do your results compare?
-- The left outer join includes  null tailnum results. 
-- The inner join only displays results with overlapping tailnums.

SELECT planes.manufacturer, SUM(flights.distance)
FROM flights
INNER JOIN planes
ON planes.tailnum = flights.tailnum
WHERE flights.year = '2013' AND flights.month ='7' AND flights.day ='5'
GROUP by planes.manufacturer
ORDER BY SUM(distance) DESC;

SELECT planes.manufacturer, SUM(flights.distance)
FROM flights
LEFT JOIN planes
ON planes.tailnum = flights.tailnum
WHERE flights.year = '2013' AND flights.month ='7' AND flights.day ='5'
GROUP by planes.manufacturer
ORDER BY SUM(distance) DESC;

#4.What airport had the top 3 longest air_time in 2013 grouped by aircraft 
-- manufacturer in 2013? JFK

SELECT air_time AS 'Longest Air_time', flights.origin
FROM flights 
INNER JOIN planes
ON flights.tailnum = planes.tailnum
WHERE planes.year = 2013
ORDER BY air_time desc limit 3;



