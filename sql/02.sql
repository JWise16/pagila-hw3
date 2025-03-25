/*
 * Compute the country with the most customers in it. 
 */

SELECT country.country
FROM customer
JOIN address ON customer.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
GROUP BY country.country
ORDER BY COUNT(customer.customer_id) DESC
LIMIT 1;

