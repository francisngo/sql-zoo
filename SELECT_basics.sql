/*
Sample Data
-----------
                   WORLD
name        continent area    population gdp
---------------------------------------
Afghanistan Asia      652230  25500100   20343000000
Albania     Europe    28748   2831741    12960000000
Algeria     Africa    2381741 37100000   188681000000
Andorra     Europe    468     78115      3712000000
Angola      Africa    1246700 20609294   100990000000
...
*/

-- 1. Show the population of 'Germany'.
SELECT population
FROM world
WHERE name = 'Germany';

-- 2. Checking a list the word IN allows us to check if any item is in a list. Show the name and the population for 'Sweden', 'Norway' and 'Denmark'.
SELECT name, population
FROM world
WHERE name in ('Sweden', 'Norway', 'Denmark');

-- 3. Which countries are not too small and not too big? BETWEEN allows range checking (range specified is inclusive of boundary values). The example below shows countries with an area of 250,000-300,000 sq km. Modify it to show the country and the area for countries with an area between 200,000 and 250,000.
SELECT name, area
FROM world
WHERE area BETWEEN 200000 AND 250000;
