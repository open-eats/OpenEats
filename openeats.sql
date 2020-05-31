-- MariaDB dump 10.17  Distrib 10.4.12-MariaDB, for debian-linux-gnu (aarch64)
--
-- Host: localhost    Database: openeats
-- ------------------------------------------------------
-- Server version	10.4.12-MariaDB-1:10.4.12+maria~bionic

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can view permission',1,'view_permission'),(5,'Can add group',2,'add_group'),(6,'Can change group',2,'change_group'),(7,'Can delete group',2,'delete_group'),(8,'Can view group',2,'view_group'),(9,'Can add user',3,'add_user'),(10,'Can change user',3,'change_user'),(11,'Can delete user',3,'delete_user'),(12,'Can view user',3,'view_user'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add site',6,'add_site'),(22,'Can change site',6,'change_site'),(23,'Can delete site',6,'delete_site'),(24,'Can view site',6,'view_site'),(25,'Can add log entry',7,'add_logentry'),(26,'Can change log entry',7,'change_logentry'),(27,'Can delete log entry',7,'delete_logentry'),(28,'Can view log entry',7,'view_logentry'),(29,'Can add Token',8,'add_token'),(30,'Can change Token',8,'change_token'),(31,'Can delete Token',8,'delete_token'),(32,'Can view Token',8,'view_token'),(33,'Can add recipe',9,'add_recipe'),(34,'Can change recipe',9,'change_recipe'),(35,'Can delete recipe',9,'delete_recipe'),(36,'Can view recipe',9,'view_recipe'),(37,'Can add sub recipe',10,'add_subrecipe'),(38,'Can change sub recipe',10,'change_subrecipe'),(39,'Can delete sub recipe',10,'delete_subrecipe'),(40,'Can view sub recipe',10,'view_subrecipe'),(41,'Can add course',11,'add_course'),(42,'Can change course',11,'change_course'),(43,'Can delete course',11,'delete_course'),(44,'Can view course',11,'view_course'),(45,'Can add cuisine',12,'add_cuisine'),(46,'Can change cuisine',12,'change_cuisine'),(47,'Can delete cuisine',12,'delete_cuisine'),(48,'Can view cuisine',12,'view_cuisine'),(49,'Can add tag',13,'add_tag'),(50,'Can change tag',13,'change_tag'),(51,'Can delete tag',13,'delete_tag'),(52,'Can view tag',13,'view_tag'),(53,'Can add ingredient',14,'add_ingredient'),(54,'Can change ingredient',14,'change_ingredient'),(55,'Can delete ingredient',14,'delete_ingredient'),(56,'Can view ingredient',14,'view_ingredient'),(57,'Can add ingredient group',15,'add_ingredientgroup'),(58,'Can change ingredient group',15,'change_ingredientgroup'),(59,'Can delete ingredient group',15,'delete_ingredientgroup'),(60,'Can view ingredient group',15,'view_ingredientgroup'),(61,'Can add news',16,'add_news'),(62,'Can change news',16,'change_news'),(63,'Can delete news',16,'delete_news'),(64,'Can view news',16,'view_news'),(65,'Can add grocery item',17,'add_groceryitem'),(66,'Can change grocery item',17,'change_groceryitem'),(67,'Can delete grocery item',17,'delete_groceryitem'),(68,'Can view grocery item',17,'view_groceryitem'),(69,'Can add grocery list',18,'add_grocerylist'),(70,'Can change grocery list',18,'change_grocerylist'),(71,'Can delete grocery list',18,'delete_grocerylist'),(72,'Can view grocery list',18,'view_grocerylist'),(73,'Can add grocery shared',19,'add_groceryshared'),(74,'Can change grocery shared',19,'change_groceryshared'),(75,'Can delete grocery shared',19,'delete_groceryshared'),(76,'Can view grocery shared',19,'view_groceryshared'),(77,'Can add menu item',20,'add_menuitem'),(78,'Can change menu item',20,'change_menuitem'),(79,'Can delete menu item',20,'delete_menuitem'),(80,'Can view menu item',20,'view_menuitem'),(81,'Can add rating',21,'add_rating'),(82,'Can change rating',21,'change_rating'),(83,'Can delete rating',21,'delete_rating'),(84,'Can view rating',21,'view_rating'),(85,'Can add cors model',22,'add_corsmodel'),(86,'Can change cors model',22,'change_corsmodel'),(87,'Can delete cors model',22,'delete_corsmodel'),(88,'Can view cors model',22,'view_corsmodel');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$120000$GOse8ZzqmBkV$XPFtzkbK18LUMcf4ZGM8hyrlXv/8a7XF9gmGdTK5SzM=','2020-05-02 18:42:20.756504',1,'root','','','',1,1,'2020-05-01 21:46:08.142188'),(2,'pbkdf2_sha256$120000$hcHQgXtqmYhz$0iStASyQHEZuhRQ54RNNFxFsXTkgXDoDVmoUNU38AhE=',NULL,0,'Mark','Mark','Höllmann','',0,1,'2020-05-01 22:01:37.000000'),(3,'pbkdf2_sha256$120000$phCYRZmbYjGK$XzlAMM6LJOWZDEDL3I6JAzc8fpoNgs+2QX6pKqbYYqM=',NULL,0,'Elke','','','',0,1,'2020-05-01 22:01:47.000000'),(4,'pbkdf2_sha256$120000$NoxdkQL5yJ1a$WFYQKXxv3kJZWXaUiqw9VMibaO6i+8aFzBd3ZOx6qGY=',NULL,0,'Dana','','','',0,1,'2020-05-01 22:01:55.000000'),(5,'pbkdf2_sha256$120000$fToIz34a4uBJ$gtnsWV2SHNVc4DAWZAdMgyv9L61NFzcppzB5re3+feo=',NULL,0,'Davin','','','',0,1,'2020-05-01 22:02:06.000000'),(6,'pbkdf2_sha256$120000$ihBMxI9ho4qt$/j2coz4uZ2usfnZvdA6rVx+ICQJmMxSqFE0tYu+jWVA=',NULL,0,'Wolfgang','','','',0,1,'2020-05-01 22:02:18.000000'),(7,'pbkdf2_sha256$120000$iSY7FS16fxZO$QJDOdvfQA1TJq7hWXAgG5v/FD5mjTLrKBsABt7LZ+pw=',NULL,0,'Paula','','','',0,1,'2020-05-01 22:11:49.000000'),(8,'pbkdf2_sha256$120000$1TdPUmOnjskj$7jLDnyEbP6opTMtLXwRZaeD1rbvl23fX4vRt/L24X1s=',NULL,0,'Jutta','','','',0,1,'2020-05-01 22:12:16.119284'),(9,'pbkdf2_sha256$120000$utqkbPaaS3gR$Qv9RLPxRg8gFYzE3kAhdquwyyn++1qw+pyPzOxk7nVg=',NULL,0,'Bernd','','','',0,1,'2020-05-01 22:12:56.206991'),(10,'pbkdf2_sha256$120000$Rhr75d6BwziV$B8nIAjLv6j+Y+EVj0a+CtQJGWgEZZUmdo1WGQcldpLU=',NULL,0,'Johannes','','','',0,1,'2020-05-01 22:13:07.229741'),(11,'pbkdf2_sha256$120000$3sWFYMJ1mHhS$093ae2Vu4MCrUjaYHFatak5bRwugvz2ITCvUF1eqZ5s=',NULL,0,'Anton','','','',0,1,'2020-05-01 22:13:15.975136');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authtoken_token`
--

