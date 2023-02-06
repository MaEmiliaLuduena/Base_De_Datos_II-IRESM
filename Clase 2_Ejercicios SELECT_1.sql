USE classicmodels;

-- EJERCICIO 1 --
-- employeeNumber, lastName y firstName de la tabla employees.
SELECT
	employeeNumber,
    lastName,
    firstName
FROM
	employees;
    

-- EJERCICIO 2 --
-- customerNumber y checkNumber de la tabla payments.
SELECT
	customerNumber,
    checkNumber
FROM
	payments;
    

-- EJERCICIO 3 --
-- country, state, city, addressLine1 y addressLine2 de la tabla offices.
SELECT
	country,
    state,
    city,
    addressLine1,
    addressLine2
FROM
	offices;