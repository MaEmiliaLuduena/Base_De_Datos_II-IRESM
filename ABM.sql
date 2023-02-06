USE classicmodels;

-- INSERTS --

-- Inserción en la tabla ProductLines. (Básicamente, dar de alta la categoría.)
INSERT INTO productlines
	(productLine,
	textDescription)
VALUES
	("Autogiros",
	"¿Sabían que existen aviones de ala giratoria? Sí. Se llaman autogiros o girocópteros. Y no son helicopteros.");

-- Inserción en la tabla ProductLines:
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
	("A12_0001",
	"ELA 07",
	"Autogiros",
	"1:12",
	"Mim Aginación",
	"The ELA 07 is a series of Spanish autogyros, designed and produced by ELA Aviación of Córdoba, Andalusia.",
	200,
	60.50,
	121);

-- Tres más:
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
	("A12_0002",
	"ELA 09 Junior",
	"Autogiros",
	"1:12",
	"Mim Aginación",
	"The ELA 09 Junior is a Spanish autogyro designed and produced by ELA Aviación of Córdoba, Andalusia,",
	310,
	80.7,
	150.0000),
    ("A12_0003",
	"AutoGyro MT-03",
	"Autogiros",
	"1:12",
	"Mim Aginación",
	"The AutoGyro MT-03 is a German autogyro, designed and produced by AutoGyro GmbH of Hildesheim.",
	50,
	50.10,
	100.50),
	("A12_0004",
	"Sport Copter 2",
	"Autogiros",
	"1:10",
	"Mim Aginación",
	"The Sport Copter 2 is an American two-seat autogyro designed and built by Sport Copter of Scappoose, Oregon.",
	150,
	150.10,
	300.50);

-- Estimados, no tengo idea de por qué el creador de la base de datos no definió el número de orden como un campo autoincrementado. Tal vez tenga que ver con la forma en la que se adjudican los números de factura.
-- No se preocupen por esta sentencia. Simplemente la utilizo para averiguar el número de la última orden, e incrementar el índice.
-- Esto NO ES UNA BUENA PRÁCTICA.
SET @nextOrderNumber = (SELECT (MAX(orderNumber) + 1) FROM orders);

-- Ahora llega un cliente y compra una orden de autogiros:
INSERT INTO orders
	(orderNumber,
	orderDate,
	requiredDate,
	status,
	comments,
	customerNumber)
VALUES
	(@nextOrderNumber,
	CURRENT_DATE(),
	DATE_ADD(orderDate, INTERVAL 14 DAY),
	"In Process",
	DEFAULT,
	121);

-- Y ahora resta cargarle los productos que el cliente compró:
INSERT INTO orderdetails
VALUES
	(@nextOrderNumber,
	"A12_0001",
	20,
	(SELECT MSRP FROM products p WHERE p.productCode = "A12_0001"),
	1),
	(@nextOrderNumber,
	"A12_0002",
	10,
	(SELECT MSRP FROM products p WHERE p.productCode = "A12_0002"),
	2),
	(@nextOrderNumber,
	"A12_0004",
	40,
	(SELECT MSRP FROM products p WHERE p.productCode = "A12_0004"),
	3);

-- UPDATES --

-- Ahora el cliente nos informa que ha decidido duplicar las cantidad de productos comprados en esta orden. Como la orden aún no fue procesada, aceptamos con gusto.
UPDATE orderdetails
SET quantityOrdered = quantityOrdered * 2
WHERE orderNumber = @nextOrderNumber;

-- Estamos tan felices con la compra, que le hacemos un 5% de descuento:
UPDATE orderdetails
SET priceEach = priceEach - (priceEach * 0.05)
WHERE orderNumber = @nextOrderNumber;

-- DELETE --

-- Pero finalmente el cliente decide cancelar la orden antes de que siquiera se haya terminado de procesar. Decidimos borrarla.
DELETE FROM orderdetails
WHERE orderNumber = @nextOrderNumber;

DELETE FROM orders
WHERE orderNumber = @nextOrderNumber;

-- Aclaración importante: La tabla debería haber sido creada con la cláusula ON DELETE, para que con solo borrar la orden se borraran los detalles. Veremos dicha cláusula cuando veamos el DDL, más adelante.
-- Aclaración importante 2: Usualmente no se borran registros de la base de datos. Solamente se "marcan" como borrados (soft delete), de alguna de varias formas. Probablemente en este caso, lo que hubiera correspondido sería marcar el estado de la orden como "Cancelled" (Cancelada).