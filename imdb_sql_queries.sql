-- ° Bacon

-- (Background.)

-- List all the actors that have worked with Kevin Bacon 
-- in Drama movies (include the movie name). Please exclude 
-- Mr. Bacon himself from the results.   THAT's DOPE!

SELECT m.name "Film", a.first_name "First", a.last_name "Last"
FROM actors a 
 INNER JOIN roles r
  ON a.id = r.actor_id
 INNER JOIN movies_genres mg 
  ON r.movie_id = mg.movie_id
 INNER JOIN movies m
  ON mg.movie_id = m.id
WHERE mg.genre = 'Drama' AND mg.movie_id IN
	(SELECT r.movie_id
	 FROM roles r
	  INNER JOIN actors a
	   ON r.actor_id = a.id
	 WHERE a.first_name = 'Kevin' AND a.last_name = 'Bacon')
	AND a.id <>
	(SELECT a.id
	 FROM actors a
	 WHERE a.first_name = 'Kevin' AND a.last_name = 'Bacon')
ORDER BY "Film", "Last"
LIMIT 100;


-- Immortal Actors

-- Which actors have acted in a film before 1900 and also in a film after 
-- 2000? NOTE: we are not asking you for all the pre-1900 and post-2000 
-- actors — we are asking for each actor who worked in both eras!

SELECT a.first_name "First", a.last_name "Last"
FROM actors a 
 INNER JOIN roles r
  ON a.id = r.actor_id
 INNER JOIN movies m
  ON r.movie_id = m.id
WHERE a.id IN
	(SELECT a.id
	 FROM actors a
	  INNER JOIN roles r
 	   ON a.id = r.actor_id
 	  INNER JOIN movies m
 	   ON r.movie_id = m.id
	 WHERE m.year<1900
	INTERSECT
	SELECT a.id
	 FROM actors a
	  INNER JOIN roles r
 	   ON a.id = r.actor_id
 	  INNER JOIN movies m
 	   ON r.movie_id = u.id
	 WHERE m.year>2000)
GROUP BY a.id;


-- Find actors that played five or more roles in the same movie after 
-- the year 1990. Notice that ROLES may have occasional duplicates, 
-- but we are not interested in these: we want actors that had five 
-- or more distinct (cough cough) roles in the same movie. Write a query 
-- that returns the actors' names, the movie name, and the number of 
-- distinct roles that they played in that movie (which will be ≥ 5).

--seems to count # total movies

SELECT a.first_name "First", a.last_name "Last", m.name "Film", Count(a.id) "Num Roles"
FROM actors a
INNER JOIN roles r
ON a.id = r.actor_id
INNER JOIN movies m
ON r.movie_id = m.id
WHERE m.id IN
	(SELECT m.id
	FROM movies m
	WHERE m.year > 1990)
GROUP BY m.id
HAVING "Num Roles">24
ORDER BY "Num Roles" DESC
LIMIT 25;













