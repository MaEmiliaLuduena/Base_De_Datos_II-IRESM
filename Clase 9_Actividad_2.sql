USE classicmodels;
SELECT @@sql_mode;
SET GLOBAL sql_mode = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- EJERCICIO 1 -- 
-- Cantidad total de clientes registrados:
SELECT 
	COUNT(customerNumber) AS "CANTIDAD CLIENTES"
FROM 
	customers;
    
-- EJERCICIO 2 --
-- Monto promedio de los pagos de cada cliente, redondeado a 2 cifras decimales:
SELECT 
    customerNumber AS "Nro de Cliente",
    ROUND(AVG(amount), 2) AS 'Promedio'
FROM
	customers INNER JOIN payments USING(customerNumber)
GROUP BY
	customerNumber;
    
-- EJERCICIO 3 --
-- Cantidad promedio de pagos realizados por cliente (utilizando una subconsulta).
SELECT
	AVG(Conteo) AS "Cantidad promedio"
FROM
	(SELECT
		COUNT(customerNumber) AS Conteo
	FROM
		payments
	GROUP BY
		customerNumber) q; -- SE LE DEBE PONER UN ALIAS A LA SUBCONSULTA (LA USEMOS O NO)
    
    
-- EJERCICIO 4 -- 
-- Top 5 clientes a los que más órdenes se hayan despachado efectivamente (orders.status = "Shipped"). Deberán:
-- °Tener los datos de cliente mostrados (customerNumber, customerName, conteo de la cant. de órdenes que cumplan los requisitos)
-- °Estar ordenados por cantidad de órdenes despachadas, en forma descendente.
-- °Estar limitados a los 5 primeros puestos.
SELECT
	customerNumber AS "Nro Cliente",
    customerName AS "Cliente",
    COUNT(orderNumber) AS "Cant órdenes despachadas"
FROM
	customers INNER JOIN 
    orders USING(customerNumber)
WHERE
	status = "Shipped"
GROUP BY
	customerNumber
ORDER BY
	COUNT(orderNumber) DESC
LIMIT
	5;

	
        

        
        
        
        
        
        
        