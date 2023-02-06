-- En primer lugar es necesario seleccionar una BD.
-- Si no existe la que necesitamos, la creamos.
DROP DATABASE IF EXISTS lista_videojuegos;
CREATE DATABASE lista_videojuegos;
-- Y luego de crearla, debemos seleccionarla para utilizarla.
USE lista_videojuegos;

-- DDL

-- Como es una BD nueva, vemos que no contiene tablas. Es hora de crearlas.
-- Aunque las tablas se pueden crear y modificar después, lo más cómodo es comenzar por aquellas tablas que no tienen claves foráneas.
CREATE TABLE generos (
	cod_gen  CHAR(3),
	desc_gen CHAR(16) NOT NULL UNIQUE,
	foo_gen INTEGER UNSIGNED DEFAULT 0,
	PRIMARY KEY(cod_gen)
);

-- Luego de creada la tabla, podemos modificarla a nuestro gusto.
-- Por ejemplo, así prodríamos añadir una expresión regular que chequee el código de género antes de añadirlo:
ALTER TABLE generos ADD CONSTRAINT gen_cod_ck CHECK (REGEXP_LIKE(cod_gen, "^[A-Z]{3}$", "c"));

-- Podemos modificar o incluso eliminar columnas.
ALTER TABLE generos MODIFY foo_gen INTEGER UNSIGNED DEFAULT 3;
ALTER TABLE generos DROP COLUMN foo_gen;

-- Seguimos con la tabla desarrolladores. (Otra que no contiene claves foráneas.)
CREATE TABLE desarrolladores (
	cod_des CHAR(4),
	descripcion_des CHAR(32) NOT NULL UNIQUE,
	anyoFundacion_des DATE NOT NULL,
	PRIMARY KEY (cod_des),
	CONSTRAINT des_cod_ck CHECK (REGEXP_LIKE(cod_des, "^[A-Z]{4}$", "c"))
);
-- ¿Y por qué no usar el tipo YEAR para anyoFundacion_des? Porque no soporta años anteriores a 1901.

-- Pero... ¡El código para Take-Two contiene un número! Esa restricción no nos va a servir.
-- No podemos modificar una restricción. Pero podemos borrarla y recrearla, que es lo mismo.
ALTER TABLE desarrolladores DROP CONSTRAINT des_cod_ck;
ALTER TABLE desarrolladores ADD CONSTRAINT des_cod_ck CHECK(REGEXP_LIKE(cod_des, "^[A-Z0-9]{4}$", "c"));

-- Ahora podemos crear la tabla de juegos.
-- Esta es otra forma de especificar restricciones como la clave primaria.
-- La restricción FOREIGN KEY sirve para especificar una clave foránea. (Y de qué tabla procederán sus valores.)
CREATE TABLE juegos (
	id_jue BIGINT UNSIGNED AUTO_INCREMENT,
	nombre_jue CHAR(64) NOT NULL,
	anyoLanzamiento_jue YEAR NOT NULL,
	cod_des CHAR(4) NOT NULL,
	PRIMARY KEY (id_jue),
	CONSTRAINT jue_coddes_fk FOREIGN KEY (cod_des)
		REFERENCES desarrolladores(cod_des)
		ON DELETE CASCADE
);

-- Nos falta guardar la información de qué generos tiene cada juego.
-- Creamos la tabla intermedia juegos_generos (Juegos por género.)
CREATE TABLE juegos_generos (
	id_jue BIGINT UNSIGNED NOT NULL,
	cod_gen CHAR(3) NOT NULL,
	CONSTRAINT jxg_idjue_fk FOREIGN KEY (id_jue)
		REFERENCES juegos(id_jue)
		ON DELETE CASCADE,
	CONSTRAINT jxg_codgen_fk FOREIGN KEY (cod_gen)
		REFERENCES generos(cod_gen)
		ON DELETE CASCADE
);
