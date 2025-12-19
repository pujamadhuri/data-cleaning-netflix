SELECT * 
FROM Netflix_titles.netflix_raw;

CREATE TABLE Netflix_titles.netflix_staging
LIKE Netflix_titles.netflix_raw;

INSERT INTO Netflix_titles.netflix_staging
SELECT *
FROM Netflix_titles.netflix_raw;

SELECT *
FROM Netflix_titles.netflix_staging;

SELECT show_id, COUNT(*)
FROM Netflix_titles.netflix_staging
GROUP BY show_id
HAVING COUNT(*) > 1;

SELECT *
FROM Netflix_titles.netflix_staging;

SELECT `type`,title,release_year,duration, COUNT(*) AS cnt
FROM Netflix_titles.netflix_staging
GROUP BY `type`,title,release_year,duration
HAVING COUNT(*) > 1;

SELECT *
FROM Netflix_titles.netflix_staging;

SELECT `type`, title, director, `cast`, country, date_added, release_year, rating, duration, listed_in,
ROW_NUMBER() OVER(
PARTITION BY show_id, `type`, title, director, `cast`, country, date_added, release_year, rating, duration, listed_in
) as row_num
FROM Netflix_titles.netflix_staging;

WITH duplicate_titles AS (
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY `type`, title, director, `cast`, country, date_added, release_year, rating, duration, listed_in
ORDER BY show_id
) AS row_num
FROM Netflix_titles.netflix_staging)
SELECT *
FROM duplicate_titles
WHERE row_num >1;

SELECT *
FROM Netflix_titles.netflix_staging
WHERE title = 'Love in a Puff';

SELECT *
FROM Netflix_titles.netflix_staging
WHERE title = 'Esperando la carroza';

SELECT *
FROM Netflix_titles.netflix_staging
WHERE title = 'Sin senos si hay paraiso';

SELECT *
FROM Netflix_titles.netflix_staging;

SELECT title, LOWER(TRIM(title)) AS normalized_title, 
COUNT(*) AS cnt
FROM Netflix_titles.netflix_staging
GROUP BY title, normalized_title
HAVING COUNT(*) > 1;

WITH duplicate_titles AS (
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY LOWER(TRIM(title))
ORDER BY show_id
) AS row_num
FROM Netflix_titles.netflix_staging)
SELECT *
FROM duplicate_titles
WHERE row_num >1;

WITH duplicate_titles AS (
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY LOWER(TRIM(title))
ORDER BY show_id
) AS row_num
FROM Netflix_titles.netflix_staging)
DELETE
FROM duplicate_titles
WHERE row_num >1;

ALTER TABLE Netflix_titles.netflix_staging
ADD row_num INT;

SELECT *
FROM Netflix_titles.netflix_staging;

CREATE TABLE `netflix_staging2` (
  `show_id` text,
  `type` text,
  `title` text,
  `director` text,
  `cast` text,
  `country` text,
  `date_added` text,
  `release_year` text,
  `rating` text,
  `duration` text,
  `listed_in` text,
  `description` text,
  `row_num` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM Netflix_titles.netflix_staging2;
INSERT INTO Netflix_titles.netflix_staging2 (show_id, type, title, director, `cast`, country, date_added, release_year, rating, duration, listed_in, description, row_num)
SELECT show_id, type, title, director, `cast`, country, date_added, release_year, rating, duration, listed_in, description, 
ROW_NUMBER() OVER(
PARTITION BY LOWER(TRIM(title))
ORDER BY show_id
) AS row_num
FROM Netflix_titles.netflix_staging;

SELECT * 
FROM Netflix_titles.netflix_staging2
WHERE row_num >= 2;
DELETE FROM Netflix_titles.netflix_staging2
WHERE row_num >= 2;


UPDATE Netflix_titles.netflix_staging2
SET type = TRIM(type),
title = TRIM(title),
director = TRIM(director),
`cast`= TRIM(`cast`),
country = TRIM(country),
rating = TRIM(rating),
listed_in = TRIM(listed_in);

SELECT *
FROM Netflix_titles.netflix_staging2;

SELECT DISTINCT type
FROM Netflix_titles.netflix_staging2
ORDER BY 1;

SELECT *
FROM Netflix_titles.netflix_staging2
WHERE type IS NULL
OR type = ''
ORDER BY 1;

SELECT DISTINCT title
FROM Netflix_titles.netflix_staging2
ORDER BY 1;

SELECT *
FROM Netflix_titles.netflix_staging2
WHERE title = '(T)ERROR';

UPDATE Netflix_titles.netflix_staging2
SET title = 'Unknown'
WHERE title = '(T)ERROR';


SELECT director
FROM Netflix_titles.netflix_staging2
WHERE director IS NULL
OR director = '';

UPDATE Netflix_titles.netflix_staging2
SET director = 'Unknown'
WHERE director IS NULL
OR director = '';

UPDATE Netflix_titles.netflix_staging2
SET date_added = NULL
WHERE date_added = '';


UPDATE Netflix_titles.netflix_staging2
SET date_added = STR_TO_DATE(date_added, '%M %e, %Y');

ALTER TABLE Netflix_titles.netflix_staging2
MODIFY COLUMN date_added DATE;

SELECT *
FROM Netflix_titles.netflix_staging2;

SELECT *
FROM Netflix_titles.netflix_staging2
WHERE rating IS NULL
OR rating = '';

UPDATE Netflix_titles.netflix_staging2
SET rating = 'Unknown'
WHERE rating IS NULL
OR rating = '';

SELECT *
FROM Netflix_titles.netflix_staging2
WHERE `cast` = '';

UPDATE Netflix_titles.netflix_staging2
SET `cast` = 'Unknown'
WHERE `cast` = '';

SELECT COUNT(*)
FROM Netflix_titles.netflix_staging2
WHERE description IS NULL OR description = '';

UPDATE Netflix_titles.netflix_staging2
SET description = NULL
WHERE TRIM(description) = ' ';

ALTER TABLE Netflix_titles.netflix_staging2
ADD duration_minutes INT NULL,
ADD duration_seasons INT NULL;

UPDATE Netflix_titles.netflix_staging2
SET duration_minutes = CAST(REPLACE(duration, ' min', '') AS UNSIGNED)
WHERE duration LIKE '%min%';

UPDATE Netflix_titles.netflix_staging2
SET duration_seasons = CAST(REPLACE(REPLACE(duration, ' Seasons', ''), ' Season', '') AS UNSIGNED)
WHERE duration LIKE '%Season%';

SELECT duration, duration_minutes, duration_seasons
FROM Netflix_titles.netflix_staging2
LIMIT 20;

ALTER TABLE Netflix_titles.netflix_staging2
DROP COLUMN duration;

ALTER TABLE Netflix_titles.netflix_staging2
DROP COLUMN row_num;

SELECT *
FROM Netflix_titles.netflix_staging2;

ALTER TABLE Netflix_titles.netflix_staging2
MODIFY release_year INT;

ALTER TABLE Netflix_titles.netflix_staging2
MODIFY type VARCHAR(50),
MODIFY title VARCHAR(250),
MODIFY director VARCHAR(250),
MODIFY country VARCHAR(250),
MODIFY rating VARCHAR(10),
MODIFY listed_in VARCHAR(300);

ALTER TABLE Netflix_titles.netflix_staging2
MODIFY `cast` TEXT,
MODIFY description TEXT;
netflix_staging2





























