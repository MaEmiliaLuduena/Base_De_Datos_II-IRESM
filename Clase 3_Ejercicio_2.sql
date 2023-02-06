USE classicmodels;

-- EJERCICIO 1 --
-- Seleccione sin duplicados todos los códigos de producto (productCode) que alguna vez se hayan ordenado (orderdetails), ordenados en forma descendente.
SELECT DISTINCT
	productCode
FROM 
    products
    INNER JOIN orderdetails USING(productCode)
ORDER BY
	productCode DESC;
    
-- EJERCICIO 2 --
-- Seleccione las combinaciones únicas de país (country) y ciudad (city) donde haya clientes, en orden ascendente por país y descendente por ciudad, pero solo los 
-- resultados del quinto al décimo.
SELECT DISTINCT 
	country,
    city
FROM
	customers
ORDER BY
	country,
    city DESC
LIMIT
	4,6;
    


