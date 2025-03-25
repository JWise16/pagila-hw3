/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */

WITH Bacall_1 AS (
    -- Find all actors who have appeared in the same film as 'RUSSELL BACALL'
    SELECT DISTINCT fa1.actor_id
    FROM film_actor fa1
    JOIN film_actor fa2 ON fa1.film_id = fa2.film_id
    JOIN actor b ON fa2.actor_id = b.actor_id
    WHERE b.first_name = 'RUSSELL' AND b.last_name = 'BACALL'
),

Bacall_2 AS (
    -- Find all actors who have appeared in a film with Bacall_1 actors
    SELECT DISTINCT fa1.actor_id
    FROM film_actor fa1
    JOIN film_actor fa2 ON fa1.film_id = fa2.film_id
    WHERE fa2.actor_id IN (SELECT actor_id FROM Bacall_1)
)

-- Final selection from Bacall_2, excluding actors with Bacall Number < 2
SELECT DISTINCT UPPER(a.first_name || ' ' || a.last_name) AS "Actor Name"
FROM Bacall_2 b2
JOIN actor a ON b2.actor_id = a.actor_id
WHERE a.actor_id NOT IN (SELECT actor_id FROM Bacall_1)
ORDER BY "Actor Name";

