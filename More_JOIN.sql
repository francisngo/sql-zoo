/*
Sample Data
-----------
                      movie
------------------------------------------------
id    title   yr    director    budget    gross

  actor
-----------
id    name

        casting
-----------------------
movieid   actorid   ord
*/

-- 1. List the films where the yr is 1962. Show id, title.
SELECT movie.id, movie.title
FROM movie
WHERE movie.yr = 1962;

-- 2. Get the year of 'Citizen Kane'.
SELECT movie.yr
FROM movie
WHERE movie.title = 'Citizen Kane';

-- 3. List all of the Star Trek movies, include the id, title, and yr (all of these movies include the words Star Trek in the title). Order results by year.
SELECT movie.id, movie.title, movie.yr
FROM movie
WHERE movie.title LIKE '%Star Trek%'
ORDER BY movie.yr;

-- 4. What id number does the actor 'Glenn Close' have?
SELECT actor.id
FROM actor
WHERE actor.name = 'Glenn Close';

-- 5. What is the id of the film 'Casablanca'?
SELECT movie.id
FROM movie
WHERE movie.title = 'Casablanca';

-- 6. Obtain the cast list for 'Casablanca'. Use movieid = 11768.
SELECT actor.name
FROM actor JOIN casting
ON actor.id = casting.actorid
WHERE casting.movieid = 11768;

-- 7. Obtain the cast list for the film 'Alien'.
SELECT actor.name
FROM actor JOIN casting
ON actor.id = casting.actorid
WHERE casting.movieid = (SELECT movie.id FROM movie WHERE movie.title = 'Alien');

-- 8. List the films in which 'Harrison Ford' has appeared.
SELECT movie.title
FROM movie JOIN casting
ON movie.id = casting.movieid
WHERE casting.actorid = (SELECT actor.id FROM actor WHERE actor.name = 'Harrison Ford');

-- 9. List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field dof casting gives the position of the actor. If ord=1 then this actor is in the starring role].
SELECT movie.title
FROM movie JOIN casting
ON movie.id = casting.movieid
WHERE casting.actorid = (SELECT actor.id FROM actor WHERE actor.name = 'Harrison Ford') AND casting.ord != 1;

-- 10. List the films together with the leading star for all 1962 films.
SELECT movie.title, actor.name
FROM movie JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE movie.yr = 1962 AND casting.ord = 1;

-- 11. Which were the busiest years for 'John Travola', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
SELECT movie.yr, COUNT(title) as movies
FROM movie JOIN casting on movie.id = casting.movieid
JOIN actor on actor.id = casting.actorid
WHERE actor.name = 'John Travolta'
GROUP BY yr
HAVING COUNT(title) =
(SELECT MAX(c) FROM
(SELECT yr, COUNT(title) AS c
FROM movie JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE actor.name = 'John Travolta'
GROUP BY yr) AS t);

-- 12. List the film title and the leading actor for all of the films 'Julie Andrews' played in.
SELECT movie.title, actor.name
FROM movie JOIN casting ON (movie.id = casting.movieid AND casting.ord = 1)
JOIN actor ON (actor.id = casting.actorid)
WHERE movie.id IN (SELECT casting.movieid FROM casting WHERE casting.actorid IN (SELECT actor.id FROM actor WHERE name = 'Julie Andrews'));

-- 13. Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.

-- 14. List the films released in the year 1978 ordered by the number of actors in the cast, then by title.

-- 15. List all the people who have worked with 'Art Garfunkel'.
