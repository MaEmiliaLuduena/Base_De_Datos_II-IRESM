USE classicmodels;

-- EJERCICIO 1 --
-- 1. Cree el registro en la tabla productline para los submarinos, con la siguiente información:
SELECT * FROM productlines;
INSERT INTO productlines
	(productLine, 
    textDescription)
VALUES 
	("Submarinos", 
    "Un submarino es un navío o buque capaz de navegar sobre la superficie del agua o debajo del agua.");


-- EJERCICIO 2 --
-- 2. Cree el registro en la tabla products para los tres tipos de submarinos, con la siguiente información:
INSERT INTO products
	(productCode,
	productName,
	productLine,
	productScale,
	productVendor,
	productDescription,
	quantityInStock,
	buyPrice,
	MSRP)
VALUES
	("U14_0001",
	"Tipo 209",
	"Submarinos",
	"!:20",
	"Mim Aginación",
	"El tipo 209 es un cl...",
	"1200",
	"420.00",
	"600.00"),
	("U14_0002",
	"TR-1700",
	"Submarinos",
	"!:20",
	"Mim Aginación",
	"La TR-1700 es una...",
	"900",
	"550.00",
	"775.00"),
	("U14_0003",
	"Tipo 039A",
	"Submarinos",
	"!:20",
	"Mim Aginación",
	"The type 039A sub...",
	"400",
	"510.00",
	"620.00");
 
 
-- EJERCICIO 3 --
-- Cree el registro de una orden, con la siguiente información:
INSERT INTO orders
	(orderNumber,
    orderDate,
	requiredDate,
	status,
	comments,
	customerNumber)
VALUES
	("10500",
	"2015-12-20",
	"2016-01-04",
	"In Process",
	"El cliente lo quiere antes del día de Reyes sin falta.",
	"121");
  
  
-- EJERCICIO 4 --
-- Cree el detalle de la orden, con la siguiente información:
INSERT INTO orderdetails
	(orderNumber,
	productCode,
	quantityOrdered,
	priceEach,
	orderLineNumber)
VALUES	
	("10500",
	"U14_0002",
	20,
	"775.00",
	1),
	(10500,
	'U14_0003',
	11,
	"620",
	2);


-- EJERCICIO 5 --
-- Modifique la orden, de forma que se ordenen solo la mitad de los modelos de submarino TR-1700.
UPDATE orderdetails
SET quantityOrdered = 10
WHERE productCode = 'U14_0002';


-- EJERCICIO 6 --
--  6. En realidad, la Armada Argentina actualmente opera sólo dos clases de submarinos. 
-- Los Tipo 039A han sido ofrecidos al gobierno, pero aún no han sido comprados. Borre de la base de datos toda la información relacionada con ese modelo de submarino.
DELETE FROM 
	orderdetails
WHERE 
	productCode = 'U14_0003';
DELETE FROM 
	products
WHERE 
	productCode = 'U14_0003';








