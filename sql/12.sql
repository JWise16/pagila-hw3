/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */

WITH RecentMovies AS (
    SELECT
        r.customer_id,
        f.film_id,
        r.rental_date,
        ROW_NUMBER() OVER (PARTITION BY r.customer_id ORDER BY r.rental_date DESC) as rn
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
),
Top5Movies AS (
    SELECT
        rm.customer_id,
        rm.film_id
    FROM RecentMovies rm
    WHERE rm.rn <= 5
),
ActionMovies AS (
    SELECT
        t5.customer_id,
        COUNT(*) AS action_count
    FROM Top5Movies t5
    JOIN film_category fc ON t5.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    WHERE c.name = 'Action'
    GROUP BY t5.customer_id
)
SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM ActionMovies am
JOIN customer c ON am.customer_id = c.customer_id
WHERE am.action_count >= 4;

