create database netflix;
use netflix;

-- 1. What were the top 10 movies according to IMDB score?

SELECT 
    title, type, imdb_score
FROM
    titles
WHERE
    imdb_score >= 8.0 AND type = 'MOVIE'
ORDER BY imdb_score DESC
LIMIT 10;

-- 2. What were the top 10 shows according to IMDB score? 

SELECT 
    title, type, imdb_score
FROM
    titles
WHERE
    imdb_score >= 8.0 AND type = 'SHOW'
ORDER BY imdb_score DESC
LIMIT 10;

-- 3. What were the bottom 10 movies according to IMDB score? 

SELECT 
    title, type, imdb_score
FROM
    titles
WHERE
    type = 'MOVIE'
ORDER BY imdb_score ASC
LIMIT 10;

-- 4. What were the bottom 10 shows according to IMDB score? 

SELECT title, 
type, 
imdb_score
FROM titles
WHERE type = 'SHOW'
ORDER BY imdb_score ASC
LIMIT 10;

-- 5. What were the average IMDB and TMDB scores for shows and movies? 

SELECT DISTINCT
    type,
    ROUND(AVG(imdb_score), 2) AS avg_imdb_score,
    ROUND(AVG(tmdb_score), 2) AS avg_tmdb_score
FROM
    titles
GROUP BY type;

-- 6. Count of movies and shows in each decade

SELECT 
    CONCAT(FLOOR(release_year / 10) * 10, 's') AS decade,
    COUNT(*) AS movies_shows_count
FROM
    titles
WHERE
    release_year >= 1940
GROUP BY CONCAT(FLOOR(release_year / 10) * 10, 's')
ORDER BY decade;


-- 7.Calculating the average runtime of movies and TV shows separately

SELECT 
ROUND(AVG(runtime),2) AS avg_runtime_min
FROM titles
WHERE type = 'Movie'
UNION ALL
SELECT 
ROUND(AVG(runtime),2) AS avg_runtime_min
FROM shows_movies.titles
WHERE type = 'Show';

-- 8. Which shows on Netflix have the most seasons?

SELECT 
    title, SUM(seasons) AS total_seasons
FROM
    titles
WHERE
    type = 'Show'
GROUP BY title
ORDER BY total_seasons DESC
LIMIT 10;

-- 9. What are the top 3 genres?

SELECT 
    genres, COUNT(*) AS total_count
FROM
    titles
WHERE
    type = 'MOVIE' OR type = 'SHOW'
GROUP BY genres
ORDER BY total_count DESC
LIMIT 3;

-- 10. Production countries with the most movies and shows?

SELECT 
    production, COUNT(*) AS total
FROM
    titles
GROUP BY production
ORDER BY total DESC
LIMIT 3;