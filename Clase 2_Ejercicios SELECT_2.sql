USE classicmodels;
 
-- EJERCICIO 1 --
-- employeeNumber, lastName y firstName de la tabla employees, donde el employeeNumber sea mayor a 1060, ordenado por apellido (lastName).
SELECT	
	employeeNumber,
    lastName, 
    firstName
FROM
	employees
WHERE 
	employeeNumber > 1060
ORDER BY
	lastName;
    
    
-- EJERCICIO 2 --
-- customerNumber y checkNumber de la tabla payments, donde customerNumber esté entre 110 y 120 inclusive.
SELECT
	customerNumber,
    checkNumber
FROM
	payments
WHERE
	customerNumber BETWEEN 110 AND 120;
    

-- EJERCICIO 3 --
-- country, state, city, addressLine1 y addressLine2 de la tabla offices, ordenado por país (country) en forma descendente y estado (state) en forma ascendente, 
-- donde la dirección no tenga segunda línea (addressLine2) y además la ciudad contenga la letra “o”.
SELECT 
	country
    state,
    city, 
    addressLine1,
    addressLine2
FROM
	offices
WHERE
	addressLine2 IS NULL AND 
    city LIKE "%o%"
ORDER BY
	country DESC,
    state;
