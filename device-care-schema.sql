CREATE DATABASE  IF NOT EXISTS `device_insurance` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `device_insurance`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: device_insurance
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `claims`
--

DROP TABLE IF EXISTS `claims`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `claims` (
  `claim_id` int NOT NULL AUTO_INCREMENT,
  `claim_date` date NOT NULL,
  `status` varchar(45) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `settlement` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  PRIMARY KEY (`claim_id`),
  KEY `claims_product_id_fk_idx` (`product_id`),
  CONSTRAINT `claims_product_id_fk` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `claims`
--

LOCK TABLES `claims` WRITE;
/*!40000 ALTER TABLE `claims` DISABLE KEYS */;
/*!40000 ALTER TABLE `claims` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_types`
--

DROP TABLE IF EXISTS `product_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_types` (
  `product_type_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `model` varchar(45) DEFAULT NULL,
  `discontinued` tinyint DEFAULT NULL,
  PRIMARY KEY (`product_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_types`
--

LOCK TABLES `product_types` WRITE;
/*!40000 ALTER TABLE `product_types` DISABLE KEYS */;
INSERT INTO `product_types` VALUES (1,'Television-set',NULL,NULL),(2,'Refrigerator',NULL,NULL),(3,'Microwave',NULL,NULL),(4,'Electric kettle',NULL,NULL),(5,'iPhone 16',NULL,NULL),(6,'iPhone 16 Pro Max',NULL,NULL),(7,'Laptop',NULL,NULL),(8,'Personal Computer',NULL,NULL);
/*!40000 ALTER TABLE `product_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `serial_no` varchar(45) DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `product_type_id` int DEFAULT NULL,
  `protection_plan_id` int DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `product_type_id_fk_idx` (`product_type_id`),
  KEY `product_protection_plan_id_fk_idx` (`protection_plan_id`),
  CONSTRAINT `product_protection_plan_id_fk` FOREIGN KEY (`protection_plan_id`) REFERENCES `protection_plans` (`protection_plan_id`),
  CONSTRAINT `product_type_id_fk` FOREIGN KEY (`product_type_id`) REFERENCES `product_types` (`product_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'SN15975348620','2025-04-02',1,NULL),(2,'SN15975348620','2025-04-02',3,NULL),(3,'SN15975348620','2025-04-02',6,NULL),(4,'SN15975348620','2025-04-02',2,NULL),(5,'SN15975348620','2025-03-06',4,NULL),(6,'SN15975348620','2025-03-10',4,NULL),(7,'SN15975348620','2025-03-10',4,NULL),(8,'SN15975348620','2025-03-22',4,NULL),(9,'SN15975348620','2025-04-11',4,8),(10,'SN15975348620','2025-04-13',5,9);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `protection_plan_types`
--

DROP TABLE IF EXISTS `protection_plan_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `protection_plan_types` (
  `protection_plan_type_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `tier` int NOT NULL,
  `standard_premium` int NOT NULL,
  PRIMARY KEY (`protection_plan_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `protection_plan_types`
--

LOCK TABLES `protection_plan_types` WRITE;
/*!40000 ALTER TABLE `protection_plan_types` DISABLE KEYS */;
INSERT INTO `protection_plan_types` VALUES (1,'Peaceful Home - Basic',0,500),(2,'Peaceful Home - Standard',1,750),(3,'Peaceful Home - Premium',2,1000),(4,'No Inconveniences - Basic',0,500),(5,'No Inconveniences - Standard',1,700),(6,'No Inconveniences - Premium',2,900),(7,'Out of sight, out of mind - Basic',0,1000),(8,'Out of sight, out of mind - Standard',0,2500),(9,'Out of sight, out of mind - Premium',0,5000);
/*!40000 ALTER TABLE `protection_plan_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `protection_plans`
--

DROP TABLE IF EXISTS `protection_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `protection_plans` (
  `protection_plan_id` int NOT NULL AUTO_INCREMENT,
  `start_date` date NOT NULL,
  `expiry_date` date DEFAULT NULL,
  `premium` int NOT NULL,
  `protection_plan_type_id` int DEFAULT NULL,
  PRIMARY KEY (`protection_plan_id`),
  KEY `protection_plan_types_id_fk_idx` (`protection_plan_type_id`),
  CONSTRAINT `protection_plan_types_id_fk` FOREIGN KEY (`protection_plan_type_id`) REFERENCES `protection_plan_types` (`protection_plan_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `protection_plans`
--

LOCK TABLES `protection_plans` WRITE;
/*!40000 ALTER TABLE `protection_plans` DISABLE KEYS */;
INSERT INTO `protection_plans` VALUES (1,'2025-04-02','2030-04-02',750,2),(2,'2025-04-02','2030-04-02',750,2),(3,'2025-04-02','2030-04-02',1000,3),(4,'2025-04-02','2030-04-02',5000,9),(5,'2025-04-02','2030-04-02',900,6),(6,'2025-04-02','2030-04-02',900,6),(7,'2025-04-02','2030-04-02',1000,3),(8,'2025-04-02','2030-04-02',750,2),(9,'2025-04-02','2030-04-02',500,4);
/*!40000 ALTER TABLE `protection_plans` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `protection_plans_BEFORE_INSERT` BEFORE INSERT ON `protection_plans` FOR EACH ROW BEGIN
	IF NEW.premium IS NULL THEN
		SET NEW.premium = 
			(
				SELECT standard_premium 
				FROM `device_insurance`.`protection_plan_types` 
                WHERE protection_plan_type_id = NEW.protection_plan_type_id 
                LIMIT 1
			);
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `user_protection_plans`
--

DROP TABLE IF EXISTS `user_protection_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_protection_plans` (
  `user_id` int DEFAULT NULL,
  `protection_plan_id` int DEFAULT NULL,
  KEY `user_id_fk_idx` (`user_id`),
  KEY `protection_plan_id_fk_idx` (`protection_plan_id`),
  CONSTRAINT `protection_plan_id_fk` FOREIGN KEY (`protection_plan_id`) REFERENCES `protection_plans` (`protection_plan_id`),
  CONSTRAINT `user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_protection_plans`
--

LOCK TABLES `user_protection_plans` WRITE;
/*!40000 ALTER TABLE `user_protection_plans` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_protection_plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `email` varchar(45) NOT NULL,
  `address` varchar(45) DEFAULT NULL,
  `admin` tinyint DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-02 17:41:12
