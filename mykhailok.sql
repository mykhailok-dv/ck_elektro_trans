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
  `wage` float NOT NULL COMMENT 'Salary',
  `lastname` varchar(63) DEFAULT NULL COMMENT 'Lastname of employee',
  PRIMARY KEY (`id`),
  KEY `EMPLOYEE_WAGE` (`wage`),
  KEY `EMPLOYEE_LASTNAME` (`lastname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Employees';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
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
  KEY `EMPLOYEES_POSITION_TIME_START_DATE` (`start_date`),
  KEY `EMPLOYEES_POSITION_TIME_END_DATE` (`end_date`),
  CONSTRAINT `EMPLOYEE_POSITION_TIME_EMPLOYEE_ID_EMPLOYEE_ID` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE NO ACTION,
  CONSTRAINT `EMPLOYEE_POSITION_TIME_POSITION_ID_POSITION_ID` FOREIGN KEY (`position_id`) REFERENCES `position` (`id`) ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The time when employees worked at the position';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees_position_time`
--

LOCK TABLES `employees_position_time` WRITE;
/*!40000 ALTER TABLE `employees_position_time` DISABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Positions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `position`
--

LOCK TABLES `position` WRITE;
/*!40000 ALTER TABLE `position` DISABLE KEYS */;
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
  `pay_day` date DEFAULT NULL COMMENT 'Pay day',
  PRIMARY KEY (`id`),
  KEY `SALARY_EMPLOYEE_ID_EMPLOYEE_ID` (`employee_id`),
  KEY `SALARY_AMOUNT` (`amount`),
  KEY `SALARY_PAY_DAY` (`pay_day`),
  CONSTRAINT `SALARY_EMPLOYEE_ID_EMPLOYEE_ID` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Salaries';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salary`
--

LOCK TABLES `salary` WRITE;
/*!40000 ALTER TABLE `salary` DISABLE KEYS */;
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
  PRIMARY KEY (`id`),
  KEY `TRANSPORT_TITLE` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Transports';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transport`
--

LOCK TABLES `transport` WRITE;
/*!40000 ALTER TABLE `transport` DISABLE KEYS */;
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
  `employee_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to employees_position_time.id',
  `transport_id` int(10) unsigned NOT NULL COMMENT 'Foreign key to transport.id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `date_and_employees_id` (`date`,`employee_id`),
  UNIQUE KEY `date_and_transport_id` (`date`,`transport_id`),
  KEY `TRANSPORT_ACCOUNTING_EMPLOYEE_ID_EMPLOYEE_ID` (`employee_id`),
  KEY `TRANSPORT_ACCOUNTING_TRANSPORT_ID_TRANSPORT_ID` (`transport_id`),
  KEY `TRANSPORT_ACCOUNTING_DATE` (`date`),
  CONSTRAINT `TRANSPORT_ACCOUNTING_EMPLOYEE_ID_EMPLOYEE_ID` FOREIGN KEY (`employee_id`) REFERENCES `employee` (`id`) ON DELETE NO ACTION,
  CONSTRAINT `TRANSPORT_ACCOUNTING_TRANSPORT_ID_TRANSPORT_ID` FOREIGN KEY (`transport_id`) REFERENCES `transport` (`id`) ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Transport accounting';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transport_accounting`
--

LOCK TABLES `transport_accounting` WRITE;
/*!40000 ALTER TABLE `transport_accounting` DISABLE KEYS */;
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

-- Dump completed on 2019-12-27 15:04:43
