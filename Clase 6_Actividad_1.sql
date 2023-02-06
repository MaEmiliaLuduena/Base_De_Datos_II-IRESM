-- A partir de las siguientes descripciones de tablas y del modelo detallado en el pdf adjunto, y siguiendo la metodología vista en clase, implemente la base de datos 
-- a través de un script SQL. Incluya al menos una instrucción ALTER, a su preferencia.
DROP DATABASE IF EXISTS clase_6_actividad_1;
CREATE DATABASE clase_6_actividad_1;
USE clase_6_actividad_1;

-- DDL --

CREATE TABLE especialidades (
	cod_esp CHAR(3) PRIMARY KEY,
    desc_esp VARCHAR(64) NOT NULL,
    CONSTRAINT esp_codesp_ck
		CHECK (cod_esp REGEXP "^[A-Z]{3}$")
);

CREATE TABLE medicos (
	matricula_med CHAR(6) PRIMARY KEY,
    nombreApellido_med CHAR(64) NOT NULL,
    cod_esp CHAR(3) NOT NULL,
    CONSTRAINT med_codesp_fk
		FOREIGN KEY (cod_esp)
		REFERENCES especialidades(cod_esp)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
	CONSTRAINT med_matmed_ck
		CHECK (matricula_med REGEXP "^[0-9]{1,6}$")
);

CREATE TABLE pacientes (
	dni_pac CHAR(8) PRIMARY KEY,
    nombreApellido_pac VARCHAR(64) NOT NULL,
    CONSTRAINT pac_dnipac_ck
		CHECK (dni_pac REGEXP "^[0-9]{8}$")
);

CREATE TABLE turnos (
	matricula_med CHAR(6) NOT NULL,
    dni_pac CHAR(8) NOT NULL,
    fechaHora_tur DATETIME NOT NULL,
    CONSTRAINT tur_dnipac_fk
		FOREIGN KEY (dni_pac)
        REFERENCES pacientes(dni_pac)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	CONSTRAINT tur_matmed_fk
		FOREIGN KEY (matricula_med)
        REFERENCES medicos(matricula_med)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- DML --

INSERT INTO especialidades VALUES
	("ORL", "Otorrinolaringología"),
	("NEU", "Neurología"),
	("ODO", "Odontología"),
	("PED", "Pediatría"),
    ("TRA", "Traumatología");

INSERT INTO medicos VALUES
	("1000", "Juan Pérez",		"ORL"),
	("1001", "Marta Gómez",		"ODO"),
	("1002", "José Suárez",		"ODO"),
	("1003", "Luis Domínguez",	"NEU"),
	("1004", "María López",		"PED"),
    ("1005", "Pedro Valdéz",	"NEU");

INSERT INTO pacientes VALUES
	("30000888", "Apia Garza Sepúlveda"),
	("37888444", "Laureano Flores Dávila"),
	("28888999", "Canan Carrión Ayala"),
	("40000111", "Milton Armijo Solano"),
	("41555888", "Baco Guajardo Galarza");

INSERT INTO turnos VALUES
	(1000, "30000888", "2021-10-06 16:45:00"),
	(1000, "37888444", "2021-10-6 17:10:00"),
	(1003, "28888999", "2021-10-7 09:00:00"),
	(1004, "40000111", "2021-10-11 14:35:00"),
	(1004, "41555888", "2021-10-11 15:00:00"),
	(1001, "30000888", "2021-10-11 14:35:00");