-- MySQL dump 10.13  Distrib 5.6.26, for osx10.11 (x86_64)
--
-- Host: localhost    Database: smaug
-- ------------------------------------------------------
-- Server version	5.6.26

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
-- Table structure for table `stories`
--

DROP TABLE IF EXISTS `stories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `cover` varchar(255) DEFAULT NULL,
  `published_at` datetime DEFAULT NULL,
  `description` text,
  `inserted_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stories`
--

LOCK TABLES `stories` WRITE;
/*!40000 ALTER TABLE `stories` DISABLE KEYS */;
INSERT INTO `stories` VALUES (1,'１２３４５６７８９０','１２３４５６７８９０','story-cover-1.jpg','2010-01-01 00:00:00','１２３４５６７８９０','2015-10-06 05:38:55','2015-10-06 06:28:20'),(2,'１２３４５６７８９０','１２３４５６７８９０','story-cover-2.jpg','2010-01-01 00:00:00','１２３４５６７８９０\r\n１２３４５６７８９０\r\n１２３４５６７８９０','2015-10-06 06:28:09','2015-10-06 06:28:09'),(3,'１２３４５６７８９０','１２３４５６７８９０','story-cover-3.jpg','2010-01-01 00:00:00','１２３４５６７８９０\r\n１２３４５６７８９０\r\n１２３４５６７８９０','2015-10-06 06:36:47','2015-10-06 06:36:47'),(4,'１２３４５６７８９０','１２３４５６７８９０','story-cover-4.jpg','2010-01-01 00:00:00','１２３４５６７８９０\r\n１２３４５６７８９０\r\n１２３４５６７８９０','2015-10-06 05:38:55','2015-10-06 06:28:20'),(5,'１２３４５６７８９０','１２３４５６７８９０','story-cover-5.jpg','2010-01-01 00:00:00','１２３４５６７８９０\r\n１２３４５６７８９０\r\n１２３４５６７８９０','2015-10-06 06:28:09','2015-10-06 06:28:09'),(6,'１２３４５６７８９０','１２３４５６７８９０','story-cover-6.jpg','2010-01-01 00:00:00','１２３４５６７８９０\r\n１２３４５６７８９０\r\n１２３４５６７８９０','2015-10-06 06:36:47','2015-10-06 06:36:47'),(7,'１２３４５６７８９０','１２３４５６７８９０','story-cover-7.jpg','2010-01-01 00:00:00','１２３４５６７８９０\r\n１２３４５６７８９０\r\n１２３４５６７８９０','2015-10-06 05:38:55','2015-10-06 06:28:20'),(8,'１２３４５６７８９０','１２３４５６７８９０','story-cover-8.jpg','2010-01-01 00:00:00','１２３４５６７８９０\r\n１２３４５６７８９０\r\n１２３４５６７８９０','2015-10-06 06:28:09','2015-10-06 06:28:09'),(9,'１２３４５６７８９０','１２３４５６７８９０','story-cover-9.jpg','2010-01-01 00:00:00','１２３４５６７８９０\r\n１２３４５６７８９０\r\n１２３４５６７８９０','2015-10-06 06:36:47','2015-10-06 06:36:47'),(10,'１２３４５６７８９０','１２３４５６７８９０','story-cover-10.jpg','2010-01-01 00:00:00','１２３４５６７８９０\r\n１２３４５６７８９０\r\n１２３４５６７８９０','2015-10-06 05:38:55','2015-10-06 06:28:20'),(11,'１２３４５６７８９０','１２３４５６７８９０','story-cover-11.jpg','2010-01-01 00:00:00','１２３４５６７８９０\r\n１２３４５６７８９０\r\n１２３４５６７８９０','2015-10-06 06:28:09','2015-10-06 06:28:09'),(12,'１２３４５６７８９０','１２３４５６７８９０','story-cover-12.jpg','2010-01-01 00:00:00','１２３４５６７８９０\r\n１２３４５６７８９０\r\n１２３４５６７８９０','2015-10-06 06:36:47','2015-10-06 06:36:47'),(13,'１２３４５６７８９０','１２３４５６７８９０','story-cover-13.jpg','2010-01-01 00:00:00','１２３４５６７８９０\r\n１２３４５６７８９０\r\n１２３４５６７８９０','2015-10-06 05:38:55','2015-10-06 06:28:20'),(14,'１２３４５６７８９０','１２３４５６７８９０','story-cover-14.jpg','2010-01-01 00:00:00','１２３４５６７８９０\r\n１２３４５６７８９０\r\n１２３４５６７８９０','2015-10-06 06:28:09','2015-10-06 06:28:09'),(15,'１２３４５６７８９０','１２３４５６７８９０','story-cover-15.jpg','2010-01-01 00:00:00','１２３４５６７８９０\r\n１２３４５６７８９０\r\n１２３４５６７８９０','2015-10-06 06:36:47','2015-10-06 06:36:47'),(16,'１２３４５６７８９０','１２３４５６７８９０','story-cover-16.jpg','2010-01-01 00:00:00','１２３４５６７８９０\r\n１２３４５６７８９０\r\n１２３４５６７８９０','2015-10-06 06:28:09','2015-10-06 06:28:09'),(17,'１２３４５６７８９０','１２３４５６７８９０','story-cover-17.jpg','2010-01-01 00:00:00','１２３４５６７８９０\r\n１２３４５６７８９０\r\n１２３４５６７８９０','2015-10-06 06:36:47','2015-10-06 06:36:47'),(18,'１２３４５６７８９０','１２３４５６７８９０','story-cover-18.jpg','2010-01-01 00:00:00','１２３４５６７８９０\r\n１２３４５６７８９０\r\n１２３４５６７８９０','2015-10-06 05:38:55','2015-10-06 06:28:20'),(19,'１２３４５６７８９０','１２３４５６７８９０','story-cover-19.jpg','2010-01-01 00:00:00','１２３４５６７８９０\r\n１２３４５６７８９０\r\n１２３４５６７８９０','2015-10-06 06:28:09','2015-10-06 06:28:09'),(20,'１２３４５６７８９０','１２３４５６７８９０','story-cover-20.jpg','2010-01-01 00:00:00','１２３４５６７８９０\r\n１２３４５６７８９０\r\n１２３４５６７８９０','2015-10-06 06:36:47','2015-10-06 06:36:47');
/*!40000 ALTER TABLE `stories` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-10-06 15:44:09
