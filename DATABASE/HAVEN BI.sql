CREATE DATABASE  IF NOT EXISTS `CAMBI` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `CAMBI`;
-- MySQL dump 10.13  Distrib 5.6.23, for Win64 (x86_64)
--
-- Host: cammainmetricsdatastore.cgfy3bzwrqdj.us-east-1.rds.amazonaws.com    Database: CAMBI
-- ------------------------------------------------------
-- Server version	5.6.19-log

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
-- Table structure for table `openbook`
--

DROP TABLE IF EXISTS `openbook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `openbook` (
  `id` int(11) NOT NULL,
  `tickDate` datetime(6) NOT NULL,
  `from_currency` int(11) NOT NULL,
  `to_currency` int(11) NOT NULL,
  `exchange_id` int(11) NOT NULL,
  KEY `idx_date` (`tickDate`),
  KEY `idx_exchange_currency_pair` (`exchange_id`,`from_currency`,`to_currency`),
  KEY `idx_id` (`id`) COMMENT 'Index for order by',
  KEY `idx_from_currency` (`from_currency`),
  KEY `idx_to_currency` (`to_currency`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1
/*!50100 PARTITION BY RANGE (to_days(tickDate))
SUBPARTITION BY HASH (id)
SUBPARTITIONS 10
(PARTITION P53 VALUES LESS THAN (735013) ENGINE = InnoDB,
 PARTITION P52 VALUES LESS THAN (735367) ENGINE = InnoDB,
 PARTITION P51 VALUES LESS THAN (735721) ENGINE = InnoDB,
 PARTITION P50 VALUES LESS THAN (735751) ENGINE = InnoDB,
 PARTITION P49 VALUES LESS THAN (735781) ENGINE = InnoDB,
 PARTITION P48 VALUES LESS THAN (735811) ENGINE = InnoDB,
 PARTITION P47 VALUES LESS THAN (735841) ENGINE = InnoDB,
 PARTITION P46 VALUES LESS THAN (735871) ENGINE = InnoDB,
 PARTITION P45 VALUES LESS THAN (735901) ENGINE = InnoDB,
 PARTITION P44 VALUES LESS THAN (735931) ENGINE = InnoDB,
 PARTITION P43 VALUES LESS THAN (735961) ENGINE = InnoDB,
 PARTITION P42 VALUES LESS THAN (735968) ENGINE = InnoDB,
 PARTITION P41 VALUES LESS THAN (735975) ENGINE = InnoDB,
 PARTITION P40 VALUES LESS THAN (735982) ENGINE = InnoDB,
 PARTITION P39 VALUES LESS THAN (735989) ENGINE = InnoDB,
 PARTITION P38 VALUES LESS THAN (735996) ENGINE = InnoDB,
 PARTITION P37 VALUES LESS THAN (736003) ENGINE = InnoDB,
 PARTITION P36 VALUES LESS THAN (736010) ENGINE = InnoDB,
 PARTITION P35 VALUES LESS THAN (736017) ENGINE = InnoDB,
 PARTITION P34 VALUES LESS THAN (736024) ENGINE = InnoDB,
 PARTITION P33 VALUES LESS THAN (736031) ENGINE = InnoDB,
 PARTITION P32 VALUES LESS THAN (736038) ENGINE = InnoDB,
 PARTITION P31 VALUES LESS THAN (736045) ENGINE = InnoDB,
 PARTITION P30 VALUES LESS THAN (736046) ENGINE = InnoDB,
 PARTITION P29 VALUES LESS THAN (736047) ENGINE = InnoDB,
 PARTITION P28 VALUES LESS THAN (736048) ENGINE = InnoDB,
 PARTITION P27 VALUES LESS THAN (736049) ENGINE = InnoDB,
 PARTITION P26 VALUES LESS THAN (736050) ENGINE = InnoDB,
 PARTITION P25 VALUES LESS THAN (736051) ENGINE = InnoDB,
 PARTITION P24 VALUES LESS THAN (736052) ENGINE = InnoDB,
 PARTITION P23 VALUES LESS THAN (736053) ENGINE = InnoDB,
 PARTITION P22 VALUES LESS THAN (736054) ENGINE = InnoDB,
 PARTITION P21 VALUES LESS THAN (736055) ENGINE = InnoDB,
 PARTITION P20 VALUES LESS THAN (736056) ENGINE = InnoDB,
 PARTITION P19 VALUES LESS THAN (736057) ENGINE = InnoDB,
 PARTITION P18 VALUES LESS THAN (736058) ENGINE = InnoDB,
 PARTITION P17 VALUES LESS THAN (736059) ENGINE = InnoDB,
 PARTITION P16 VALUES LESS THAN (736060) ENGINE = InnoDB,
 PARTITION P15 VALUES LESS THAN (736061) ENGINE = InnoDB,
 PARTITION P14 VALUES LESS THAN (736062) ENGINE = InnoDB,
 PARTITION P13 VALUES LESS THAN (736063) ENGINE = InnoDB,
 PARTITION P12 VALUES LESS THAN (736064) ENGINE = InnoDB,
 PARTITION P11 VALUES LESS THAN (736065) ENGINE = InnoDB,
 PARTITION P10 VALUES LESS THAN (736066) ENGINE = InnoDB,
 PARTITION P9 VALUES LESS THAN (736067) ENGINE = InnoDB,
 PARTITION P8 VALUES LESS THAN (736068) ENGINE = InnoDB,
 PARTITION P7 VALUES LESS THAN (736069) ENGINE = InnoDB,
 PARTITION P6 VALUES LESS THAN (736070) ENGINE = InnoDB,
 PARTITION P5 VALUES LESS THAN (736071) ENGINE = InnoDB,
 PARTITION P4 VALUES LESS THAN (736072) ENGINE = InnoDB,
 PARTITION P3 VALUES LESS THAN (736073) ENGINE = InnoDB,
 PARTITION P2 VALUES LESS THAN (736074) ENGINE = InnoDB,
 PARTITION P1 VALUES LESS THAN (736075) ENGINE = InnoDB,
 PARTITION P0 VALUES LESS THAN MAXVALUE ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `openbook_detail`
--

DROP TABLE IF EXISTS `openbook_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `openbook_detail` (
  `detail_id` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `type` tinyint(1) NOT NULL COMMENT 'ASK = 0 BID = 1',
  `price` decimal(16,8) NOT NULL,
  `amount` decimal(16,8) NOT NULL,
  KEY `idx_id` (`id`),
  KEY `idx_id_detail` (`id`,`detail_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1
/*!50100 PARTITION BY LIST (detail_id)
SUBPARTITION BY HASH (type)
SUBPARTITIONS 2
(PARTITION p200 VALUES IN (200) ENGINE = InnoDB,
 PARTITION p199 VALUES IN (199) ENGINE = InnoDB,
 PARTITION p198 VALUES IN (198) ENGINE = InnoDB,
 PARTITION p197 VALUES IN (197) ENGINE = InnoDB,
 PARTITION p196 VALUES IN (196) ENGINE = InnoDB,
 PARTITION p195 VALUES IN (195) ENGINE = InnoDB,
 PARTITION p194 VALUES IN (194) ENGINE = InnoDB,
 PARTITION p193 VALUES IN (193) ENGINE = InnoDB,
 PARTITION p192 VALUES IN (192) ENGINE = InnoDB,
 PARTITION p191 VALUES IN (191) ENGINE = InnoDB,
 PARTITION p190 VALUES IN (190) ENGINE = InnoDB,
 PARTITION p189 VALUES IN (189) ENGINE = InnoDB,
 PARTITION p188 VALUES IN (188) ENGINE = InnoDB,
 PARTITION p187 VALUES IN (187) ENGINE = InnoDB,
 PARTITION p186 VALUES IN (186) ENGINE = InnoDB,
 PARTITION p185 VALUES IN (185) ENGINE = InnoDB,
 PARTITION p184 VALUES IN (184) ENGINE = InnoDB,
 PARTITION p183 VALUES IN (183) ENGINE = InnoDB,
 PARTITION p182 VALUES IN (182) ENGINE = InnoDB,
 PARTITION p181 VALUES IN (181) ENGINE = InnoDB,
 PARTITION p180 VALUES IN (180) ENGINE = InnoDB,
 PARTITION p179 VALUES IN (179) ENGINE = InnoDB,
 PARTITION p178 VALUES IN (178) ENGINE = InnoDB,
 PARTITION p177 VALUES IN (177) ENGINE = InnoDB,
 PARTITION p176 VALUES IN (176) ENGINE = InnoDB,
 PARTITION p175 VALUES IN (175) ENGINE = InnoDB,
 PARTITION p174 VALUES IN (174) ENGINE = InnoDB,
 PARTITION p173 VALUES IN (173) ENGINE = InnoDB,
 PARTITION p172 VALUES IN (172) ENGINE = InnoDB,
 PARTITION p171 VALUES IN (171) ENGINE = InnoDB,
 PARTITION p170 VALUES IN (170) ENGINE = InnoDB,
 PARTITION p169 VALUES IN (169) ENGINE = InnoDB,
 PARTITION p168 VALUES IN (168) ENGINE = InnoDB,
 PARTITION p167 VALUES IN (167) ENGINE = InnoDB,
 PARTITION p166 VALUES IN (166) ENGINE = InnoDB,
 PARTITION p165 VALUES IN (165) ENGINE = InnoDB,
 PARTITION p164 VALUES IN (164) ENGINE = InnoDB,
 PARTITION p163 VALUES IN (163) ENGINE = InnoDB,
 PARTITION p162 VALUES IN (162) ENGINE = InnoDB,
 PARTITION p161 VALUES IN (161) ENGINE = InnoDB,
 PARTITION p160 VALUES IN (160) ENGINE = InnoDB,
 PARTITION p159 VALUES IN (159) ENGINE = InnoDB,
 PARTITION p158 VALUES IN (158) ENGINE = InnoDB,
 PARTITION p157 VALUES IN (157) ENGINE = InnoDB,
 PARTITION p156 VALUES IN (156) ENGINE = InnoDB,
 PARTITION p155 VALUES IN (155) ENGINE = InnoDB,
 PARTITION p154 VALUES IN (154) ENGINE = InnoDB,
 PARTITION p153 VALUES IN (153) ENGINE = InnoDB,
 PARTITION p152 VALUES IN (152) ENGINE = InnoDB,
 PARTITION p151 VALUES IN (151) ENGINE = InnoDB,
 PARTITION p150 VALUES IN (150) ENGINE = InnoDB,
 PARTITION p149 VALUES IN (149) ENGINE = InnoDB,
 PARTITION p148 VALUES IN (148) ENGINE = InnoDB,
 PARTITION p147 VALUES IN (147) ENGINE = InnoDB,
 PARTITION p146 VALUES IN (146) ENGINE = InnoDB,
 PARTITION p145 VALUES IN (145) ENGINE = InnoDB,
 PARTITION p144 VALUES IN (144) ENGINE = InnoDB,
 PARTITION p143 VALUES IN (143) ENGINE = InnoDB,
 PARTITION p142 VALUES IN (142) ENGINE = InnoDB,
 PARTITION p141 VALUES IN (141) ENGINE = InnoDB,
 PARTITION p140 VALUES IN (140) ENGINE = InnoDB,
 PARTITION p139 VALUES IN (139) ENGINE = InnoDB,
 PARTITION p138 VALUES IN (138) ENGINE = InnoDB,
 PARTITION p137 VALUES IN (137) ENGINE = InnoDB,
 PARTITION p136 VALUES IN (136) ENGINE = InnoDB,
 PARTITION p135 VALUES IN (135) ENGINE = InnoDB,
 PARTITION p134 VALUES IN (134) ENGINE = InnoDB,
 PARTITION p133 VALUES IN (133) ENGINE = InnoDB,
 PARTITION p132 VALUES IN (132) ENGINE = InnoDB,
 PARTITION p131 VALUES IN (131) ENGINE = InnoDB,
 PARTITION p130 VALUES IN (130) ENGINE = InnoDB,
 PARTITION p129 VALUES IN (129) ENGINE = InnoDB,
 PARTITION p128 VALUES IN (128) ENGINE = InnoDB,
 PARTITION p127 VALUES IN (127) ENGINE = InnoDB,
 PARTITION p126 VALUES IN (126) ENGINE = InnoDB,
 PARTITION p125 VALUES IN (125) ENGINE = InnoDB,
 PARTITION p124 VALUES IN (124) ENGINE = InnoDB,
 PARTITION p123 VALUES IN (123) ENGINE = InnoDB,
 PARTITION p122 VALUES IN (122) ENGINE = InnoDB,
 PARTITION p121 VALUES IN (121) ENGINE = InnoDB,
 PARTITION p120 VALUES IN (120) ENGINE = InnoDB,
 PARTITION p119 VALUES IN (119) ENGINE = InnoDB,
 PARTITION p118 VALUES IN (118) ENGINE = InnoDB,
 PARTITION p117 VALUES IN (117) ENGINE = InnoDB,
 PARTITION p116 VALUES IN (116) ENGINE = InnoDB,
 PARTITION p115 VALUES IN (115) ENGINE = InnoDB,
 PARTITION p114 VALUES IN (114) ENGINE = InnoDB,
 PARTITION p113 VALUES IN (113) ENGINE = InnoDB,
 PARTITION p112 VALUES IN (112) ENGINE = InnoDB,
 PARTITION p111 VALUES IN (111) ENGINE = InnoDB,
 PARTITION p110 VALUES IN (110) ENGINE = InnoDB,
 PARTITION p109 VALUES IN (109) ENGINE = InnoDB,
 PARTITION p108 VALUES IN (108) ENGINE = InnoDB,
 PARTITION p107 VALUES IN (107) ENGINE = InnoDB,
 PARTITION p106 VALUES IN (106) ENGINE = InnoDB,
 PARTITION p105 VALUES IN (105) ENGINE = InnoDB,
 PARTITION p104 VALUES IN (104) ENGINE = InnoDB,
 PARTITION p103 VALUES IN (103) ENGINE = InnoDB,
 PARTITION p102 VALUES IN (102) ENGINE = InnoDB,
 PARTITION p101 VALUES IN (101) ENGINE = InnoDB,
 PARTITION p100 VALUES IN (100) ENGINE = InnoDB,
 PARTITION p99 VALUES IN (99) ENGINE = InnoDB,
 PARTITION p98 VALUES IN (98) ENGINE = InnoDB,
 PARTITION p97 VALUES IN (97) ENGINE = InnoDB,
 PARTITION p96 VALUES IN (96) ENGINE = InnoDB,
 PARTITION p95 VALUES IN (95) ENGINE = InnoDB,
 PARTITION p94 VALUES IN (94) ENGINE = InnoDB,
 PARTITION p93 VALUES IN (93) ENGINE = InnoDB,
 PARTITION p92 VALUES IN (92) ENGINE = InnoDB,
 PARTITION p91 VALUES IN (91) ENGINE = InnoDB,
 PARTITION p90 VALUES IN (90) ENGINE = InnoDB,
 PARTITION p89 VALUES IN (89) ENGINE = InnoDB,
 PARTITION p88 VALUES IN (88) ENGINE = InnoDB,
 PARTITION p87 VALUES IN (87) ENGINE = InnoDB,
 PARTITION p86 VALUES IN (86) ENGINE = InnoDB,
 PARTITION p85 VALUES IN (85) ENGINE = InnoDB,
 PARTITION p84 VALUES IN (84) ENGINE = InnoDB,
 PARTITION p83 VALUES IN (83) ENGINE = InnoDB,
 PARTITION p82 VALUES IN (82) ENGINE = InnoDB,
 PARTITION p81 VALUES IN (81) ENGINE = InnoDB,
 PARTITION p80 VALUES IN (80) ENGINE = InnoDB,
 PARTITION p79 VALUES IN (79) ENGINE = InnoDB,
 PARTITION p78 VALUES IN (78) ENGINE = InnoDB,
 PARTITION p77 VALUES IN (77) ENGINE = InnoDB,
 PARTITION p76 VALUES IN (76) ENGINE = InnoDB,
 PARTITION p75 VALUES IN (75) ENGINE = InnoDB,
 PARTITION p74 VALUES IN (74) ENGINE = InnoDB,
 PARTITION p73 VALUES IN (73) ENGINE = InnoDB,
 PARTITION p72 VALUES IN (72) ENGINE = InnoDB,
 PARTITION p71 VALUES IN (71) ENGINE = InnoDB,
 PARTITION p70 VALUES IN (70) ENGINE = InnoDB,
 PARTITION p69 VALUES IN (69) ENGINE = InnoDB,
 PARTITION p68 VALUES IN (68) ENGINE = InnoDB,
 PARTITION p67 VALUES IN (67) ENGINE = InnoDB,
 PARTITION p66 VALUES IN (66) ENGINE = InnoDB,
 PARTITION p65 VALUES IN (65) ENGINE = InnoDB,
 PARTITION p64 VALUES IN (64) ENGINE = InnoDB,
 PARTITION p63 VALUES IN (63) ENGINE = InnoDB,
 PARTITION p62 VALUES IN (62) ENGINE = InnoDB,
 PARTITION p61 VALUES IN (61) ENGINE = InnoDB,
 PARTITION p60 VALUES IN (60) ENGINE = InnoDB,
 PARTITION p59 VALUES IN (59) ENGINE = InnoDB,
 PARTITION p58 VALUES IN (58) ENGINE = InnoDB,
 PARTITION p57 VALUES IN (57) ENGINE = InnoDB,
 PARTITION p56 VALUES IN (56) ENGINE = InnoDB,
 PARTITION p55 VALUES IN (55) ENGINE = InnoDB,
 PARTITION p54 VALUES IN (54) ENGINE = InnoDB,
 PARTITION p53 VALUES IN (53) ENGINE = InnoDB,
 PARTITION p52 VALUES IN (52) ENGINE = InnoDB,
 PARTITION p51 VALUES IN (51) ENGINE = InnoDB,
 PARTITION p50 VALUES IN (50) ENGINE = InnoDB,
 PARTITION p49 VALUES IN (49) ENGINE = InnoDB,
 PARTITION p48 VALUES IN (48) ENGINE = InnoDB,
 PARTITION p47 VALUES IN (47) ENGINE = InnoDB,
 PARTITION p46 VALUES IN (46) ENGINE = InnoDB,
 PARTITION p45 VALUES IN (45) ENGINE = InnoDB,
 PARTITION p44 VALUES IN (44) ENGINE = InnoDB,
 PARTITION p43 VALUES IN (43) ENGINE = InnoDB,
 PARTITION p42 VALUES IN (42) ENGINE = InnoDB,
 PARTITION p41 VALUES IN (41) ENGINE = InnoDB,
 PARTITION p40 VALUES IN (40) ENGINE = InnoDB,
 PARTITION p39 VALUES IN (39) ENGINE = InnoDB,
 PARTITION p38 VALUES IN (38) ENGINE = InnoDB,
 PARTITION p37 VALUES IN (37) ENGINE = InnoDB,
 PARTITION p36 VALUES IN (36) ENGINE = InnoDB,
 PARTITION p35 VALUES IN (35) ENGINE = InnoDB,
 PARTITION p34 VALUES IN (34) ENGINE = InnoDB,
 PARTITION p33 VALUES IN (33) ENGINE = InnoDB,
 PARTITION p32 VALUES IN (32) ENGINE = InnoDB,
 PARTITION p31 VALUES IN (31) ENGINE = InnoDB,
 PARTITION p30 VALUES IN (30) ENGINE = InnoDB,
 PARTITION p29 VALUES IN (29) ENGINE = InnoDB,
 PARTITION p28 VALUES IN (28) ENGINE = InnoDB,
 PARTITION p27 VALUES IN (27) ENGINE = InnoDB,
 PARTITION p26 VALUES IN (26) ENGINE = InnoDB,
 PARTITION p25 VALUES IN (25) ENGINE = InnoDB,
 PARTITION p24 VALUES IN (24) ENGINE = InnoDB,
 PARTITION p23 VALUES IN (23) ENGINE = InnoDB,
 PARTITION p22 VALUES IN (22) ENGINE = InnoDB,
 PARTITION p21 VALUES IN (21) ENGINE = InnoDB,
 PARTITION p20 VALUES IN (20) ENGINE = InnoDB,
 PARTITION p19 VALUES IN (19) ENGINE = InnoDB,
 PARTITION p18 VALUES IN (18) ENGINE = InnoDB,
 PARTITION p17 VALUES IN (17) ENGINE = InnoDB,
 PARTITION p16 VALUES IN (16) ENGINE = InnoDB,
 PARTITION p15 VALUES IN (15) ENGINE = InnoDB,
 PARTITION p14 VALUES IN (14) ENGINE = InnoDB,
 PARTITION p13 VALUES IN (13) ENGINE = InnoDB,
 PARTITION p12 VALUES IN (12) ENGINE = InnoDB,
 PARTITION p11 VALUES IN (11) ENGINE = InnoDB,
 PARTITION p10 VALUES IN (10) ENGINE = InnoDB,
 PARTITION p9 VALUES IN (9) ENGINE = InnoDB,
 PARTITION p8 VALUES IN (8) ENGINE = InnoDB,
 PARTITION p7 VALUES IN (7) ENGINE = InnoDB,
 PARTITION p6 VALUES IN (6) ENGINE = InnoDB,
 PARTITION p5 VALUES IN (5) ENGINE = InnoDB,
 PARTITION p4 VALUES IN (4) ENGINE = InnoDB,
 PARTITION p3 VALUES IN (3) ENGINE = InnoDB,
 PARTITION p2 VALUES IN (2) ENGINE = InnoDB,
 PARTITION p1 VALUES IN (1) ENGINE = InnoDB,
 PARTITION p0 VALUES IN (0) ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `simple_log`
--

DROP TABLE IF EXISTS `simple_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `simple_log` (
  `date` datetime NOT NULL,
  `log` varchar(500) NOT NULL,
  `type` varchar(45) DEFAULT NULL,
  `module` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `trade`
--

DROP TABLE IF EXISTS `trade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trade` (
  `trade_id` int(11) NOT NULL DEFAULT '1',
  `tickDate` datetime NOT NULL,
  `exchange_id` int(11) NOT NULL,
  `from_currency` int(11) NOT NULL,
  `to_currency` int(11) NOT NULL,
  `volume` decimal(16,8) NOT NULL,
  `price` decimal(16,8) NOT NULL,
  `type` tinyint(4) NOT NULL COMMENT 'type :\n\n0 sell\n1 buy',
  `refid` varchar(150) DEFAULT NULL,
  KEY `idx_trade_tick` (`tickDate`),
  KEY `idx_trade_pair_id` (`exchange_id`,`from_currency`,`to_currency`),
  KEY `idx_trade_exchange_id` (`exchange_id`),
  KEY `idx_trade_id` (`trade_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1
/*!50100 PARTITION BY RANGE (to_days(tickDate))
SUBPARTITION BY LINEAR HASH (trade_id)
SUBPARTITIONS 10
(PARTITION P53 VALUES LESS THAN (735013) ENGINE = InnoDB,
 PARTITION P52 VALUES LESS THAN (735367) ENGINE = InnoDB,
 PARTITION P51 VALUES LESS THAN (735721) ENGINE = InnoDB,
 PARTITION P50 VALUES LESS THAN (735751) ENGINE = InnoDB,
 PARTITION P49 VALUES LESS THAN (735781) ENGINE = InnoDB,
 PARTITION P48 VALUES LESS THAN (735811) ENGINE = InnoDB,
 PARTITION P47 VALUES LESS THAN (735841) ENGINE = InnoDB,
 PARTITION P46 VALUES LESS THAN (735871) ENGINE = InnoDB,
 PARTITION P45 VALUES LESS THAN (735901) ENGINE = InnoDB,
 PARTITION P44 VALUES LESS THAN (735931) ENGINE = InnoDB,
 PARTITION P43 VALUES LESS THAN (735961) ENGINE = InnoDB,
 PARTITION P42 VALUES LESS THAN (735968) ENGINE = InnoDB,
 PARTITION P41 VALUES LESS THAN (735975) ENGINE = InnoDB,
 PARTITION P40 VALUES LESS THAN (735982) ENGINE = InnoDB,
 PARTITION P39 VALUES LESS THAN (735989) ENGINE = InnoDB,
 PARTITION P38 VALUES LESS THAN (735996) ENGINE = InnoDB,
 PARTITION P37 VALUES LESS THAN (736003) ENGINE = InnoDB,
 PARTITION P36 VALUES LESS THAN (736010) ENGINE = InnoDB,
 PARTITION P35 VALUES LESS THAN (736017) ENGINE = InnoDB,
 PARTITION P34 VALUES LESS THAN (736024) ENGINE = InnoDB,
 PARTITION P33 VALUES LESS THAN (736031) ENGINE = InnoDB,
 PARTITION P32 VALUES LESS THAN (736038) ENGINE = InnoDB,
 PARTITION P31 VALUES LESS THAN (736045) ENGINE = InnoDB,
 PARTITION P30 VALUES LESS THAN (736046) ENGINE = InnoDB,
 PARTITION P29 VALUES LESS THAN (736047) ENGINE = InnoDB,
 PARTITION P28 VALUES LESS THAN (736048) ENGINE = InnoDB,
 PARTITION P27 VALUES LESS THAN (736049) ENGINE = InnoDB,
 PARTITION P26 VALUES LESS THAN (736050) ENGINE = InnoDB,
 PARTITION P25 VALUES LESS THAN (736051) ENGINE = InnoDB,
 PARTITION P24 VALUES LESS THAN (736052) ENGINE = InnoDB,
 PARTITION P23 VALUES LESS THAN (736053) ENGINE = InnoDB,
 PARTITION P22 VALUES LESS THAN (736054) ENGINE = InnoDB,
 PARTITION P21 VALUES LESS THAN (736055) ENGINE = InnoDB,
 PARTITION P20 VALUES LESS THAN (736056) ENGINE = InnoDB,
 PARTITION P19 VALUES LESS THAN (736057) ENGINE = InnoDB,
 PARTITION P18 VALUES LESS THAN (736058) ENGINE = InnoDB,
 PARTITION P17 VALUES LESS THAN (736059) ENGINE = InnoDB,
 PARTITION P16 VALUES LESS THAN (736060) ENGINE = InnoDB,
 PARTITION P15 VALUES LESS THAN (736061) ENGINE = InnoDB,
 PARTITION P14 VALUES LESS THAN (736062) ENGINE = InnoDB,
 PARTITION P13 VALUES LESS THAN (736063) ENGINE = InnoDB,
 PARTITION P12 VALUES LESS THAN (736064) ENGINE = InnoDB,
 PARTITION P11 VALUES LESS THAN (736065) ENGINE = InnoDB,
 PARTITION P10 VALUES LESS THAN (736066) ENGINE = InnoDB,
 PARTITION P9 VALUES LESS THAN (736067) ENGINE = InnoDB,
 PARTITION P8 VALUES LESS THAN (736068) ENGINE = InnoDB,
 PARTITION P7 VALUES LESS THAN (736069) ENGINE = InnoDB,
 PARTITION P6 VALUES LESS THAN (736070) ENGINE = InnoDB,
 PARTITION P5 VALUES LESS THAN (736071) ENGINE = InnoDB,
 PARTITION P4 VALUES LESS THAN (736072) ENGINE = InnoDB,
 PARTITION P3 VALUES LESS THAN (736073) ENGINE = InnoDB,
 PARTITION P2 VALUES LESS THAN (736074) ENGINE = InnoDB,
 PARTITION P1 VALUES LESS THAN (736075) ENGINE = InnoDB,
 PARTITION P0 VALUES LESS THAN MAXVALUE ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`cambi`@`%`*/ /*!50003 TRIGGER `CAMBI`.`trade_BEFORE_INSERT` BEFORE INSERT ON `trade` FOR EACH ROW
BEGIN
DECLARE NEXT_ID INT;
SELECT IFNULL(MAX(trade_id),0) + 1 into NEXT_ID from CAMBI.trade;
set NEW.trade_id=NEXT_ID;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'CAMBI'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `OPTIMIZE_OPENBOOK` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'UTC' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`cambi`@`%`*/ /*!50106 EVENT `OPTIMIZE_OPENBOOK` ON SCHEDULE EVERY 1 DAY STARTS '2015-03-28 06:00:00' ON COMPLETION NOT PRESERVE ENABLE COMMENT 'Update partitions from openbooks' DO call CAMBI.OptimizeDatabase ('OPENBOOK') */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `OPTIMIZE_OPENBOOK_DETAIL` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'UTC' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`cambi`@`%`*/ /*!50106 EVENT `OPTIMIZE_OPENBOOK_DETAIL` ON SCHEDULE EVERY 1 DAY STARTS '2015-03-28 06:15:00' ON COMPLETION NOT PRESERVE ENABLE COMMENT 'Update partitions from openbook detail' DO call CAMBI.OptimizeDatabase ('OPENBOOK_DETAIL') */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `OPTIMIZE_TRADE` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'UTC' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`cambi`@`%`*/ /*!50106 EVENT `OPTIMIZE_TRADE` ON SCHEDULE EVERY 1 DAY STARTS '2015-03-28 07:00:00' ON COMPLETION NOT PRESERVE ENABLE COMMENT 'Update partitions from trade' DO call CAMBI.OptimizeDatabase ('TRADE') */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'CAMBI'
--
/*!50003 DROP PROCEDURE IF EXISTS `AddCamTradeRecord` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cambi`@`%` PROCEDURE `AddCamTradeRecord`(
p_trade_id varchar(100),
p_buc_id INT,
p_exchange_id INT,
p_volume_executed DECIMAL(16,8),
p_volume_received DECIMAL(16,8),
p_total_volume DECIMAL(16,8),
p_price DECIMAL(16,8),
p_from_currency INT,
p_to_currency INT,
p_type tinyint,
P_trade_status tinyint,
p_date_created DATETIME(6),
p_date_updated DATETIME(6),
p_date_executed_first DATETIME(6),
p_date_executed_last DATETIME(6),
OUT result varchar(150))
BEGIN

DECLARE EXIT HANDLER FOR SQLEXCEPTION 
	BEGIN
       SET result=CONCAT('ERROR. SQL Exception ocurred. Cam Trade record not inserted: date updated ',p_date_updated);
       
    ROLLBACK; 
    RESIGNAL;
  END;

INSERT INTO `CAMFUNDS`.`private_trade`
(`trade_id`,
`buc_id`,
`exchange_id`,
`volume_executed`,
`volume_received`,
`total_volume`,
`price`,
`from_currency`,
`to_currency`,
`type`,
`trade_status`,
`date_created`,
`date_updated`,
`date_executed_first`,
`date_executed_last`)
VALUES
(
p_trade_id,
p_buc_id,
p_exchange_id,
p_volume_executed,
p_volume_received,
p_total_volume,
p_price,
p_from_currency,
p_to_currency,
p_type,
p_trade_status,
p_date_created,
p_date_updated,
p_date_executed_first,
p_date_executed_last
);

COMMIT;
SET result = CONCAT('SUCCESS:Added trade record for exchange ',p_exchange_id,' buc id: ',p_buc_id, 'trade status: ',p_trade_status,' Date Updated: ',p_date_updated);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddOpenbookRecord` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cambi`@`%` PROCEDURE `AddOpenbookRecord`(
 v_from_currency INT,
 v_to_currency INT,
 v_to_exchange INT,
 v_tickDate varchar(100),
 v_bids varchar(3600), -- max 100 bids(price,amount) per tick
 v_asks varchar(3600),
 OUT result varchar(150)
 )
BEGIN
  -- variables for bid and ask string parsing
 DECLARE v_len int default 0;
 DECLARE v_pos int default 0;
 DECLARE v_lastpos int default 0;
 DECLARE v_detail_id int  default 0;
 DECLARE v_price DECIMAL(16,8);
 DECLARE v_amount DECIMAL(16,8);
 DECLARE v_pair VARCHAR(72);
 DECLARE v_id INT;
 DECLARE warn_flag tinyint default 0;
 DECLARE EXIT HANDLER FOR SQLEXCEPTION 
	BEGIN
       SET result='ERROR. SQL Exception ocurred';
       
    ROLLBACK; 
    RESIGNAL;
  END;
--   calculate the next id 
SELECT 
    IFNULL(MAX(id), 0) + 1
INTO v_id FROM
    CAMBI.openbook;
 
START TRANSACTION;
-- Insert master openbook 
INSERT INTO CAMBI.openbook (id,tickDate,from_currency,to_currency,exchange_id)
values (v_id,cast(v_tickDate as datetime(6)),v_from_currency,v_to_currency,v_to_exchange);

-- v_bids and v_asks format:
-- price;amount|price;amount|....price;amount|

set v_len=length(v_asks);
set v_pos=1;
set v_lastpos=0;
SET v_detail_id=0;


asks:loop
	
    
    if (v_lastpos >=v_len) then
		leave asks;
	end if;
SELECT LOCATE('|', v_asks, v_pos) INTO v_lastpos;
   
   if (v_lastpos=0) then -- validation for bad formed strings
        leave asks;
    end if;
 
SELECT 
    SUBSTRING(v_asks,
        v_pos,
        v_lastpos - v_pos)
INTO v_pair;

set v_pos=v_lastpos+1;
-- given a pair of values extract the price and amout
SELECT 
    SUBSTRING(v_pair,
        1,
        LOCATE(';', v_pair) - 1),
    SUBSTRING(v_pair,
        LOCATE(';', v_pair) + 1,
        LENGTH(v_pair))
INTO v_price , v_amount;


INSERT INTO CAMBI.openbook_detail (detail_id,id,type,price,amount) values(v_detail_id,v_id,0,v_price,v_amount);   
set v_detail_id = v_detail_id + 1;
end loop asks;

-- Initialite the variables to insert bids
set v_len=length(v_bids);
set v_pos=1;
set v_lastpos=0;
SET v_detail_id=0;

bids:loop
	    
    if (v_lastpos >=v_len) then
		leave bids;
	end if;
SELECT LOCATE('|', v_bids, v_pos) INTO v_lastpos;
   
   if (v_lastpos=0) then -- validation for bad formed strings
        leave bids;
    end if;
 
SELECT 
    SUBSTRING(v_bids,
        v_pos,
        v_lastpos - v_pos)
INTO v_pair;

set v_pos=v_lastpos+1;
-- given a pair of values extract the price and amout
SELECT 
    SUBSTRING(v_pair,
        1,
        LOCATE(';', v_pair) - 1),
    SUBSTRING(v_pair,
        LOCATE(';', v_pair) + 1,
        LENGTH(v_pair))
INTO v_price , v_amount;


INSERT INTO CAMBI.openbook_detail (detail_id,id,type,price,amount) values(v_detail_id,v_id,1,v_price,v_amount);   
set v_detail_id = v_detail_id + 1;
end loop bids;
if (v_detail_id = 0) THEN
if warn_flag=0 then
SET RESULT = CONCAT('WARNING 1: 0 BIDS INSERTED');
else
SET RESULT = CONCAT(RESULT,'- WARNING 2: 0 BIDS INSERTED');
end if;
set warn_flag=1;
end if;
COMMIT;

if (warn_flag=0) THEN
SET result = CONCAT('SUCCESS:Added Openbook record with id: ',v_id);
END IF;
 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `AddTradeRecord` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cambi`@`%` PROCEDURE `AddTradeRecord`(
v_tickDate varchar(100),
v_from_currency INT,
v_to_currency INT,
v_exchange_id INT,
v_volume DECIMAL(16,8),
v_price DECIMAL(16,8),
v_type tinyint,
v_ref_id varchar(100),
OUT result varchar(150))
BEGIN

DECLARE EXIT HANDLER FOR SQLEXCEPTION 
	BEGIN
       SET result=CONCAT('ERROR. SQL Exception ocurred. Trade not inserted: ref_id:',v_ref_id);
       
    ROLLBACK; 
    RESIGNAL;
  END;

 
START TRANSACTION;
-- the id is created on beforeinsert trigger
INSERT INTO CAMBI.trade(tickDate,exchange_id,from_currency,to_currency,volume,price,type,refid)
VALUES (cast(v_tickDate as datetime),v_exchange_id,v_from_currency,v_to_currency,v_volume,v_price,v_type,v_ref_id);
COMMIT;
SET result = CONCAT('SUCCESS:Added trade record. ref_id:',ifnull(v_ref_id,'EMPTY'));

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `OptimizeDatabase` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`cambi`@`%` PROCEDURE `OptimizeDatabase`(p_table varchar(100))
BEGIN

DECLARE PARTITION_SEQ INT DEFAULT 53 ; -- the max partitions number
DECLARE TODAY INT DEFAULT TO_DAYS(NOW()); -- days past from year 0
DECLARE PARTITION_THR INT  DEFAULT (TODAY - 1062); -- three  years in the past from today (assuming a week 7 days and month 30 days and year 12 months
DECLARE DML VARCHAR(10000); -- dml output
DECLARE START_TIME DATETIME DEFAULT NOW();
DECLARE ACTUAL_COUNT INT;
if (p_table = 'OPENBOOK') THEN

-- CREATE an alter table DML for openbook that partition the table 
-- day by day from today for 30 days (30 partitions)
-- week by week before 30 days for 3 months (12 partitions)
-- month by month before 30 days + 12 weeks(84 days) days for 8 months (8 PARTITIONS)
-- year by year before the first year for the last 2 years and beyond (2 partitions)
-- Openbook optimization
SET DML='
alter table CAMBI.openbook engine=InnoDB
PARTITION BY RANGE (to_days(tickDate))
SUBPARTITION BY HASH (id)
SUBPARTITIONS 10
( 
';
-- add the partition statements

partition_maker: LOOP
SET DML = CONCAT (DML,'PARTITION P',PARTITION_SEQ,' VALUES LESS THAN (',PARTITION_THR,') ,
    ');
	
    -- calculate the partition threshold based on the sequence number
    if (PARTITION_SEQ >= 52) 
    then
	    SET PARTITION_THR = PARTITION_THR + 354;
	else
       if (PARTITION_SEQ >= 44 and PARTITION_SEQ <=51) 
       then
          SET PARTITION_THR = PARTITION_THR + 30;
		else
			if (PARTITION_SEQ >=32 and PARTITION_SEQ <= 43 )
			then
             SET PARTITION_THR = PARTITION_THR + 7;
             else
				if (PARTITION_SEQ  >= 1 and PARTITION_SEQ <= 31 )
				then
				SET PARTITION_THR = PARTITION_THR + 1;
                end if;
			end if;
        end if;
	 end if;
    
    SET PARTITION_SEQ=PARTITION_SEQ - 1;
    
    
    IF PARTITION_SEQ = 0 THEN
     leave partition_maker;
	END IF;
END LOOP partition_maker;
SET DML = CONCAT ( DML,'PARTITION P0 VALUES LESS THAN (MAXVALUE) ) ');
SET @DML_STMT =DML;
PREPARE MOD_PART FROM @DML_STMT;
EXECUTE MOD_PART;
DEALLOCATE PREPARE MOD_PART;
SELECT 
    COUNT(*)
INTO ACTUAL_COUNT FROM
    CAMBI.OPENBOOK;
ELSEIF (p_table = 'OPENBOOK_DETAIL') THEN
SET PARTITION_SEQ=200;
SET DML=' ALTER TABLE CAMBI.openbook_detail ENGINE=InnoDB
 PARTITION BY LIST (detail_id)
	SUBPARTITION BY HASH (type)
	SUBPARTITIONS 2
	(';
partition_maker: LOOP
    
SET DML = CONCAT(DML,'PARTITION p',PARTITION_SEQ, ' VALUES IN (',PARTITION_SEQ,') ENGINE = InnoDB');

IF (PARTITION_SEQ = 0) THEN
LEAVE partition_maker;
ELSE
SET DML = CONCAT(DML,',');
END IF;
SET PARTITION_SEQ = PARTITION_SEQ - 1 ;	

END LOOP partition_maker;

SET DML = CONCAT (DML, ');');

SET @DML_STMT =DML;
SELECT @DML;
PREPARE MOD_PART FROM @DML_STMT;
EXECUTE MOD_PART;
DEALLOCATE PREPARE MOD_PART;
SELECT 
    COUNT(*)
INTO ACTUAL_COUNT FROM
    CAMBI.openbook_detail;
ELSEIF (p_table='TRADE') THEN
-- OPTIMIZE TRADE table
SET PARTITION_SEQ=53;
SET DML='
alter table CAMBI.trade engine=InnoDB
PARTITION BY RANGE (to_days(tickDate))
SUBPARTITION BY LINEAR HASH (trade_id)
SUBPARTITIONS 10
( 
';
-- add the partition statements
partition_maker: LOOP
SET DML = CONCAT (DML,'PARTITION P',PARTITION_SEQ,' VALUES LESS THAN (',PARTITION_THR,') ,
    ');
	
    -- calculate the partition threshold based on the sequence number
    if (PARTITION_SEQ >= 52) 
    then
	    SET PARTITION_THR = PARTITION_THR + 354;
	else
       if (PARTITION_SEQ >= 44 and PARTITION_SEQ <=51) 
       then
          SET PARTITION_THR = PARTITION_THR + 30;
		else
			if (PARTITION_SEQ >=32 and PARTITION_SEQ <= 43 )
			then
             SET PARTITION_THR = PARTITION_THR + 7;
             else
				if (PARTITION_SEQ  >= 1 and PARTITION_SEQ <= 31 )
				then
				SET PARTITION_THR = PARTITION_THR + 1;
                end if;
			end if;
        end if;
	 end if;
     
	
	   
    SET PARTITION_SEQ=PARTITION_SEQ - 1;
    
    
    IF PARTITION_SEQ = 0 THEN
     leave partition_maker;
	END IF;
END LOOP partition_maker;
SET DML = CONCAT ( DML,'PARTITION P0 VALUES LESS THAN (MAXVALUE) ) ');
SET @DML_STMT =DML;

PREPARE MOD_PART FROM @DML_STMT;
EXECUTE MOD_PART;
DEALLOCATE PREPARE MOD_PART;
SELECT 
    COUNT(*)
INTO ACTUAL_COUNT FROM
    CAMBI.trade;
END IF;

SELECT @DML_STMT;
 insert into CAMBI.simple_log VALUES(now(),CONCAT('Partition and Indexes rebuilt. Total rows: ',ACTUAL_COUNT,'. Process started at ',START_TIME),'INFO',p_table);
 COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-04-22 20:00:36
