-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 47.93.61.35    Database: hjb
-- ------------------------------------------------------
-- Server version	5.7.21

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
-- Table structure for table `expense_trade`
--

DROP TABLE IF EXISTS `expense_trade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expense_trade` (
  `expense_trade_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `remark` varchar(45) DEFAULT NULL,
  `fee` decimal(10,2) DEFAULT NULL,
  `trade_time` date DEFAULT NULL,
  `expense_user_id` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`expense_trade_id`),
  UNIQUE KEY `expense_trade_id_UNIQUE` (`expense_trade_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expense_trade`
--

LOCK TABLES `expense_trade` WRITE;
/*!40000 ALTER TABLE `expense_trade` DISABLE KEYS */;
INSERT INTO `expense_trade` VALUES (1,'180215测试入库','送货同城',50.00,'2018-02-15','18647106104');
/*!40000 ALTER TABLE `expense_trade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funding_change_log`
--

DROP TABLE IF EXISTS `funding_change_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `funding_change_log` (
  `funding_change_log_id` int(11) NOT NULL AUTO_INCREMENT,
  `funding_pool_id` int(11) DEFAULT NULL,
  `change_price` decimal(10,2) DEFAULT NULL,
  `change_type` varchar(45) DEFAULT NULL,
  `trade_id` int(11) DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL,
  `change_user_id` varchar(45) DEFAULT NULL,
  `change_time` datetime DEFAULT NULL,
  PRIMARY KEY (`funding_change_log_id`),
  UNIQUE KEY `funding_change_log_id_UNIQUE` (`funding_change_log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funding_change_log`
--

LOCK TABLES `funding_change_log` WRITE;
/*!40000 ALTER TABLE `funding_change_log` DISABLE KEYS */;
INSERT INTO `funding_change_log` VALUES (1,1,-768.20,'进货扣减资金',NULL,'testremark','1','2018-02-12 00:00:00'),(2,1,-768.20,'进货扣减资金',NULL,'testremark','1','2018-02-12 00:00:00'),(3,2,302.50,'销售增加资金',NULL,'testremark','1','2018-02-12 00:00:00'),(4,1,-960.00,'进货扣减资金',NULL,'是个负担','1','2018-02-12 00:00:00'),(5,2,10000.00,'销售增加资金',NULL,'时代风格','1','2018-02-12 00:00:00'),(6,2,-2500.00,'进货扣减资金',NULL,'的萨法的说法的说法','1','2018-02-12 00:00:00'),(7,2,500.00,'销售增加资金',NULL,'DSAF ','1','2018-02-12 00:00:00'),(8,2,500.00,'销售增加资金',NULL,'DSAF ','1','2018-02-12 00:00:00'),(9,2,2000.00,'销售增加资金',NULL,'时代风格豆腐干','1','2018-02-12 00:00:00'),(10,1,-3000.00,'进货扣减资金',NULL,'士大夫','1','2018-02-13 00:00:00'),(11,2,-121.00,'进货扣减资金',NULL,'ASDFDASF','1','2018-02-13 00:00:00'),(12,1,-360.00,'进货扣减资金',NULL,'爱上对方撒旦法','18647106104','2018-02-15 09:55:30'),(13,2,360.00,'销售增加资金',NULL,'讽德诵功','18647106104','2018-02-15 09:55:56'),(14,3,50.00,'花费LIST扣减资金',NULL,'送货同城','18647106104','2018-02-15 11:01:11'),(15,1,-384.00,'进货扣减资金',NULL,'士大夫','18647106104','2018-02-17 12:03:56'),(16,2,100.00,'销售增加资金',NULL,'iucn','18647106104','2018-02-22 15:18:16'),(17,2,100.00,'销售增加资金',NULL,'s','18647106104','2018-02-22 15:19:53'),(18,2,100.00,'销售增加资金',NULL,'s','18647106104','2018-02-22 15:20:28'),(19,2,100.00,'销售增加资金',NULL,'s','18647106104','2018-02-22 15:20:29'),(20,2,100.00,'销售增加资金',NULL,'s','18647106104','2018-02-22 15:20:30'),(21,2,100.00,'销售增加资金',NULL,'s','18647106104','2018-02-22 15:20:30'),(22,2,100.00,'销售增加资金',NULL,'s','18647106104','2018-02-22 15:22:39'),(23,2,150.00,'销售增加资金',NULL,'a','18647106104','2018-02-22 15:26:06'),(24,1,-2000.00,'进货扣减资金',NULL,'a','18647106104','2018-02-22 15:26:58');
/*!40000 ALTER TABLE `funding_change_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funding_pool`
--

DROP TABLE IF EXISTS `funding_pool`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `funding_pool` (
  `fund_pool_id` int(11) NOT NULL AUTO_INCREMENT,
  `pool_name` varchar(45) DEFAULT NULL,
  `pool_type` varchar(45) DEFAULT NULL,
  `rev` decimal(10,2) DEFAULT NULL,
  `exp` decimal(10,2) DEFAULT NULL,
  `balance` decimal(10,2) DEFAULT NULL,
  `sts` varchar(45) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`fund_pool_id`),
  UNIQUE KEY `fund_pool_id_UNIQUE` (`fund_pool_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funding_pool`
--

LOCK TABLES `funding_pool` WRITE;
/*!40000 ALTER TABLE `funding_pool` DISABLE KEYS */;
INSERT INTO `funding_pool` VALUES (1,'进货资金池','',0.00,8240.40,-8240.40,'A','2018-02-09 00:00:00'),(2,'销售资金池','',3331.00,2621.00,710.00,'A','2018-02-09 00:00:00'),(3,'其它花费资金池','',0.00,50.00,-50.00,'A','2018-02-09 00:00:00');
/*!40000 ALTER TABLE `funding_pool` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod`
--

DROP TABLE IF EXISTS `prod`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prod` (
  `prod_id` int(11) NOT NULL AUTO_INCREMENT,
  `prod_name` varchar(45) DEFAULT NULL,
  `jiuzhuang` varchar(45) DEFAULT NULL,
  `xilie` varchar(45) DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  PRIMARY KEY (`prod_id`),
  UNIQUE KEY `prod_id_UNIQUE` (`prod_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod`
--

LOCK TABLES `prod` WRITE;
/*!40000 ALTER TABLE `prod` DISABLE KEYS */;
INSERT INTO `prod` VALUES (1,'江小白','ahaha','sdfdsf',NULL,'2018-02-09 00:00:00'),(4,'蒙古王','ahaha','sdfdsf',NULL,'2018-02-09 00:00:00'),(8,'草原白','哈哈','嘻嘻','爱上对方大事','2018-02-15 09:55:05'),(9,'牛栏山','啥的','定到','大师傅士大夫','2018-02-17 12:02:36');
/*!40000 ALTER TABLE `prod` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prod_his`
--

DROP TABLE IF EXISTS `prod_his`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prod_his` (
  `prod_id` int(11) NOT NULL DEFAULT '0',
  `prod_name` varchar(45) DEFAULT NULL,
  `jiuzhuang` varchar(45) DEFAULT NULL,
  `xilie` varchar(45) DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `del_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prod_his`
--

LOCK TABLES `prod_his` WRITE;
/*!40000 ALTER TABLE `prod_his` DISABLE KEYS */;
INSERT INTO `prod_his` VALUES (2,'测试红酒1','久久酒庄','胜利呀',NULL,'2018-02-09 00:00:00','2018-02-14 10:56:06'),(7,'河套老窖','haha','xixi','是打发史蒂夫','2018-02-14 00:00:00','2018-02-14 11:57:47'),(5,'汾酒','士大夫','dd',NULL,'2018-02-13 00:00:00','2018-02-17 12:47:43'),(10,'海之蓝','哈哈','QQ','哈哈哈哈','2018-02-22 14:24:30','2018-02-22 14:24:42'),(3,'白酒','哈哈酒庄','咦嘻嘻',NULL,'2018-02-09 00:00:00','2018-02-22 15:13:23');
/*!40000 ALTER TABLE `prod_his` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_trade`
--

DROP TABLE IF EXISTS `sale_trade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sale_trade` (
  `sale_trade_id` int(11) NOT NULL AUTO_INCREMENT,
  `trade_name` varchar(45) DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL,
  `trade_time` datetime DEFAULT NULL,
  `prod_id` int(11) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `unit_price` decimal(10,2) DEFAULT NULL,
  `trade_user_id` varchar(45) DEFAULT NULL,
  `developer_info` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`sale_trade_id`),
  UNIQUE KEY `sale_trade_id_UNIQUE` (`sale_trade_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_trade`
--

LOCK TABLES `sale_trade` WRITE;
/*!40000 ALTER TABLE `sale_trade` DISABLE KEYS */;
INSERT INTO `sale_trade` VALUES (1,'test_trade','testremark','2018-02-12 00:00:00',1,5,60.50,'18647106104','测试发展人'),(2,'的萨法的说法','时代风格','2018-02-12 00:00:00',1,100,100.00,'18647106104','是否打工'),(3,'ASDFADSF ','DSAF ','2018-02-12 00:00:00',3,5,100.00,'18647106104','ASDFADSFDSAFASDF'),(4,'ASDFADSF ','DSAF ','2018-02-12 00:00:00',3,5,100.00,'18647106104','ASDFADSFDSAFASDF'),(5,'爱上对方的身份对萨法','时代风格豆腐干','2018-02-12 00:00:00',1,10,200.00,'18647106104','十分感动分公司'),(6,'对对对','讽德诵功','2018-02-15 09:55:55',8,6,60.00,'18647106104','法规规范方法'),(7,'泥煤','泥煤','2018-02-22 15:12:40',3,2,100.00,'18647106104','泥煤'),(8,'吧','好','2018-02-22 15:14:46',1,1,100.00,'18647106104','好'),(9,'的','iucn','2018-02-22 15:15:43',1,1,100.00,'18647106104','u'),(10,'的','iucn','2018-02-22 15:17:05',1,1,100.00,'18647106104','u'),(11,'的','iucn','2018-02-22 15:18:15',1,1,100.00,'18647106104','u'),(12,'好','s','2018-02-22 15:19:53',1,1,100.00,'18647106104','s'),(13,'a','a','2018-02-22 15:26:06',1,1,150.00,'18647106104','a');
/*!40000 ALTER TABLE `sale_trade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sale_trade_item`
--

DROP TABLE IF EXISTS `sale_trade_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sale_trade_item` (
  `sale_trade_item_id` int(11) NOT NULL AUTO_INCREMENT,
  `sale_trade_id` int(11) DEFAULT NULL,
  `prod_id` int(11) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `unit_price` decimal(10,2) DEFAULT NULL,
  `remark` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`sale_trade_item_id`),
  UNIQUE KEY `sale_trade_item_id_UNIQUE` (`sale_trade_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sale_trade_item`
--

LOCK TABLES `sale_trade_item` WRITE;
/*!40000 ALTER TABLE `sale_trade_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `sale_trade_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock` (
  `stock_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  PRIMARY KEY (`stock_id`),
  UNIQUE KEY `stock_id_UNIQUE` (`stock_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock`
--

LOCK TABLES `stock` WRITE;
/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
INSERT INTO `stock` VALUES (1,1,32,'testremark','2018-02-11 00:00:00'),(2,3,0,'是个负担','2018-02-12 00:00:00'),(3,4,50,'士大夫','2018-02-13 00:00:00'),(4,8,6,'爱上对方撒旦法','2018-02-15 09:55:30'),(5,9,124,'士大夫','2018-02-17 12:03:56');
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_change_log`
--

DROP TABLE IF EXISTS `stock_change_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock_change_log` (
  `stock_change_log_id` int(11) NOT NULL AUTO_INCREMENT,
  `prod_id` int(11) DEFAULT NULL,
  `change_num` int(11) DEFAULT NULL,
  `change_type` varchar(45) DEFAULT NULL,
  `trade_id` varchar(45) DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL,
  `change_user_id` varchar(45) DEFAULT NULL,
  `change_time` date DEFAULT NULL,
  PRIMARY KEY (`stock_change_log_id`),
  UNIQUE KEY `stock_change_log_id_UNIQUE` (`stock_change_log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_change_log`
--

LOCK TABLES `stock_change_log` WRITE;
/*!40000 ALTER TABLE `stock_change_log` DISABLE KEYS */;
INSERT INTO `stock_change_log` VALUES (1,1,23,'商品入库',NULL,'testremark','1','2018-02-12'),(2,1,23,'商品入库',NULL,'testremark','1','2018-02-12'),(3,1,5,'商品销售',NULL,'testremark','1','2018-02-12'),(4,3,12,'商品入库',NULL,'是个负担','1','2018-02-12'),(5,1,100,'商品销售',NULL,'时代风格','1','2018-02-12'),(6,1,50,'商品入库',NULL,'的萨法的说法的说法','1','2018-02-12'),(7,3,5,'商品销售',NULL,'DSAF ','1','2018-02-12'),(8,3,5,'商品销售',NULL,'DSAF ','1','2018-02-12'),(9,1,10,'商品销售',NULL,'时代风格豆腐干','1','2018-02-12'),(10,4,50,'商品入库',NULL,'士大夫','1','2018-02-13'),(11,1,11,'商品入库',NULL,'ASDFDASF','1','2018-02-13'),(12,8,12,'商品入库',NULL,'爱上对方撒旦法','18647106104','2018-02-15'),(13,8,6,'商品销售',NULL,'讽德诵功','18647106104','2018-02-15'),(14,9,24,'商品入库',NULL,'士大夫','18647106104','2018-02-17'),(15,1,-1,'商品销售',NULL,'iucn','18647106104','2018-02-22'),(16,1,-1,'商品销售',NULL,'s','18647106104','2018-02-22'),(17,1,-1,'商品销售',NULL,'a','18647106104','2018-02-22'),(18,9,100,'商品入库',NULL,'a','18647106104','2018-02-22');
/*!40000 ALTER TABLE `stock_change_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_trade`
--

DROP TABLE IF EXISTS `stock_trade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock_trade` (
  `stock_trade_id` int(11) NOT NULL AUTO_INCREMENT,
  `trade_name` varchar(45) DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL,
  `trade_time` datetime DEFAULT NULL,
  `prod_id` int(11) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `unit_price` decimal(10,2) DEFAULT NULL,
  `trade_user_id` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`stock_trade_id`),
  UNIQUE KEY `stock_trade_id_UNIQUE` (`stock_trade_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_trade`
--

LOCK TABLES `stock_trade` WRITE;
/*!40000 ALTER TABLE `stock_trade` DISABLE KEYS */;
INSERT INTO `stock_trade` VALUES (1,'test_trade','testremark','2018-02-11 00:00:00',1,23,33.40,'18647106104'),(2,'test_trade','testremark','2018-02-12 00:00:00',1,23,33.40,'18647106104'),(3,'爱上对方撒旦法','是个负担','2018-02-12 00:00:00',3,12,80.00,'18647106104'),(4,'三大发生的','的萨法的说法的说法','2018-02-12 00:00:00',1,50,50.00,'18647106104'),(5,'dsf爱的色放','士大夫','2018-02-13 00:00:00',4,50,60.00,'18647106104'),(6,'ASDF1111','ASDFDASF','2018-02-13 00:00:00',1,11,11.00,'18647106104'),(7,'爱上对方的沙发上','爱上对方撒旦法','2018-02-15 09:55:29',8,12,30.00,'18647106104'),(8,'撒旦发射点发','士大夫','2018-02-17 12:03:56',9,24,16.00,'18647106104'),(9,'x','a','2018-02-22 15:26:58',9,100,20.00,'18647106104');
/*!40000 ALTER TABLE `stock_trade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock_trade_item`
--

DROP TABLE IF EXISTS `stock_trade_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stock_trade_item` (
  `stock_trade_item_id` int(11) NOT NULL AUTO_INCREMENT,
  `stock_trade_id` int(11) DEFAULT NULL,
  `prod_id` int(11) DEFAULT NULL,
  `num` int(11) DEFAULT NULL,
  `unit_price` decimal(10,2) DEFAULT NULL,
  `remark` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`stock_trade_item_id`),
  UNIQUE KEY `stock_trade_item_id_UNIQUE` (`stock_trade_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock_trade_item`
--

LOCK TABLES `stock_trade_item` WRITE;
/*!40000 ALTER TABLE `stock_trade_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock_trade_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_func`
--

DROP TABLE IF EXISTS `sys_func`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_func` (
  `sys_func_id` int(11) NOT NULL AUTO_INCREMENT,
  `sys_func_name` varchar(45) DEFAULT NULL,
  `remark` varchar(45) DEFAULT NULL,
  `create_date` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`sys_func_id`),
  UNIQUE KEY `sys_func_id_UNIQUE` (`sys_func_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_func`
--

LOCK TABLES `sys_func` WRITE;
/*!40000 ALTER TABLE `sys_func` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_func` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role` (
  `sys_role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(45) DEFAULT NULL,
  `sts` varchar(45) DEFAULT NULL,
  `create_date` date DEFAULT NULL,
  PRIMARY KEY (`sys_role_id`),
  UNIQUE KEY `sys_role_id_UNIQUE` (`sys_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user_role` (
  `sys_user_role_id` int(11) NOT NULL AUTO_INCREMENT,
  `sys_role_id` int(11) DEFAULT NULL,
  `sts` varchar(45) DEFAULT NULL,
  `create_date` date DEFAULT NULL,
  PRIMARY KEY (`sys_user_role_id`),
  UNIQUE KEY `sys_user_role_id_UNIQUE` (`sys_user_role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_users`
--

DROP TABLE IF EXISTS `sys_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_users` (
  `sys_user_id` int(11) NOT NULL AUTO_INCREMENT,
  `login_name` varchar(45) DEFAULT NULL,
  `user_name` varchar(45) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `pwd_set_time` datetime DEFAULT NULL,
  `remarks` varchar(500) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `sts` varchar(2) DEFAULT NULL,
  `sts_date` datetime DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  PRIMARY KEY (`sys_user_id`),
  UNIQUE KEY `sys_user_id_UNIQUE` (`sys_user_id`),
  UNIQUE KEY `login_name_UNIQUE` (`login_name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_users`
--

LOCK TABLES `sys_users` WRITE;
/*!40000 ALTER TABLE `sys_users` DISABLE KEYS */;
INSERT INTO `sys_users` VALUES (1,'18647106104','霍佳宾','18647106104','96e79218965eb72c92a549dd5a330112','2018-02-14 00:00:00','',NULL,NULL,NULL,'2018-02-14 15:21:32'),(2,'18647106224','九九','18647106224','96e79218965eb72c92a549dd5a330112','2018-02-14 00:00:00',NULL,NULL,NULL,NULL,'2018-02-14 15:21:32'),(3,'15690915947','皮皮',NULL,'96e79218965eb72c92a549dd5a330112','2018-02-14 15:21:32',NULL,NULL,NULL,NULL,'2018-02-14 15:21:32'),(4,'15174991828','石头',NULL,'96e79218965eb72c92a549dd5a330112','2018-02-14 15:21:32',NULL,NULL,NULL,NULL,'2018-02-14 15:21:32');
/*!40000 ALTER TABLE `sys_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-02-22 15:45:44
