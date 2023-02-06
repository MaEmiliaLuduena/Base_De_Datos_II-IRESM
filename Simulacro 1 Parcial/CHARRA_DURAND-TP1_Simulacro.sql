DROP DATABASE IF EXISTS clase_7_actividad_1;
CREATE DATABASE clase_7_actividad_1;
USE clase_7_actividad_1;

-- 1:
CREATE TABLE proveedores(
	id_prov BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	desc_prov VARCHAR(64) NOT NULL UNIQUE,
	telCont_prov VARCHAR(16)
);

CREATE TABLE depositos(
	cod_dep CHAR(6) PRIMARY KEY,
	calle_dep VARCHAR(64) NOT NULL,
	altura_dep INTEGER UNSIGNED
);

CREATE TABLE piezas(
	cod_pie CHAR(6) PRIMARY KEY,
	desc_pie VARCHAR(64) NOT NULL,
	id_prov BIGINT UNSIGNED NOT NULL,
	CONSTRAINT pie_idprov_fk FOREIGN KEY(id_prov)
		REFERENCES proveedores(id_prov)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE existencias(
	cod_dep CHAR(6) NOT NULL,
	cod_pie CHAR(6) NOT NULL,
	stock_exis INTEGER UNSIGNED NOT NULL DEFAULT 0,
	CONSTRAINT exis_coddep_fk FOREIGN KEY(cod_dep)
		REFERENCES depositos(cod_dep)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	CONSTRAINT exis_codpie_fk FOREIGN KEY(cod_pie)
		REFERENCES piezas(cod_pie)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

-- 2:
INSERT INTO proveedores(id_prov, desc_prov, telCont_prov) VALUES
	(1, 	"Tigre Argentina S. A.",    	"1122334455"),
	(2, 	"PETROFISA PLÁSTICOS S.A.", 	"9999999999"),
	(3, 	"SAINT GOBAIN ARG. S.A.",   	"7777777777");

INSERT INTO depositos(cod_dep, calle_dep, altura_dep) VALUES
	("COR001", 	"Av. Recta Martinolli",             	7988),
	("COR002", 	"Monseñor Pablo Cabrera",           	5030),
	("COR003", 	"Av. de Circunvalación Agustín Tosco", 	4460);

INSERT INTO piezas(cod_pie, desc_pie, id_prov) VALUES
	("CPAD01", 	"Cañería de PEAD",                      	1),
	("CPRFV1", 	"Cañería de PRFV",                      	2),
	("CPVC01", 	"Cañería de PVC",                       	1),
	("VALV01", 	"Válvula triple función con obturador", 	3),
	("VALV02", 	"Válvula mariposa",                       	3);

INSERT INTO existencias(cod_dep, cod_pie, stock_exis) VALUES
	("COR001", 	"VALV01", 	200),
	("COR001", 	"VALV02", 	430),
	("COR002", 	"CPVC01", 	150),
	("COR002", 	"CPRFV1", 	150),
	("COR003", 	"CPRFV1", 	250),
	("COR003", 	"CPAD01", 	340),
	("COR003", 	"VALV01", 	150);

-- 3:
ALTER TABLE depositos MODIFY COLUMN calle_dep VARCHAR(128) NOT NULL DEFAULT "Calle Pública";

-- 4a:
SELECT
	cod_pie AS "Cód. Pieza",
	desc_pie AS "Pieza",
	desc_prov AS "Proveedor",
	stock_exis AS "Stock",
	depositos.cod_dep AS "Cód. Depósito",
	calle_dep AS "Calle",
	altura_dep AS "Altura"
FROM
	proveedores INNER JOIN
	piezas USING(id_prov) INNER JOIN
	existencias USING(cod_pie) INNER JOIN
	depositos USING(cod_dep)
ORDER BY
	piezas.cod_pie DESC;

-- 4b:
SELECT
	cod_dep AS "Cód. Depósito",
	stock_exis AS "Stock",
    calle_dep AS "Calle",
    altura_dep AS "Altura"
FROM
	piezas INNER JOIN
    existencias USING(cod_pie) INNER JOIN
    depositos USING(cod_dep)
WHERE
	cod_pie = "CPRFV1";

-- 5:
UPDATE existencias
	SET stock_exis = stock_exis - 50
WHERE cod_dep = "COR002" AND cod_pie = "CPRFV1";