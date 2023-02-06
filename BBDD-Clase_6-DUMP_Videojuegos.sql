CREATE DATABASE  IF NOT EXISTS `lista_videojuegos` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `lista_videojuegos`;
-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: lista_videojuegos
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `desarrolladores`
--

DROP TABLE IF EXISTS `desarrolladores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `desarrolladores` (
  `cod_des` char(4) NOT NULL,
  `descripcion_des` char(32) NOT NULL,
  `anyoFundacion_des` date NOT NULL,
  PRIMARY KEY (`cod_des`),
  UNIQUE KEY `descripcion_des` (`descripcion_des`),
  CONSTRAINT `des_cod_ck` CHECK (regexp_like(`cod_des`,_utf8mb4'^[A-Z0-9]{4}$',_utf8mb4'c'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `desarrolladores`
--

LOCK TABLES `desarrolladores` WRITE;
/*!40000 ALTER TABLE `desarrolladores` DISABLE KEYS */;
INSERT INTO `desarrolladores` VALUES ('MSFT','Microsoft Game Studios','2000-01-01'),('NINT','Nintendo','1889-01-01'),('SEGA','Sega Corporation','1960-01-01'),('TK2I','Take-Two Interactive','1993-01-01');
/*!40000 ALTER TABLE `desarrolladores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `generos`
--

DROP TABLE IF EXISTS `generos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `generos` (
  `cod_gen` char(3) NOT NULL,
  `desc_gen` char(16) NOT NULL,
  PRIMARY KEY (`cod_gen`),
  UNIQUE KEY `desc_gen` (`desc_gen`),
  CONSTRAINT `gen_cod_ck` CHECK (regexp_like(`cod_gen`,_utf8mb4'^[A-Z]{3}$',_utf8mb4'c'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `generos`
--

LOCK TABLES `generos` WRITE;
/*!40000 ALTER TABLE `generos` DISABLE KEYS */;
INSERT INTO `generos` VALUES ('ACT','Action'),('MSC','Misc'),('PLT','Platform'),('PUZ','Puzzle'),('RAC','Racing'),('RET','Retro'),('RPG','Role-Playing'),('SHO','Shooter'),('SIM','Simulation'),('SPT','Sports');
/*!40000 ALTER TABLE `generos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `juegos`
--

DROP TABLE IF EXISTS `juegos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `juegos` (
  `id_jue` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nombre_jue` char(64) NOT NULL,
  `anyoLanzamiento_jue` year NOT NULL,
  `cod_des` char(4) NOT NULL,
  PRIMARY KEY (`id_jue`),
  KEY `jue_coddes_fk` (`cod_des`),
  CONSTRAINT `jue_coddes_fk` FOREIGN KEY (`cod_des`) REFERENCES `desarrolladores` (`cod_des`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `juegos`
--

LOCK TABLES `juegos` WRITE;
/*!40000 ALTER TABLE `juegos` DISABLE KEYS */;
INSERT INTO `juegos` VALUES (1,'Wii Sports',2006,'NINT'),(2,'Super Mario Bros.',1985,'NINT'),(3,'Mario Kart Wii',2008,'NINT'),(4,'Wii Sports Resort',2009,'NINT'),(5,'Pokemon Red/Pokemon Blue',1996,'NINT'),(6,'Tetris',1989,'NINT'),(7,'New Super Mario Bros.',2006,'NINT'),(8,'Wii Play',2006,'NINT'),(9,'New Super Mario Bros. Wii',2009,'NINT'),(10,'Duck Hunt',1984,'NINT'),(11,'Nintendogs',2005,'NINT'),(12,'Mario Kart DS',2005,'NINT'),(13,'Pokemon Gold/Pokemon Silver',1999,'NINT'),(14,'Wii Fit',2007,'NINT'),(15,'Wii Fit Plus',2009,'NINT'),(16,'Kinect Adventures!',2010,'MSFT'),(17,'Grand Theft Auto V',2013,'TK2I'),(18,'Grand Theft Auto: San Andreas',2004,'TK2I'),(19,'Super Mario World',1990,'NINT'),(20,'Brain Age: Train Your Brain in Minutes a Day',2005,'NINT');
/*!40000 ALTER TABLE `juegos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `juegos_generos`
--

DROP TABLE IF EXISTS `juegos_generos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `juegos_generos` (
  `id_jue` bigint unsigned NOT NULL,
  `cod_gen` char(3) NOT NULL,
  KEY `jxg_idjue_fk` (`id_jue`),
  KEY `jxg_codgen_fk` (`cod_gen`),
  CONSTRAINT `jxg_codgen_fk` FOREIGN KEY (`cod_gen`) REFERENCES `generos` (`cod_gen`) ON DELETE CASCADE,
  CONSTRAINT `jxg_idjue_fk` FOREIGN KEY (`id_jue`) REFERENCES `juegos` (`id_jue`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `juegos_generos`
--

LOCK TABLES `juegos_generos` WRITE;
/*!40000 ALTER TABLE `juegos_generos` DISABLE KEYS */;
INSERT INTO `juegos_generos` VALUES (1,'SPT'),(2,'PLT'),(2,'RET'),(3,'RAC'),(4,'SPT'),(5,'RPG'),(5,'RET'),(6,'PUZ'),(6,'RET'),(7,'PLT'),(8,'MSC'),(9,'PLT'),(10,'SHO'),(10,'RET'),(11,'SIM'),(12,'RAC'),(13,'RPG'),(13,'RET'),(14,'SPT'),(15,'SPT'),(16,'MSC'),(17,'ACT'),(18,'ACT'),(19,'PLT'),(19,'RET'),(20,'MSC');
/*!40000 ALTER TABLE `juegos_generos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'lista_videojuegos'
--

--
-- Dumping routines for database 'lista_videojuegos'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-09-14 20:04:54
