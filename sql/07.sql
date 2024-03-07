/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */

WITH
bacall1 AS (
    SELECT a1.actor_id
    FROM actor a1
    JOIN film_actor fa1 on a1.actor_id = fa1.actor_id 
    JOIN film_actor fa2 on fa1.film_id = fa2.film_id
    JOIN actor a2 on fa2.actor_id = a2.actor_id
    WHERE a2.first_name || ' ' || a2.last_name = 'RUSSELL BACALL'
),
bacall2 AS (
    SELECT a1.actor_id
    FROM actor a1
    JOIN film_actor fa1 on a1.actor_id = fa1.actor_id
    JOIN film_actor fa2 on fa1.film_id = fa2.film_id
    JOIN bacall1 on fa2.actor_id = bacall1.actor_id
)
SELECT distinct(first_name || ' ' || last_name) as "Actor Name"
FROM actor a1
JOIN bacall2 on a1.actor_id = bacall2.actor_id
WHERE first_name || ' ' || last_name != 'RUSSELL BACALL'
AND a1.actor_ID NOT IN (
    SELECT actor_id 
    FROM bacall1
)
ORDER BY "Actor Name";
