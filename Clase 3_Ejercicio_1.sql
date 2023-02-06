USE classicmodels;

-- EJERCICIO 1 --
-- Escribir la consulta para visualizar apellido (lastName), nombre (firstName), descripción del puesto (jobTitle), código de oficina (officeCode), ciudad (city) y 
-- país (country), de todos los empleados y sus respectivas oficinas. Ordenar por país en forma descendente, ciudad y apellido. (Estas dos últimas en forma ascendente.)
SELECT 
    lastName,
    firstName,
    jobTitle,
    officeCode,
    city,
    country
FROM
    employees INNER JOIN 
    offices USING(officeCode)
ORDER BY
    country DESC,
    city,
    lastName;
    

-- EJERCICIO 2 --
-- Suponga que queremos visualizar el detalle de una factura. Sólo tenemos como dato el número de la orden: la 10103.
-- Queremos visualizar:
-- el número de detalle (orderLineNumber),
-- código de producto (productCode),
-- nombre de producto (productName),
-- cantidad ordenada (quantityOrdered),
-- y el precio unitario de cada ítem (priceEach).
-- Además queremos ordenarlo por número de orden y número de detalle, ambos en forma ascendente.
SELECT 
    orderLineNumber,
    productCode,
    productName,
    quantityOrdered,
    priceEach
FROM 										-- La información requerida anteriormente se encuentra en las tablas products, orderdetails y orders. 
    products 
    INNER JOIN orderdetails USING(productCode) -- Se unen creando una tabla intermedia gracias a la función del INNER JOIN.
    INNER JOIN orders USING(orderNumber) -- (No estaba segura de si agregar esta línea.) 
WHERE
    orderNumber = 10103 -- De esta manera obtengo sólo los detalles del número de orden dado.
ORDER BY
    orderNumber,
    orderLineNumber;
    
-- Ejercicio 2- c) --
-- Si podría reutilizar esta misma consulta en el caso de que programara una pantalla de un sistema para mostrar el detalle de una factura.
-- El dato que tendría que cambiar en la consulta para que funcione el sistema sería "WHERE orderNumber = 10103".