DROP TABLE IF EXISTS `authtoken_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken_token`
--

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2020-05-01 21:56:02.006050','1','Vorspeise',1,'[{\"added\": {}}]',11,1),(2,'2020-05-01 21:56:11.100408','2','Hauptspeise',1,'[{\"added\": {}}]',11,1),(3,'2020-05-01 21:56:20.446724','3','Nachspeise',1,'[{\"added\": {}}]',11,1),(4,'2020-05-01 21:56:28.184715','4','Kuchen',1,'[{\"added\": {}}]',11,1),(5,'2020-05-01 21:56:33.681859','5','Salat',1,'[{\"added\": {}}]',11,1),(6,'2020-05-01 21:56:57.456680','1','deutsch',1,'[{\"added\": {}}]',12,1),(7,'2020-05-01 21:57:05.103127','2','italienisch',1,'[{\"added\": {}}]',12,1),(8,'2020-05-01 21:57:12.801377','3','griechisch',1,'[{\"added\": {}}]',12,1),(9,'2020-05-01 21:57:21.663542','4','französisch',1,'[{\"added\": {}}]',12,1),(10,'2020-05-01 21:57:34.090252','5','asiatisch',1,'[{\"added\": {}}]',12,1),(11,'2020-05-01 21:57:41.135839','6','amerikanisch',1,'[{\"added\": {}}]',12,1),(12,'2020-05-01 21:58:05.847223','6','Getränk',1,'[{\"added\": {}}]',11,1),(13,'2020-05-01 21:58:24.225547','1','vegetarisch',1,'[{\"added\": {}}]',13,1),(14,'2020-05-01 21:58:28.969928','2','vegan',1,'[{\"added\": {}}]',13,1),(15,'2020-05-01 21:58:45.236240','3','Fleisch',1,'[{\"added\": {}}]',13,1),(16,'2020-05-01 21:58:49.607461','4','Fisch',1,'[{\"added\": {}}]',13,1),(17,'2020-05-01 21:59:01.685004','5','Obst',1,'[{\"added\": {}}]',13,1),(18,'2020-05-01 21:59:06.601356','6','Gemüse',1,'[{\"added\": {}}]',13,1),(19,'2020-05-01 21:59:21.860129','7','Beilage',1,'[{\"added\": {}}]',11,1),(20,'2020-05-01 22:01:38.015578','2','mark',1,'[{\"added\": {}}]',3,1),(21,'2020-05-01 22:01:47.360923','3','elke',1,'[{\"added\": {}}]',3,1),(22,'2020-05-01 22:01:56.174107','4','dana',1,'[{\"added\": {}}]',3,1),(23,'2020-05-01 22:02:06.560123','5','davin',1,'[{\"added\": {}}]',3,1),(24,'2020-05-01 22:02:18.488775','6','wolfgang',1,'[{\"added\": {}}]',3,1),(25,'2020-05-01 22:09:48.540408','2','mark',2,'[{\"changed\": {\"fields\": [\"first_name\", \"last_name\"]}}]',3,1),(26,'2020-05-01 22:10:36.283706','2','Mark',2,'[{\"changed\": {\"fields\": [\"username\"]}}]',3,1),(27,'2020-05-01 22:10:55.011402','3','Elke',2,'[{\"changed\": {\"fields\": [\"username\"]}}]',3,1),(28,'2020-05-01 22:11:19.144023','5','Davin',2,'[{\"changed\": {\"fields\": [\"username\"]}}]',3,1),(29,'2020-05-01 22:11:25.487880','4','Dana',2,'[{\"changed\": {\"fields\": [\"username\"]}}]',3,1),(30,'2020-05-01 22:11:35.617689','6','Wolfgang',2,'[{\"changed\": {\"fields\": [\"username\"]}}]',3,1),(31,'2020-05-01 22:11:49.399881','7','Paula',1,'[{\"added\": {}}]',3,1),(32,'2020-05-01 22:12:05.199083','7','Paula',2,'[]',3,1),(33,'2020-05-01 22:12:16.470488','8','Jutta',1,'[{\"added\": {}}]',3,1),(34,'2020-05-01 22:12:56.555938','9','Bernd',1,'[{\"added\": {}}]',3,1),(35,'2020-05-01 22:13:07.582903','10','Johannes',1,'[{\"added\": {}}]',3,1),(36,'2020-05-01 22:13:16.326015','11','Anton',1,'[{\"added\": {}}]',3,1),(37,'2020-05-02 15:50:43.597492','1','DAS ESSEN IST FERTIG!',1,'[{\"added\": {}}]',16,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (7,'admin','logentry'),(2,'auth','group'),(1,'auth','permission'),(3,'auth','user'),(8,'authtoken','token'),(4,'contenttypes','contenttype'),(22,'corsheaders','corsmodel'),(14,'ingredient','ingredient'),(15,'ingredient','ingredientgroup'),(17,'list','groceryitem'),(18,'list','grocerylist'),(19,'list','groceryshared'),(20,'menu','menuitem'),(16,'news','news'),(21,'rating','rating'),(9,'recipe','recipe'),(10,'recipe','subrecipe'),(11,'recipe_groups','course'),(12,'recipe_groups','cuisine'),(13,'recipe_groups','tag'),(5,'sessions','session'),(6,'sites','site');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2020-05-01 21:41:46.017836'),(2,'auth','0001_initial','2020-05-01 21:42:00.099670'),(3,'admin','0001_initial','2020-05-01 21:42:00.646722'),(4,'admin','0002_logentry_remove_auto_add','2020-05-01 21:42:00.698010'),(5,'admin','0003_logentry_add_action_flag_choices','2020-05-01 21:42:00.744263'),(6,'contenttypes','0002_remove_content_type_name','2020-05-01 21:42:00.996710'),(7,'auth','0002_alter_permission_name_max_length','2020-05-01 21:42:01.054863'),(8,'auth','0003_alter_user_email_max_length','2020-05-01 21:42:01.127849'),(9,'auth','0004_alter_user_username_opts','2020-05-01 21:42:01.177332'),(10,'auth','0005_alter_user_last_login_null','2020-05-01 21:42:01.347949'),(11,'auth','0006_require_contenttypes_0002','2020-05-01 21:42:01.362602'),(12,'auth','0007_alter_validators_add_error_messages','2020-05-01 21:42:01.423757'),(13,'auth','0008_alter_user_username_max_length','2020-05-01 21:42:01.495767'),(14,'auth','0009_alter_user_last_name_max_length','2020-05-01 21:42:01.563946'),(15,'authtoken','0001_initial','2020-05-01 21:42:01.902755'),(16,'authtoken','0002_auto_20160226_1747','2020-05-01 21:42:02.278461'),(17,'recipe_groups','0001_initial','2020-05-01 21:42:03.299281'),(18,'recipe','0001_initial','2020-05-01 21:42:06.737605'),(19,'recipe','0002_remove_recipe_directions','2020-05-01 21:42:06.829306'),(20,'recipe','0003_auto_20161111_1122','2020-05-01 21:42:08.309368'),(21,'recipe','0004_auto_20161126_1758','2020-05-01 21:42:08.617500'),(22,'recipe','0005_recipe_source','2020-05-01 21:42:08.719603'),(23,'recipe','0006_auto_20170127_0905','2020-05-01 21:42:08.778208'),(24,'recipe','0007_auto_20170723_2046','2020-05-01 21:42:08.843361'),(25,'ingredient','0001_initial','2020-05-01 21:42:09.195072'),(26,'ingredient','0002_auto_20170127_2104','2020-05-01 21:42:09.269362'),(27,'ingredient','0003_auto_20170723_2050','2020-05-01 21:42:09.946648'),(28,'ingredient','0004_auto_20170723_2101','2020-05-01 21:42:10.050974'),(29,'ingredient','0005_auto_20170725_1950','2020-05-01 21:42:11.179562'),(30,'ingredient','0006_auto_20170725_1951','2020-05-01 21:42:11.764769'),(31,'ingredient','0007_remove_ingredient_recipe','2020-05-01 21:42:11.914692'),(32,'ingredient','0008_auto_20180129_1456','2020-05-01 21:42:12.502869'),(33,'ingredient','0009_auto_20180330_1055','2020-05-01 21:42:12.642870'),(34,'ingredient','0010_auto_20180330_1058','2020-05-01 21:42:12.742524'),(35,'ingredient','0011_auto_20180415_2352','2020-05-01 21:42:12.780482'),(36,'ingredient','0012_remove_ingredient_quantity','2020-05-01 21:42:12.836735'),(37,'list','0001_initial','2020-05-01 21:42:16.109584'),(38,'list','0002_groceryitem_complete','2020-05-01 21:42:16.198832'),(39,'list','0003_auto_20170128_2118','2020-05-01 21:42:16.707227'),(40,'list','0004_auto_20170203_1045','2020-05-01 21:42:17.179056'),(41,'list','0005_auto_20170728_2230','2020-05-01 21:42:17.278415'),(42,'list','0006_auto_20170826_0059','2020-05-01 21:42:17.558248'),(43,'list','0007_auto_20180129_1456','2020-05-01 21:42:25.225823'),(44,'list','0008_auto_20181120_0041','2020-05-01 21:42:25.617560'),(45,'recipe','0008_auto_20170806_2059','2020-05-01 21:42:26.367127'),(46,'recipe','0009_auto_20171114_1443','2020-05-01 21:42:26.830265'),(47,'recipe','0010_auto_20171114_1443','2020-05-01 21:42:26.932574'),(48,'recipe','0011_auto_20171114_1543','2020-05-01 21:42:27.121658'),(49,'recipe','0012_auto_20180106_1113','2020-05-01 21:42:27.309113'),(50,'recipe','0013_auto_20180129_1456','2020-05-01 21:42:29.051396'),(51,'menu','0001_initial','2020-05-01 21:42:30.097479'),(52,'menu','0002_auto_20180210_1817','2020-05-01 21:42:30.391151'),(53,'menu','0003_auto_20180215_1524','2020-05-01 21:42:30.659979'),(54,'menu','0004_remove_menuitem_occurrence','2020-05-01 21:42:30.811498'),(55,'menu','0005_auto_20180219_2237','2020-05-01 21:42:31.282178'),(56,'menu','0006_menuitem_all_day','2020-05-01 21:42:31.396021'),(57,'menu','0007_auto_20180827_2124','2020-05-01 21:42:32.356500'),(58,'menu','0008_auto_20181120_0041','2020-05-01 21:42:32.445118'),(59,'menu','0009_auto_20190301_1353','2020-05-01 21:42:32.574033'),(60,'menu','0010_auto_20190308_1254','2020-05-01 21:42:32.802756'),(61,'news','0001_initial','2020-05-01 21:42:33.894651'),(62,'news','0002_auto_20161125_0846','2020-05-01 21:42:34.064861'),(63,'news','0003_auto_20190301_1353','2020-05-01 21:42:34.091873'),(64,'recipe','0014_auto_20180607_0713','2020-05-01 21:42:34.193797'),(65,'rating','0001_initial','2020-05-01 21:42:34.977073'),(66,'rating','0002_django_data_migration_recipe_to_rating','2020-05-01 21:42:35.094282'),(67,'recipe','0015_remove_recipe_old_rating','2020-05-01 21:42:35.195776'),(68,'recipe','0016_auto_20190301_1230','2020-05-01 21:42:35.391114'),(69,'recipe','0017_auto_20190301_1231','2020-05-01 21:42:35.508241'),(70,'recipe','0018_remove_subrecipe_quantity','2020-05-01 21:42:35.592603'),(71,'recipe_groups','0002_remove_tag_author','2020-05-01 21:42:35.864421'),(72,'recipe_groups','0003_auto_20180129_1456','2020-05-01 21:42:36.528314'),(73,'sessions','0001_initial','2020-05-01 21:42:36.702441'),(74,'sites','0001_initial','2020-05-01 21:42:36.839772'),(75,'sites','0002_alter_domain_unique','2020-05-01 21:42:37.015019');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('b7ga15m8gel8m46adgjf7l9fk14xx305','ZDU5NDkxYTU1OGY3NDA4ZGY4YmE2MWEyYzgwNmZlOTY1YWM0ODY0Mzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyMjQyMzAwNWIzODY0NDkxZDQ0YWEwYWRjNjAxZTNlZDk3YTNiYjFkIn0=','2020-05-15 21:55:12.682317'),('n6d7i68bfrka1hykslrks7h2j47g5ssd','ZDU5NDkxYTU1OGY3NDA4ZGY4YmE2MWEyYzgwNmZlOTY1YWM0ODY0Mzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyMjQyMzAwNWIzODY0NDkxZDQ0YWEwYWRjNjAxZTNlZDk3YTNiYjFkIn0=','2020-05-16 18:42:20.776196');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'example.com','example.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingredient_ingredient`
--

DROP TABLE IF EXISTS `ingredient_ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ingredient_ingredient` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(250) NOT NULL,
  `measurement` varchar(200) DEFAULT NULL,
  `ingredient_group_id` int(11) DEFAULT NULL,
  `denominator` double NOT NULL,
  `numerator` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ingredient_ingredien_ingredient_group_id_42a585aa_fk_ingredien` (`ingredient_group_id`),
  CONSTRAINT `ingredient_ingredien_ingredient_group_id_42a585aa_fk_ingredien` FOREIGN KEY (`ingredient_group_id`) REFERENCES `ingredient_ingredientgroup` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredient_ingredient`
--

LOCK TABLES `ingredient_ingredient` WRITE;
/*!40000 ALTER TABLE `ingredient_ingredient` DISABLE KEYS */;
INSERT INTO `ingredient_ingredient` VALUES (31,'Mehl','g',7,1,250),(32,'Milch','ml',7,1,250),(33,'Sprudelwasser','ml',7,1,250),(34,'Ei',NULL,7,1,0.5),(35,'Salz',NULL,7,1,0);
/*!40000 ALTER TABLE `ingredient_ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingredient_ingredientgroup`
--

DROP TABLE IF EXISTS `ingredient_ingredientgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ingredient_ingredientgroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(150) DEFAULT NULL,
  `recipe_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ingredient_ingredientgroup_title_recipe_id_368426d7_uniq` (`title`,`recipe_id`),
  KEY `ingredient_ingredien_recipe_id_ad054d9e_fk_recipe_re` (`recipe_id`),
  CONSTRAINT `ingredient_ingredien_recipe_id_ad054d9e_fk_recipe_re` FOREIGN KEY (`recipe_id`) REFERENCES `recipe_recipe` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredient_ingredientgroup`
--

LOCK TABLES `ingredient_ingredientgroup` WRITE;
/*!40000 ALTER TABLE `ingredient_ingredientgroup` DISABLE KEYS */;
INSERT INTO `ingredient_ingredientgroup` VALUES (7,'',1);
/*!40000 ALTER TABLE `ingredient_ingredientgroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `list_groceryitem`
--

DROP TABLE IF EXISTS `list_groceryitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `list_groceryitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `list_id` int(11) NOT NULL,
  `completed` tinyint(1) NOT NULL,
  `title` varchar(550) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `list_groceryitem_list_id_391cb674_fk_list_grocerylist_id` (`list_id`),
  CONSTRAINT `list_groceryitem_list_id_391cb674_fk_list_grocerylist_id` FOREIGN KEY (`list_id`) REFERENCES `list_grocerylist` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `list_groceryitem`
--

LOCK TABLES `list_groceryitem` WRITE;
/*!40000 ALTER TABLE `list_groceryitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `list_groceryitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `list_grocerylist`
--

DROP TABLE IF EXISTS `list_grocerylist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `list_grocerylist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(250) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `pub_date` datetime(6) NOT NULL,
  `author_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `list_grocerylist_slug_620f0a87` (`slug`),
  KEY `list_grocerylist_author_id_edd4c434_fk_auth_user_id` (`author_id`),
  CONSTRAINT `list_grocerylist_author_id_edd4c434_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `list_grocerylist`
--

LOCK TABLES `list_grocerylist` WRITE;
/*!40000 ALTER TABLE `list_grocerylist` DISABLE KEYS */;
/*!40000 ALTER TABLE `list_grocerylist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `list_groceryshared`
--

DROP TABLE IF EXISTS `list_groceryshared`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `list_groceryshared` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `list_id` int(11) NOT NULL,
  `shared_by_id` int(11) NOT NULL,
  `shared_to_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `list_groceryshared_list_id_47feb2f7_fk_list_grocerylist_id` (`list_id`),
  KEY `list_groceryshared_shared_by_id_b214e597_fk_auth_user_id` (`shared_by_id`),
  KEY `list_groceryshared_shared_to_id_1d668c2f_fk_auth_user_id` (`shared_to_id`),
  CONSTRAINT `list_groceryshared_list_id_47feb2f7_fk_list_grocerylist_id` FOREIGN KEY (`list_id`) REFERENCES `list_grocerylist` (`id`),
  CONSTRAINT `list_groceryshared_shared_by_id_b214e597_fk_auth_user_id` FOREIGN KEY (`shared_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `list_groceryshared_shared_to_id_1d668c2f_fk_auth_user_id` FOREIGN KEY (`shared_to_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `list_groceryshared`
--

LOCK TABLES `list_groceryshared` WRITE;
/*!40000 ALTER TABLE `list_groceryshared` DISABLE KEYS */;
/*!40000 ALTER TABLE `list_groceryshared` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_menuitem`
--

DROP TABLE IF EXISTS `menu_menuitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_menuitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recipe_id` int(11) NOT NULL,
  `complete_date` datetime(6) DEFAULT NULL,
  `start_date` datetime(6) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  `complete` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `menu_menuitem_recipe_id_7c12dfbd_fk_recipe_recipe_id` (`recipe_id`),
  KEY `menu_menuitem_author_id_2ed2f017_fk_auth_user_id` (`author_id`),
  CONSTRAINT `menu_menuitem_author_id_2ed2f017_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `menu_menuitem_recipe_id_7c12dfbd_fk_recipe_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `recipe_recipe` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_menuitem`
--

LOCK TABLES `menu_menuitem` WRITE;
/*!40000 ALTER TABLE `menu_menuitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `menu_menuitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news_news`
--

DROP TABLE IF EXISTS `news_news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news_news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(191) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `content` longtext NOT NULL,
  `frontpage` tinyint(1) NOT NULL,
  `image` varchar(100) NOT NULL,
  `pub_date` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news_news`
--

LOCK TABLES `news_news` WRITE;
/*!40000 ALTER TABLE `news_news` DISABLE KEYS */;
INSERT INTO `news_news` VALUES (1,'DAS ESSEN IST FERTIG!','das-essen-ist-fertig','zumindest manchmal',1,'','2020-05-02 15:50:43.595443');
/*!40000 ALTER TABLE `news_news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rating_rating`
--

DROP TABLE IF EXISTS `rating_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rating_rating` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment` varchar(250) NOT NULL,
  `rating` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  `recipe_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `rating_rating_author_id_a1fde11d_fk_auth_user_id` (`author_id`),
  KEY `rating_rating_recipe_id_be7cfa06_fk_recipe_recipe_id` (`recipe_id`),
  CONSTRAINT `rating_rating_author_id_a1fde11d_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `rating_rating_recipe_id_be7cfa06_fk_recipe_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `recipe_recipe` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rating_rating`
--

LOCK TABLES `rating_rating` WRITE;
/*!40000 ALTER TABLE `rating_rating` DISABLE KEYS */;
INSERT INTO `rating_rating` VALUES (1,'Immer wieder lecker!',5,2,1);
/*!40000 ALTER TABLE `rating_rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_groups_course`
--

DROP TABLE IF EXISTS `recipe_groups_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipe_groups_course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `author_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  UNIQUE KEY `slug` (`slug`),
  KEY `recipe_groups_course_author_id_e2d6c656_fk_auth_user_id` (`author_id`),
  CONSTRAINT `recipe_groups_course_author_id_e2d6c656_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_groups_course`
--

LOCK TABLES `recipe_groups_course` WRITE;
/*!40000 ALTER TABLE `recipe_groups_course` DISABLE KEYS */;
INSERT INTO `recipe_groups_course` VALUES (2,'Hauptspeise','hauptspeise',1);
/*!40000 ALTER TABLE `recipe_groups_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_groups_cuisine`
--

DROP TABLE IF EXISTS `recipe_groups_cuisine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipe_groups_cuisine` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `author_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  UNIQUE KEY `slug` (`slug`),
  KEY `recipe_groups_cuisine_author_id_704782fa_fk_auth_user_id` (`author_id`),
  CONSTRAINT `recipe_groups_cuisine_author_id_704782fa_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_groups_cuisine`
--

LOCK TABLES `recipe_groups_cuisine` WRITE;
/*!40000 ALTER TABLE `recipe_groups_cuisine` DISABLE KEYS */;
INSERT INTO `recipe_groups_cuisine` VALUES (1,'deutsch','deutsch',1);
/*!40000 ALTER TABLE `recipe_groups_cuisine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_groups_tag`
--

DROP TABLE IF EXISTS `recipe_groups_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipe_groups_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `slug` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `title` (`title`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_groups_tag`
--

LOCK TABLES `recipe_groups_tag` WRITE;
/*!40000 ALTER TABLE `recipe_groups_tag` DISABLE KEYS */;
INSERT INTO `recipe_groups_tag` VALUES (1,'vegetarisch','vegetarisch'),(2,'vegan','vegan'),(3,'Fleisch','fleisch'),(4,'Fisch','fisch'),(5,'Obst','obst'),(6,'Gemüse','gemuse');
/*!40000 ALTER TABLE `recipe_groups_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_recipe`
--

DROP TABLE IF EXISTS `recipe_recipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipe_recipe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(250) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `photo` varchar(100) NOT NULL,
  `info` longtext NOT NULL,
  `prep_time` int(11) NOT NULL,
  `cook_time` int(11) NOT NULL,
  `servings` int(11) NOT NULL,
  `pub_date` datetime(6) NOT NULL,
  `update_date` datetime(6) NOT NULL,
  `author_id` int(11) DEFAULT NULL,
  `course_id` int(11) NOT NULL,
  `cuisine_id` int(11) NOT NULL,
  `source` varchar(200) NOT NULL,
  `directions` longtext NOT NULL,
  `public` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `recipe_recipe_author_id_76879012_fk_auth_user_id` (`author_id`),
  KEY `recipe_recipe_course_id_36ea1d30_fk_recipe_groups_course_id` (`course_id`),
  KEY `recipe_recipe_cuisine_id_74ec31bb_fk_recipe_groups_cuisine_id` (`cuisine_id`),
  CONSTRAINT `recipe_recipe_author_id_76879012_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `recipe_recipe_course_id_36ea1d30_fk_recipe_groups_course_id` FOREIGN KEY (`course_id`) REFERENCES `recipe_groups_course` (`id`),
  CONSTRAINT `recipe_recipe_cuisine_id_74ec31bb_fk_recipe_groups_cuisine_id` FOREIGN KEY (`cuisine_id`) REFERENCES `recipe_groups_cuisine` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_recipe`
--

LOCK TABLES `recipe_recipe` WRITE;
/*!40000 ALTER TABLE `recipe_recipe` DISABLE KEYS */;
INSERT INTO `recipe_recipe` VALUES (1,'Pfannkuchen','pfannkuchen','upload/recipe_photos/AE812927-18BE-433A-849E-0E81241734DF.jpeg','Rezept entsprechend meines Rezeptebuches',5,10,2,'2020-05-01 05:00:00.000000','2020-05-03 16:10:15.597419',2,2,1,'','Alles verrühren. Ggf. Konsistenz über Flüssigkeit anpassen.\nIn der Bratpfanne bei mittlerer Hitze zubereiten. \nSobald die Oberfläche nicht mehr flüssig ist, den Pfannkuchen wenden und kurz von der zweiten Seite zuende braten.\n\nAuf dem Teller grünen Salat, Nutella oder Zucker hinzugeben.\n\nAls Variante kann während des Bratens nach dem Wenden Scheiblettenkäse auf den Pfannkuchen gelegt werden.',1);
/*!40000 ALTER TABLE `recipe_recipe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_recipe_tags`
--

DROP TABLE IF EXISTS `recipe_recipe_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipe_recipe_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recipe_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `recipe_recipe_tags_recipe_id_tag_id_d5aaba5b_uniq` (`recipe_id`,`tag_id`),
  KEY `recipe_recipe_tags_tag_id_ee78e406_fk_recipe_groups_tag_id` (`tag_id`),
  CONSTRAINT `recipe_recipe_tags_recipe_id_01e493ee_fk_recipe_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `recipe_recipe` (`id`),
  CONSTRAINT `recipe_recipe_tags_tag_id_ee78e406_fk_recipe_groups_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `recipe_groups_tag` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_recipe_tags`
--

LOCK TABLES `recipe_recipe_tags` WRITE;
/*!40000 ALTER TABLE `recipe_recipe_tags` DISABLE KEYS */;
INSERT INTO `recipe_recipe_tags` VALUES (7,1,1);
/*!40000 ALTER TABLE `recipe_recipe_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_subrecipe`
--

DROP TABLE IF EXISTS `recipe_subrecipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipe_subrecipe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `measurement` longtext DEFAULT NULL,
  `child_recipe_id` int(11) DEFAULT NULL,
  `parent_recipe_id` int(11) DEFAULT NULL,
  `denominator` double NOT NULL,
  `numerator` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `recipe_subrecipe_child_recipe_id_8fd69499_fk_recipe_recipe_id` (`child_recipe_id`),
  KEY `recipe_subrecipe_parent_recipe_id_13084b48_fk_recipe_recipe_id` (`parent_recipe_id`),
  CONSTRAINT `recipe_subrecipe_child_recipe_id_8fd69499_fk_recipe_recipe_id` FOREIGN KEY (`child_recipe_id`) REFERENCES `recipe_recipe` (`id`),
  CONSTRAINT `recipe_subrecipe_parent_recipe_id_13084b48_fk_recipe_recipe_id` FOREIGN KEY (`parent_recipe_id`) REFERENCES `recipe_recipe` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_subrecipe`
--

LOCK TABLES `recipe_subrecipe` WRITE;
/*!40000 ALTER TABLE `recipe_subrecipe` DISABLE KEYS */;
/*!40000 ALTER TABLE `recipe_subrecipe` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-05 15:41:36
