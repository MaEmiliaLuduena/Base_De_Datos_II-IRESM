DROP DATABASE IF EXISTS PrimerPractico;
CREATE DATABASE PrimerPractico;
USE PrimerPractico;

-- Consigna 1 -- 
-- Cree la base de datos, de manera que incluya las siguientes tablas: generos, peliculas, actores, repartos.
CREATE TABLE generos(
	cod_gen CHAR(3) PRIMARY KEY,
    desc_gen VARCHAR(32) NOT NULL
);

CREATE TABLE peliculas( 
	id_pel BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    titulo_pel VARCHAR(128) NOT NULL,
    cod_gen VARCHAR(32) NOT NULL,
    CONSTRAINT pel_codgen_fk FOREIGN KEY(cod_gen)
		REFERENCES generos(cod_gen)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE actores(
	id_act BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nombreApellido_act VARCHAR(128) NOT NULL
);

CREATE TABLE repartos(
	id_pel BIGINT UNSIGNED,
    id_act BIGINT UNSIGNED,
    protagonista_rep TINYINT(1) NOT NULL DEFAULT 0, 
	CONSTRAINT rep_idpel_fk FOREIGN KEY(id_pel)
		REFERENCES peliculas(id_pel)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT rep_idact_fk FOREIGN KEY(id_act)
		REFERENCES actores(id_act)
		ON DELETE CASCADE
		ON UPDATE CASCADE
    );
    
-- Consigna 2 -- 
-- Cargue en esa base de datos los datos que figuran en la planilla “TP1-Datos”.
INSERT INTO generos(cod_gen, desc_gen) VALUES
	("ACC", "Acción"),
    ("ANI", "Animada"), 
    ("DRA", "Drama"),
    ("HIS", "Hitorica"), 
    ("SCF", "Ciencia-Ficción"), 
    ("TER", "Terror"), 
    ("WES", "Western");
    
INSERT INTO peliculas(id_pel, titulo_pel, cod_gen) VALUES
	(1, "Rescatando al soldado Ryan" , "ACC"),
    (2, "Forrest Gump", "DRA"),
    (3, "Los imperdonables", "WES"),
    (4, "Buenos muchachos", "DRA"),
    (5, "El silencio de los inocentes", "TER"),
    (6, "Corazón valiente", "HIS"),
    (7, "Tiempos violentos", "ACC"), 
    (8, "Sueños de libertad", "DRA"),
    (9, "Belleza americana", "DRA"),
    (10, "La lista de Schindler", "HIS");

INSERT INTO actores(id_act, nombreApellido_act) VALUES 
	(1, "Tom Hanks"),
    (2, "Clint Eastwood"),
    (3, "Robert DeNiro"),
    (4, "Joe Pesci"),
    (5, "Anthony Hopkins"),
    (6, "Mel Gibson"),
    (7, "John Travolta"),
    (8, "Morgan Freeman"),
    (9, "Kevin Spacey"),
    (10, "Liam Neeson"),
    (11, "Stephen Billington"),
    (12, "Peter Miles");
    
INSERT INTO repartos(id_pel, id_act, protagonista_rep) VALUES
	(1, 1, 1),
    (2, 1, 1),
    (3, 2, 1),
    (4, 3, 1),
    (4, 4, 1),
    (5, 5, 1),
    (6, 6, 0),
    (7, 7, 1),
    (8, 8, 1),
    (9, 9, 1), 
    (10, 10, 1),
    (1, 12, 0), 
    (6, 11, 0);

-- Consigna 3 -- 
-- Modifique la columna generos.desc_gen de modo que sea VARCHAR(64) NOT NULL
ALTER TABLE generos MODIFY COLUMN desc_gen VARCHAR(64) NOT NULL;

-- Consigna 4.A -- 
-- Selección de todas las películas con su género y actores, ordenadas por título de la película.
SELECT 
	id_pel AS "ID Pelicula",
    titulo_pel AS "Título", 
    desc_gen AS "Género", 
    nombreApellido_act AS "Actor" 
FROM 
	generos 
    INNER JOIN peliculas USING(cod_gen)
    INNER JOIN repartos USING(id_pel)
    INNER JOIN actores USING(id_act)
ORDER BY
	titulo_pel;
    
-- Consigna 4.B --
-- Selección de actores que tienen registrado al menos un rol NO protagónico. 
SELECT 
	id_act AS "ID Actor", 
	nombreApellido_act AS "Actor"
FROM 
	actores 
    INNER JOIN repartos USING(id_act)
WHERE 
	protagonista_rep = 0;
    

-- Consigna 5-- 
-- Mel Gibson fue protagonista en Corazón Valiente. Corrija la entrada correspondiente.
UPDATE repartos INNER JOIN actores USING(id_act) INNER JOIN peliculas USING(id_pel)
	SET protagonista_rep  = protagonista_rep = 0
WHERE nombreApellido_act = "Mel Gibson" AND titulo_pel = "Corazón valiente";

SELECT 
	id_act AS "ID Actor", 
	nombreApellido_act AS "Actor"
FROM 
	actores 
    INNER JOIN repartos USING(id_act)
WHERE 
	protagonista_rep = 0;
    


	


