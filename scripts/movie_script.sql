-- ** Movie Database project. See the file movies_erd for table\column info. **

-- 1. Give the name, release year, and worldwide gross of the lowest grossing movie.
SELECT film_title, release_year, worldwide_gross
FROM specs
INNER JOIN revenue ON specs.movie_id = revenue.movie_id
ORDER BY worldwide_gross 
LIMIT 1;
-- Semi-Tough, 1977, $37,187,139

-- 2. What year has the highest average imdb rating?
SELECT release_year, AVG(imdb_rating) AS avg_imdb
FROM specs
INNER JOIN rating ON specs.movie_id = rating.movie_id
GROUP BY release_year
ORDER BY avg_imdb DESC;
-- 1991

-- 3. What is the highest grossing G-rated movie? Which company distributed it?
SELECT film_title, company_name, worldwide_gross 
FROM specs
INNER JOIN revenue ON specs.movie_id = revenue.movie_id
LEFT JOIN distributors ON distributor_id = domestic_distributor_id
WHERE mpaa_rating = 'G'
ORDER BY worldwide_gross DESC;
-- Toy Story 4, Walt Disney

-- 4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.
SELECT company_name, COUNT(film_title) AS count_movies
FROM distributors
LEFT JOIN specs ON distributor_id = domestic_distributor_id
GROUP BY company_name
ORDER BY count_movies DESC;

-- 5. Write a query that returns the five distributors with the highest average movie budget.
SELECT company_name
FROM distributors
INNER JOIN specs ON distributor_id = domestic_distributor_id
INNER JOIN revenue ON specs.movie_id = revenue.movie_id
GROUP BY company_name
ORDER BY AVG(film_budget) DESC
LIMIT 5;

-- 6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?
SELECT (film_title)
FROM specs
INNER JOIN distributors ON distributor_id = domestic_distributor_id
INNER JOIN rating ON specs.movie_id = rating.movie_id
WHERE headquarters NOT LIKE '%CA%'
ORDER BY imdb_rating DESC
LIMIT 1;
-- Dirty Dancing

-- 7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?
SELECT AVG(imdb_rating) AS under_two_hours,
	(
	SELECT AVG(imdb_rating) AS two_hours_plus
	FROM specs
	INNER JOIN rating ON specs.movie_id = rating.movie_id 
	WHERE length_in_min <= 120
	)
FROM specs
INNER JOIN rating ON specs.movie_id = rating.movie_id 
WHERE length_in_min > 120; 
-- Under Two Hours has a highter rating.
	

