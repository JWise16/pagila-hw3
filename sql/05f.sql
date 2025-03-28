/* 
 * Finding movies with similar categories still gives you too many options.
 *
 * Write a SQL query that lists all movies that share 2 categories with AMERICAN CIRCUS and 1 actor.
 *
 * HINT:
 * It's possible to complete this problem both with and without set operations,
 * but I find the version using set operations much more intuitive.
 */

-- Movies sharing at least 2 categories with 'AMERICAN CIRCUS'
WITH shared_categories AS (
    SELECT f2.film_id, f2.title
    FROM film_category fc1
    JOIN film_category fc2 ON fc1.category_id = fc2.category_id
    JOIN film f1 ON fc1.film_id = f1.film_id
    JOIN film f2 ON fc2.film_id = f2.film_id
    WHERE f1.title = 'AMERICAN CIRCUS'
    GROUP BY f2.film_id, f2.title
    HAVING COUNT(DISTINCT fc2.category_id) >= 2
),

-- Movies sharing at least 1 actor with 'AMERICAN CIRCUS'
shared_actors AS (
    SELECT DISTINCT f2.film_id, f2.title
    FROM film_actor fa1
    JOIN film_actor fa2 ON fa1.actor_id = fa2.actor_id
    JOIN film f1 ON f1.film_id = fa1.film_id
    JOIN film f2 ON f2.film_id = fa2.film_id
    WHERE f1.title = 'AMERICAN CIRCUS'
)

-- Final result: Movies meeting both criteria
SELECT sc.title
FROM shared_categories sc
JOIN shared_actors sa ON sc.film_id = sa.film_id
ORDER BY sc.title;

