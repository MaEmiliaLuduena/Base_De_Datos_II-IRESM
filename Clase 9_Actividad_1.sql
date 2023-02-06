USE classicmodels;
SELECT @@sql_mode;
SET GLOBAL sql_mode = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


-- EJERCICIO 1 --
-- Cantidad de productos por cada categoría (cada productline):
SELECT
	productLine AS "Categoría",
	COUNT(*) AS "Cantidad" -- Me trae la cantidad de productos
FROM
	productlines 
    INNER JOIN products USING(productLine)
GROUP BY
	productLine;

-- EJERCICIO 2 --
-- Facturación por cada orden en el año 2005, ordenadas por número de orden en forma descendente:
SELECT
	orderNumber AS "Orden",
    SUM(priceEach*quantityOrdered) AS "Monto" -- Multiplico la cantidad de órdenes por cada precio, y luego sumo los valores de la expresión
FROM 
	orderdetails
    INNER JOIN orders USING(orderNumber)
WHERE 
	YEAR(orderDate) = 2005
GROUP BY 
	orderNumber
ORDER BY
	orderNumber DESC;


-- EJERCICIO 3 --
-- Clientes registrados que nunca hayan realizado órdenes, ordenado por customerNumber. (Utilizando una subconsulta.)
SELECT
	customerNumber AS "N° de Cliente",
    customerName AS "Nombre de Cliente"
FROM 
	customers
WHERE
-- En la Subconsulta selecciono el n° de clientes que hayan realizado órdenes desde la tabla 'orders', y luego desde la Consulta selecciono las que NO se encuentran allí
	customerNumber NOT IN 
		(SELECT
			customerNumber
        FROM
			orders)
GROUP BY
	customerNumber
ORDER BY
	customerNumber;
			
    






