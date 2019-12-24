-- MySQL dump 10.13  Distrib 5.7.28, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: ck_elektro_trans
-- ------------------------------------------------------
-- Server version	5.7.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(127) NOT NULL COMMENT 'Name',
  `info` varchar(1023) DEFAULT NULL COMMENT 'Information about employee',
  `dob` date DEFAULT NULL COMMENT 'Date of Birth',
  `lastname` varchar(63) DEFAULT NULL COMMENT 'Lastname of employee',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='Employees';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,'Mike',NULL,'1997-01-20','Khrypko'),(2,'John',NULL,'1956-05-23',NULL),(3,'Galyna',NULL,'1987-07-01',NULL),(4,'Petro',NULL,'2001-12-23',NULL),(5,'Nikolay',NULL,'1974-02-28',NULL),(6,'Tiger',NULL,'1998-01-20',NULL),(7,'Inna',NULL,'1957-05-23',NULL),(8,'Aleksandr',NULL,'1988-07-01',NULL),(9,'Petro Dyzi',NULL,'2000-12-23','Dyzi'),(10,'Nikolay Kyzimin',NULL,'1975-02-28','Kyzimin');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees_position_time`
--

DROP TABLE IF EXISTS `employees_position_time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employees_position_time` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `start_date` date DEFAULT NULL COMMENT 'Date when the employee started working at the position.',
  `end_date` date DEFAULT NULL COMMENT 'Date when the employee stopped working at the position.',
  `position_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to position.id',
  `employee_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to employee.id',
  PRIMARY KEY (`id`),
  KEY `EMPLOYEE_POSITION_TIME_POSITION_ID_POSITION_ID` (`position_id`),
  KEY `EMPLOYEE_POSITION_TIME_EMPLOYEE_ID_EMPLOYEE_ID` (`employee_id`),
  CONSTRAINT `EMPLOYEE_POSITION_TIME_EMPLOYEE_ID_EMPLOYEE_ID` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE NO ACTION,
  CONSTRAINT `EMPLOYEE_POSITION_TIME_POSITION_ID_POSITION_ID` FOREIGN KEY (`position_id`) REFERENCES `position` (`id`) ON DELETE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='The time when employees worked at the position';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees_position_time`
--

