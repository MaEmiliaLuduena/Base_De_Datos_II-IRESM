USE sakila;

-- EJERCICIO 1 --
-- Películas por categoría, de manera que se vean el título (title), su año de lanzamiento (release_year), y el nombre de la categoría (category.name) a la que pertenece.
-- Sólo los 5 primeros títulos que comiencen por la letra "B".
-- Ordenados por título.
SELECT 
	title,
	release_year,
    category.name
FROM
	film
    INNER JOIN film_category USING(film_id)
    INNER JOIN category USING(category_id)
WHERE
	title LIKE "B%"
ORDER BY
	title
LIMIT
	5;
	
    
-- EJERCICIO 2 --
-- Dirección de los locales, de manera que figuren la ID de local, el país, la ciudad, el distrito, la dirección (primera y segunda línea). 
-- Todo ordenado por ID de local, en forma descendente.
SELECT 
	store_id AS "ID_Local",
    country AS "País",
    city AS "Ciudad",
    district AS "Distrito",
    address AS "Dirección",
    address2 AS "Dirección (Segunda línea)"
FROM
	store
    INNER JOIN address USING(address_id)
    INNER JOIN city USING(city_id)
    INNER JOIN country USING(country_id)
ORDER BY
	store_id DESC;
    
    
-- EJERCICIO 3 --
-- ID de empleado (staff_id), nombre (first_name) y apellido (last_name), fecha de alquiler (rental_date), monto (amount) y fecha de pago (payment_date).
-- Solo los montos mayores a 4.99.
-- Ordenados por monto en forma descendente.
SELECT
	staff.staff_id,
    first_name,
    last_name,
    rental_date,
    amount,
    payment_date
FROM	
	staff
	INNER JOIN rental USING(staff_id)
    INNER JOIN payment USING(rental_id)
WHERE
	amount > 4.99
ORDER BY
	amount DESC;


-- EJERCICIO 4 -- 
-- VIsualización completa de los alquileres:
-- De la película (film): ID (film_id), Título (title).
-- Del local (country, city, address, store): Dirección (primera línea solamente), distrito (district), ciudad (city), país (country).
-- Del empleado que lo realizó (staff): ID de empleado (staff_id), Nombre y Apellido (first_name y last_name respectivamente).
-- Del cliente que lo pidió (customer): ID de cliente (customer_id), Nombre y Apellido (first_name y last_name respectivamente).
-- Del préstamo (rental): Fecha (rental_date).
-- Del pago (payment): Monto (amount), Fecha de pago (payment_date).
-- 
-- Ordenados por ID del cliente en forma ascendente, y de la película en forma descendente.
-- De manera que solo figuren aquellos clientes cuyo apellido comience con la letra "L", pero cuyo nombre no comience con la letra "K".
SELECT
	film_id AS "ID Película",
	title AS Película,
	address AS Dirección,
	district AS Distrito,
	city AS Ciudad,
	country AS País,
	s.staff_id AS "ID Empleado",
	s.first_name AS "N. Empleado",
	s.last_name AS "A. Empleado",
	rental_date AS Fecha,
	c.customer_id AS "ID Cliente",
	c.first_name AS "N. Cliente",
	c.last_name AS "A. Cliente",
	amount AS "Monto",
	payment_date AS "Fecha Pago"
FROM
	country INNER JOIN
	city USING(country_id) INNER JOIN
	address USING(city_id) INNER JOIN
	store USING(address_id) INNER JOIN
	inventory USING(store_id) INNER JOIN
	film USING(film_id) INNER JOIN
	rental USING(inventory_id) INNER JOIN
	staff s USING(staff_id) INNER JOIN
	payment p USING(rental_id) INNER JOIN
	customer c ON c.customer_id = p.customer_id
WHERE
	c.last_name LIKE "L%"
	AND c.first_name NOT LIKE "K%"
ORDER BY
	c.customer_id,
	film_id DESC;


-- EJERCICIO 6 --
-- Seleccione nombre (first_name), apellido (last_name) e email tanto de los empleados (staff) como de los clientes (customer), uniendo ambas consultas. 
-- Ambas deben estar ordenadas por apellido.
(SELECT 
	first_name,
    last_name,
    email
FROM
	staff
ORDER BY
	last_name)
UNION 
(SELECT 
	first_name,
    last_name,
    email
FROM
	customer
ORDER BY
	last_name);
  
    

