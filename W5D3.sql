SELECT *
FROM staff;

SELECT *
FROM rental;

SELECT first_name, last_name, staff.staff_id, COUNT(staff.staff_id)
FROM staff
FULL JOIN rental
ON staff.staff_id = rental.staff_id
WHERE staff.staff_id IS NOT NULL
GROUP BY staff.staff_id;

SELECT *
FROM actor;

SELECT *
FROM film;

SELECT *
FROM film_actor;

--Query for film_id's from the film_actor table and which appear with those film_id's
SELECT actor.actor_id, first_name, last_name
FROM actor
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id;

--Query to see which actors are in what films
SELECT first_name, last_name, title, description, actor.actor_id, film.film_id
FROM actor
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id
INNER JOIN film
ON film_actor.film_id = film.film_id;

--LEFT JOIN on the actor table and film_actor table
SELECT actor.actor_id, first_name, last_name, film_id
FROM actor
LEFT JOIN film_actor
ON actor.actor_id = film_actor.actor_id
WHERE first_name IS NULL AND last_name IS NULL;

-- find all customers who live in tha country Angola
SELECT first_name, last_name, customer.address_id, country.country
FROM customer
INNER JOIN address
ON address.address_id = customer.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON country.country_id = city.country_id AND country = 'Angola';

--OR

SELECT first_name, last_name, country.country_id, country.country 
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country = 'Angola';

--SubQUeries is a query within a query
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
HAVING SUM (amount) > 175
ORDER BY SUM(amount) DESC;

SELECT store_id, first_name, last_name, customer_id
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM (amount) > 175
);

SELECT first_name, last_name, address.address
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id AND country.country = 'United States'
INNER JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id, first_name, last_name, address
HAVING SUM(amount) > 175;

SELECT AVG(amount)::NUMERIC(6,2)
FROM payment;

SELECT payment_id, amount
FROM payment
WHERE amount > 4.20;

--SUbquery to find amounts paid greater than the average amount paid
SELECT payment_id, amount
FROM payment
WHERE amount > (
	SELECT AVG(amount) FROM payment
);

-- subquery to find customer who live in dallas
SELECT first_name, last_name, address_id
FROM customer
WHERE address_id IN (
	SELECT address_id
	FROM address
	WHERE city_id IN (
		SELECT city_id
		FROM city
		WHERE city = 'Dallas'
	)
);

-- Query for all action movies
SELECT title, film_id
FROM film
WHERE film_id IN (
	SELECT film_id
	FROM film_category
	WHERE category_id IN (
		SELECT category_id
		FROM category
		WHERE name = 'Action'
	)
);


-- 1 List all customer who live in Texas (use JOINs)
SELECT first_name, last_name, customer.address_id, address.district
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';


--2 Get all payments above $6.99 with the Customer's Full Name
SELECT first_name, last_name, customer.customer_id
FROM customer 
WHERE customer_id IN(
	SELECT payment.customer_id
	FROM payment
	WHERE amount > 6.99
);
SELECT first_name, last_name, customer.customer_id
FROM customer 
INNER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99;

--3 Show all customers names who have made paymenst over $175 (use subqueries)
SELECT *
FROM payment;

--4
SELECT first_name, last_name, customer.address_id, address.address_id
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON country.country_id = city.country_id
WHERE country = 'Napal';
--5
SELECT first_name, last_name, staff_id
FROM staff

--6
SELECT film.rating
FROM film


--7
SELECT first_name, last_name, customer.customer_id, payment.customer_id
FROM customer 
INNER JOIN payment

--8
SELECT *
FROM rental;

SELECT COUNT 
FROM payment
WHere amount = 0;