LOCK TABLES `employees_position_time` WRITE;
/*!40000 ALTER TABLE `employees_position_time` DISABLE KEYS */;
INSERT INTO `employees_position_time` VALUES (7,'2005-01-01','2005-05-31',4,2),(8,'2005-01-01','2005-05-31',1,10),(9,'2005-01-01','2005-05-31',2,7),(10,'2005-01-01','2005-01-31',2,3),(11,'2005-02-01','2007-02-28',3,4),(12,'2005-03-01','2005-05-31',1,4);
/*!40000 ALTER TABLE `employees_position_time` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `position`
--

DROP TABLE IF EXISTS `position`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `position` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(127) NOT NULL COMMENT 'Name of Position',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Positions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `position`
--

LOCK TABLES `position` WRITE;
/*!40000 ALTER TABLE `position` DISABLE KEYS */;
INSERT INTO `position` VALUES (1,'Driver'),(2,'Conductor'),(3,'Accountant'),(4,'Manager');
/*!40000 ALTER TABLE `position` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salary`
--

DROP TABLE IF EXISTS `salary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salary` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `start_date` date DEFAULT NULL COMMENT 'Start of time interval to this salary',
  `end_date` date DEFAULT NULL COMMENT 'End of time interval to this salary',
  `amount` float NOT NULL COMMENT 'Salary amount',
  `employee_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to employee.id',
  PRIMARY KEY (`id`),
  KEY `SALARY_EMPLOYEE_ID_EMPLOYEE_ID` (`employee_id`),
  CONSTRAINT `SALARY_EMPLOYEE_ID_EMPLOYEE_ID` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COMMENT='Salaries';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salary`
--

LOCK TABLES `salary` WRITE;
/*!40000 ALTER TABLE `salary` DISABLE KEYS */;
INSERT INTO `salary` VALUES (77,'2005-01-01','2005-01-31',3000,3),(78,'2005-01-01','2005-01-31',2600,10),(79,'2005-01-01','2005-01-31',2800,7),(80,'2005-01-01','2005-01-31',4000,2),(81,'2005-02-01','2005-02-28',2600,4),(82,'2005-02-01','2005-02-28',2800,7),(83,'2005-02-01','2005-02-28',4000,2),(84,'2005-02-01','2005-02-28',3000,10),(85,'2005-02-01','2005-02-28',2800,9),(86,'2005-03-01','2005-03-31',2600,4),(87,'2005-03-01','2005-03-31',2800,7),(88,'2005-03-01','2005-03-31',4000,2),(89,'2005-03-01','2005-03-31',3000,10),(90,'2005-03-01','2005-03-31',2800,9),(91,'2005-04-01','2005-04-30',2600,4),(92,'2005-04-01','2005-04-30',2800,7),(93,'2005-04-01','2005-04-30',4000,2),(94,'2005-04-01','2005-04-30',3000,10),(95,'2005-04-01','2005-04-30',2800,9),(96,'2005-05-01','2005-05-31',2600,4),(97,'2005-05-01','2005-05-31',2800,7),(98,'2005-05-01','2005-05-31',4000,2),(99,'2005-05-01','2005-05-31',3000,10),(100,'2005-05-01','2005-05-31',2800,9);
/*!40000 ALTER TABLE `salary` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transport`
--

DROP TABLE IF EXISTS `transport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transport` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(127) NOT NULL COMMENT 'Name of auto',
  `info` varchar(1023) DEFAULT NULL COMMENT 'Information about auto',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='Transports';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transport`
--

LOCK TABLES `transport` WRITE;
/*!40000 ALTER TABLE `transport` DISABLE KEYS */;
INSERT INTO `transport` VALUES (1,'Bogdan #1','Number: \"CA 1345\"'),(2,'Bogdan #2','Number: \"CA 1346\"'),(3,'Bogdan #3','Number: \"CA 1347\"'),(4,'Bogdan #4','Number: \"CA 1348\"'),(5,'Bogdan #5','Number: \"CA 1349\"'),(6,'Bogdan #6','Number: \"CA 1350\"'),(7,'Bogdan #7','Number: \"CA 1351\"'),(8,'Bogdan #8','Number: \"CA 1352\"'),(9,'Bogdan #9','Number: \"CA 1353\"'),(10,'Bogdan #10','Number: \"CA 1354\"'),(11,'Bogdan #11','Number: \"CA 1355\"'),(12,'Bogdan #12','Number: \"CA 1356\"'),(13,'Bogdan #13','Number: \"CA 1357\"'),(14,'Bogdan #14','Number: \"CA 1358\"'),(15,'Bogdan #15','Number: \"CA 1359\"'),(16,'Bogdan #16','Number: \"CA 1360\"'),(17,'Bogdan #17','Number: \"CA 1371\"'),(18,'Bogdan #18','Number: \"CA 1372\"'),(19,'Bogdan #19','Number: \"CA 1373\"'),(20,'Bogdan #20','Number: \"CA 1374\"'),(21,'Bogdan #21','Number: \"CA 1375\"'),(22,'Bogdan #22','Number: \"CA 1376\"'),(23,'Bogdan #23','Number: \"CA 1377\"');
/*!40000 ALTER TABLE `transport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transport_accounting`
--

DROP TABLE IF EXISTS `transport_accounting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transport_accounting` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `date` date DEFAULT NULL COMMENT 'Days when auto were in trip',
  `income` float NOT NULL COMMENT 'Income for the day',
  `employees_position_time_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to employees_position_time.id',
  `transport_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to transport.id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `date_and_employees_position_time_id` (`date`,`employees_position_time_id`),
  UNIQUE KEY `date_and_transport_id` (`date`,`transport_id`),
  KEY `TRANSPORT_ACCOUNTING_E_P_T_ID_E_P_T_ID` (`employees_position_time_id`),
  KEY `TRANSPORT_ACCOUNTING_TRANSPORT_ID_TRANSPORT_ID` (`transport_id`),
  CONSTRAINT `TRANSPORT_ACCOUNTING_E_P_T_ID_E_P_T_ID` FOREIGN KEY (`employees_position_time_id`) REFERENCES `employees_position_time` (`id`) ON DELETE NO ACTION,
  CONSTRAINT `TRANSPORT_ACCOUNTING_TRANSPORT_ID_TRANSPORT_ID` FOREIGN KEY (`transport_id`) REFERENCES `transport` (`id`) ON DELETE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COMMENT='Transport accounting';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transport_accounting`
--

LOCK TABLES `transport_accounting` WRITE;
/*!40000 ALTER TABLE `transport_accounting` DISABLE KEYS */;
INSERT INTO `transport_accounting` VALUES (1,'2005-01-01',280,8,1),(2,'2005-01-02',280,8,1),(3,'2005-01-03',280,8,1),(4,'2005-01-04',280,8,1),(5,'2005-01-05',280,8,1),(6,'2005-01-06',280,8,1),(7,'2005-01-07',280,8,1),(8,'2005-01-08',280,8,1),(9,'2005-01-09',280,8,1),(10,'2005-01-10',280,8,1),(11,'2005-01-11',280,8,1),(12,'2005-01-12',280,8,1),(13,'2005-01-13',280,8,1),(14,'2005-01-14',280,8,1),(15,'2005-01-15',280,8,1),(16,'2005-01-16',280,8,1),(17,'2005-01-17',280,8,2),(18,'2005-01-18',280,8,1),(19,'2005-01-19',280,8,1),(20,'2005-01-20',280,8,1),(21,'2005-01-21',280,8,1),(22,'2005-01-22',280,8,1),(23,'2005-01-23',280,8,1),(24,'2005-01-24',280,8,1),(25,'2005-01-25',280,8,2),(26,'2005-01-26',280,8,6),(27,'2005-01-27',280,8,3),(28,'2005-01-28',280,8,4),(29,'2005-01-01',300,12,3),(30,'2005-01-02',280,12,4),(31,'2005-01-03',280,12,3);
/*!40000 ALTER TABLE `transport_accounting` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-12-24 11:10:32
