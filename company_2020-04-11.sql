# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.01 (MySQL 5.7.20-log)
# Database: company
# Generation Time: 2020-04-11 09:03:24 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table co_admin
# ------------------------------------------------------------

DROP TABLE IF EXISTS `co_admin`;

CREATE TABLE `co_admin` (
  `admin_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int(11) DEFAULT NULL,
  `sex` tinyint(1) DEFAULT '0' COMMENT '1男2女',
  `email` varchar(100) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1' COMMENT '1正常2禁用',
  `realname` varchar(100) DEFAULT NULL,
  `nickname` varchar(200) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `remark` varchar(300) DEFAULT NULL,
  `auth_secert` char(32) DEFAULT '' COMMENT 'google身份验证的密钥',
  `reg_ip` int(11) DEFAULT NULL,
  `session_id` varchar(60) DEFAULT '',
  `app_token` char(64) DEFAULT NULL COMMENT 'c',
  `addtim` int(11) DEFAULT '0',
  `uptime` int(11) DEFAULT '0',
  `deltime` int(11) DEFAULT '0',
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `co_admin` WRITE;
/*!40000 ALTER TABLE `co_admin` DISABLE KEYS */;

INSERT INTO `co_admin` (`admin_id`, `group_id`, `sex`, `email`, `status`, `realname`, `nickname`, `mobile`, `remark`, `auth_secert`, `reg_ip`, `session_id`, `app_token`, `addtim`, `uptime`, `deltime`)
VALUES
	(1,1,1,'admin@admin.com',1,'钢盔','hony',NULL,'so fuck beautiful','EEOQBNTJ7CDGCWPDVSVVQGZ37FK7RBU7',NULL,'3el3s0dgq6dvorlmv8majaq907',NULL,NULL,0,0),
	(6,2,1,'asdfasd@123.com',1,'里相遇',NULL,NULL,'','DZWBRUUNUUJDAXXR44MVYMCUPOEMQIPS',NULL,'0',NULL,NULL,0,0),
	(11,5,NULL,'001@adm.com',1,'钢盔01',NULL,NULL,'gangkui001','HOELO43EFXMWYYWKWCSZ3QEMWRPQLR33',NULL,'myprefix-brcmrvlo54bapnm4hm8mqjact6',NULL,NULL,0,0);

/*!40000 ALTER TABLE `co_admin` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table co_admin_group
# ------------------------------------------------------------

DROP TABLE IF EXISTS `co_admin_group`;

CREATE TABLE `co_admin_group` (
  `group_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group_name` varchar(200) NOT NULL DEFAULT '',
  `remark` text,
  `create_time` int(11) NOT NULL,
  `create_user` int(11) DEFAULT '0',
  `powerlist` text,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `co_admin_group` WRITE;
/*!40000 ALTER TABLE `co_admin_group` DISABLE KEYS */;

INSERT INTO `co_admin_group` (`group_id`, `group_name`, `remark`, `create_time`, `create_user`, `powerlist`, `status`)
VALUES
	(1,'超级管理员','权限不受控制',1535536245,1,'*',1),
	(2,'老师组','园区老师',1535536292,1,'null',1),
	(3,'校长','校长',1536742381,1,NULL,1),
	(4,'学生','',1536744469,1,NULL,1),
	(5,'财务部门','会计',1536745043,1,NULL,1);

/*!40000 ALTER TABLE `co_admin_group` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table co_admin_login
# ------------------------------------------------------------

DROP TABLE IF EXISTS `co_admin_login`;

CREATE TABLE `co_admin_login` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` varchar(60) DEFAULT '' COMMENT '用户登陆session_id ',
  `status` tinyint(1) unsigned NOT NULL COMMENT '1登陆成功2登录失败',
  `login_ip` varchar(20) DEFAULT NULL COMMENT '登陆IP地址',
  `username` varchar(100) DEFAULT NULL COMMENT '登陆用户名称',
  `login_time` int(10) unsigned NOT NULL COMMENT '登陆时间',
  `login_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登陆用户id',
  `agent` varchar(1000) DEFAULT NULL COMMENT '浏览器信息',
  `user_type` varchar(30) NOT NULL DEFAULT 'admin' COMMENT 'admin后台用户',
  `remark` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `co_admin_login` WRITE;
/*!40000 ALTER TABLE `co_admin_login` DISABLE KEYS */;

INSERT INTO `co_admin_login` (`id`, `session_id`, `status`, `login_ip`, `username`, `login_time`, `login_id`, `agent`, `user_type`, `remark`)
VALUES
	(1,'ka4n0rp0es5tlsva5c290rc1o6',1,'127.0.0.1','admin',1541652488,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36','admin',NULL),
	(2,'ka4n0rp0es5tlsva5c290rc1o6',1,'127.0.0.1','gangkui003',1541652713,6,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36','admin',NULL),
	(3,'ka4n0rp0es5tlsva5c290rc1o6',1,'127.0.0.1','gangkui003',1541663249,6,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36','admin',NULL),
	(4,'ka4n0rp0es5tlsva5c290rc1o6',1,'127.0.0.1','gangkui003',1541663463,6,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36','admin',NULL),
	(5,'ka4n0rp0es5tlsva5c290rc1o6',2,'127.0.0.1','gangkui002',1541663594,0,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36','admin','用户名或者密码错误'),
	(6,'ka4n0rp0es5tlsva5c290rc1o6',2,'127.0.0.1','gangkui002',1541663599,0,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36','admin','用户名或者密码错误'),
	(7,'ka4n0rp0es5tlsva5c290rc1o6',1,'127.0.0.1','gangkui001',1541663626,11,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36','admin',NULL),
	(8,'ka4n0rp0es5tlsva5c290rc1o6',1,'127.0.0.1','admin',1541666475,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36','admin',NULL),
	(9,'ka4n0rp0es5tlsva5c290rc1o6',1,'127.0.0.1','admin',1541666669,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36','admin',NULL),
	(10,'3es2dhof7u9qa27gko6384i9t7',2,'127.0.0.1','gangkui001',1541670999,0,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0 Safari/605.1.15','admin','用户名或者密码错误'),
	(11,'3es2dhof7u9qa27gko6384i9t7',1,'127.0.0.1','gangkui001',1541671024,11,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0 Safari/605.1.15','admin',NULL),
	(12,'ka4n0rp0es5tlsva5c290rc1o6',1,'127.0.0.1','admin',1541671184,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36','admin',NULL),
	(13,'ka4n0rp0es5tlsva5c290rc1o6',1,'127.0.0.1','admin',1541671923,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36','admin',NULL),
	(14,'ka4n0rp0es5tlsva5c290rc1o6',1,'127.0.0.1','gangkui001',1541671952,11,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36','admin',NULL),
	(15,'ka4n0rp0es5tlsva5c290rc1o6',1,'127.0.0.1','gangkui001',1541672566,11,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36','admin',NULL),
	(16,'ka4n0rp0es5tlsva5c290rc1o6',1,'127.0.0.1','gangkui001',1541673499,11,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36','admin',NULL),
	(17,'myprefix-brcmrvlo54bapnm4hm8mqjact6',1,'127.0.0.1','gangkui001',1542114074,11,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36','admin',NULL),
	(18,'t6ju3io3uj97dbusfcrucgnb45',1,'127.0.0.1','admin',1542255720,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(19,'fs1lr2kerrlagmsmns1210e5j3',1,'127.0.0.1','admin',1542255731,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(20,'k3e6sb9n872ocrhbgas18svao0',1,'127.0.0.1','admin',1542255781,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(21,'gad4an9vbc5a7h619r4uc8bi12',1,'127.0.0.1','admin',1542256020,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(22,'3soob4n9q2igqup2lucb04mks3',1,'127.0.0.1','admin',1542256070,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(23,'fb8p8cmd39hiqc2nt30u21qpa1',1,'127.0.0.1','admin',1542256273,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(24,'i0f9dcgti8qk0pomone3222fq7',1,'127.0.0.1','admin',1542256281,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(25,'e3k56iobiveacg9hvlo79k3600',1,'127.0.0.1','admin',1542256356,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(26,'v2ba02m7e69cu1p299r45vqev2',1,'127.0.0.1','admin',1542256396,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(27,'1tti0a2lmlcu04cs3upk3cd8c2',1,'127.0.0.1','admin',1542256465,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(28,'myprefix-brcmrvlo54bapnm4hm8mqjact6',1,'127.0.0.1','admin',1542256558,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(29,'myprefix-brcmrvlo54bapnm4hm8mqjact6',1,'127.0.0.1','admin',1542256880,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(30,'9jp4p7vpt8f61q0m4lmu3ngk90',1,'127.0.0.1','admin',1542256959,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(31,'jepgibupjem1hc93n154vogvj2',1,'127.0.0.1','admin',1542256965,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(32,'uhtk8inecd8p2aciu0tg2k2e93',1,'127.0.0.1','admin',1542256993,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(33,'4ma9opvlqb9n3tupsiv3v9a3f5',1,'127.0.0.1','admin',1542257064,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(34,'tai3urqrlg2g12pn5cl17cb9l2',1,'127.0.0.1','admin',1542257100,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(35,'s04qkivuh4dk79h338sa2npgm6',1,'127.0.0.1','admin',1542257155,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(36,'psaq6a4p8n3276f0c9i83keku3',1,'127.0.0.1','admin',1542257181,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(37,'3ccvnrhhhqd8mng4mj9hs5i113',1,'127.0.0.1','admin',1542257258,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(38,'tmr1e4l9v91ersgeg82jqf5k10',1,'127.0.0.1','admin',1542257306,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(39,'myprefix-brcmrvlo54bapnm4hm8mqjact6',1,'127.0.0.1','admin',1542257397,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(40,'8dgblmo9tnpg28m5mk6pd07hc4',1,'127.0.0.1','admin',1542257418,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(41,'71pu3jiqh12bcf4lanmipq5dj5',1,'127.0.0.1','admin',1542257425,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(42,'b0ee2j87jodesemkcr6ldhknq4',1,'127.0.0.1','admin',1542257466,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(43,'s8c3gt8p1ioas0j32fi4pb4mg4',1,'127.0.0.1','admin',1542257548,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(44,'6perv7psdbs195mb8gg6pak5l0',1,'127.0.0.1','admin',1542257661,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(45,'cgj5da5tfsl9oe4ua20oarn587',1,'127.0.0.1','admin',1542257667,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(46,'lsqpd5rf50si39cmma0dvkdpi2',1,'127.0.0.1','admin',1542266764,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(47,'v0qqpe5l32ja5nvh503qmsmi61',1,'127.0.0.1','admin',1542266765,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(48,'cfb94rqasarkkmac9hh8in1i17',1,'127.0.0.1','admin',1542266803,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(49,'gqjfkrfroqmei6rr3mgdqegq30',1,'127.0.0.1','admin',1542266852,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(50,'tp7uvagdijosn6qpo1a3irfdt7',1,'127.0.0.1','admin',1542266999,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(51,'t2tsnr9lfst4oogqb860272id5',1,'127.0.0.1','admin',1542267276,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(52,'myprefix-brcmrvlo54bapnm4hm8mqjact6',1,'127.0.0.1','admin',1542267334,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(53,'kbc1op51k73dn7au7raffq4cr4',1,'127.0.0.1','admin',1542268392,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(54,'v9fhvisuumdf05u4vjelj94m21',1,'127.0.0.1','admin',1542360186,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(55,'53lkms8qpucb33a957oq172jf3',1,'127.0.0.1','admin',1542360275,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(56,'09r243kn1ltpbsms327igrjmn1',1,'127.0.0.1','admin',1542360281,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(57,'gt0befg5ng88s6ogp45r9skb87',1,'127.0.0.1','admin',1542360297,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(58,'796pf1ibif71kgkdjc5eqc3pm0',1,'127.0.0.1','admin',1542360348,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(59,'3b1q88neo8p7uld5fa4t58ie41',1,'127.0.0.1','admin',1542360359,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(60,'cmgv414fhdgg03ne2ac6alelp6',1,'127.0.0.1','admin',1542360406,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(61,'dl6p36j67o55lh9ol55pd0rtk1',1,'127.0.0.1','admin',1542360492,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(62,'245uah9gpr2r1ia0n0o284u7r0',1,'127.0.0.1','admin',1542369258,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(63,'q1a30ltml5nr7qfk2oeg380e83',1,'127.0.0.1','admin',1542425736,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(64,'8n2bj4ht9hv006g2vqk0mdvjo2',1,'127.0.0.1','admin',1542623928,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(65,'oceufq48junehgmvdgvr715292',1,'127.0.0.1','admin',1542806409,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(66,'e5j04cr7lk7oufn7i5v21o8a54',1,'127.0.0.1','admin',1543549074,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Safari/537.36','admin',NULL),
	(67,'b3rp4598u8r1e9mo5cp26q4t85',1,'127.0.0.1','admin',1545817751,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36','admin',NULL),
	(68,'eg0h75o3ovobqgcfes2pcfbbl2',1,'127.0.0.1','admin',1545829619,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36','admin',NULL),
	(69,'s74kf4mo9ts3ks0l6v5secchn0',2,'127.0.0.1','admin',1545898398,0,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:64.0) Gecko/20100101 Firefox/64.0','admin','用户名或者密码错误'),
	(70,'s74kf4mo9ts3ks0l6v5secchn0',1,'127.0.0.1','admin',1545898408,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:64.0) Gecko/20100101 Firefox/64.0','admin',NULL),
	(71,'6je5opa88ljsvv1n7n5rm7g953',1,'127.0.0.1','admin',1545900420,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36','admin',NULL),
	(72,'1ln6fjjrbina5s5du131meuts4',1,'127.0.0.1','admin',1564542585,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Safari/537.36','admin',NULL),
	(73,'in7pj989hkpdcpkbgpacqnu0l0',1,'127.0.0.1','admin',1564634313,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Safari/537.36','admin',NULL),
	(74,'pi98q3nt376ur0caultto706us',1,'127.0.0.1','admin',1570765439,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36','admin',NULL),
	(75,'pi98q3nt376ur0caultto706us',1,'127.0.0.1','admin',1570765475,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36','admin',NULL),
	(76,'pi98q3nt376ur0caultto706us',1,'127.0.0.1','admin',1570765912,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36','admin',NULL),
	(77,'pi98q3nt376ur0caultto706us',1,'127.0.0.1','admin',1570766231,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36','admin',NULL),
	(78,'fl7cp105e12ldfjc3hpccb0lf2',1,'127.0.0.1','admin',1570787554,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36','admin',NULL),
	(79,'as122ti9nuc8tlonrq0ml3ucn8',1,'127.0.0.1','admin',1570855937,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36','admin',NULL),
	(80,'brplbb6pub9ck2iiqndkv2dt4t',1,'127.0.0.1','admin',1570872083,1,'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36','admin',NULL);

/*!40000 ALTER TABLE `co_admin_login` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table co_admin_pam
# ------------------------------------------------------------

DROP TABLE IF EXISTS `co_admin_pam`;

CREATE TABLE `co_admin_pam` (
  `admin_id` char(32) NOT NULL DEFAULT '' COMMENT '账户序号ID',
  `username` varchar(100) NOT NULL DEFAULT '' COMMENT '登录名',
  `password` varchar(225) NOT NULL DEFAULT '' COMMENT '登录密码',
  `password_account` char(10) DEFAULT '' COMMENT '加密字符串',
  `wechat_openid` varchar(225) DEFAULT NULL COMMENT '微信openid',
  `app_token` char(64) DEFAULT NULL COMMENT 'app登陆tokne',
  `session_id` varchar(50) DEFAULT NULL,
  `uptime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后一次更新时间',
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员密码表';

LOCK TABLES `co_admin_pam` WRITE;
/*!40000 ALTER TABLE `co_admin_pam` DISABLE KEYS */;

INSERT INTO `co_admin_pam` (`admin_id`, `username`, `password`, `password_account`, `wechat_openid`, `app_token`, `session_id`, `uptime`)
VALUES
	('1','admin','$2y$10$q0Y6LyDnJuVhc48idZ9T.eIdLNNVbSryXnSqfXL6ivtvmXV.7grJq','',NULL,'','onep3512068ps04735p600ptnf',1586165818),
	('11','gangkui001','$2y$10$pLKmTwiz./w.8hPja3qQjuBdIwvskB3gPEY/ljVCdau6P/hElYELq','',NULL,NULL,NULL,0),
	('6','gangkui003','$2y$10$rsRw/PKLQPfhpR.XwrD6m.ocMygl6gd4BEtuNAPJbokykX5e.AMG.','',NULL,NULL,NULL,0);

/*!40000 ALTER TABLE `co_admin_pam` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table co_config
# ------------------------------------------------------------

DROP TABLE IF EXISTS `co_config`;

CREATE TABLE `co_config` (
  `key` varchar(250) NOT NULL DEFAULT '',
  `value` longtext,
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='配置表';

LOCK TABLES `co_config` WRITE;
/*!40000 ALTER TABLE `co_config` DISABLE KEYS */;

INSERT INTO `co_config` (`key`, `value`)
VALUES
	('app_order_check_base_setting','{\"app_token\":\"sofv5V57xJjm9sHKlZIZvojGOassNkXA70k7XVkiOXC2lFdujGmVHINuL7WCHXHr\",\"app_url\":\"http://sephp.a.com\",\"group_id\":\"4\"}'),
	('base_config','{\"web_name\":\"章洪科技\",\"page_title\":\"章洪科技\",\"page_keywords\":\"章洪科技，软件开发，系统维护，app开发\",\"page_description\":\"章洪科技专业的软件开发公司\",\"count_code\":\"\",\"icp_name\":\"粤icp-12322339783\",\"company_address\":\"湖北省宜昌市宜陵路687号1807号\",\"contact_number\":\"18502050396\",\"email\":\"wanggang5161@163.com\",\"qq_number\":\"549224868\"}'),
	('check_app_base_setting','{\"app_token\":\"OIo6jKmhae94on7dWAwm9uKQTy6j94o\",\"app_url\":\"http:://check.zhanghongkeij.com\",\"uid\":\"6\"}'),
	('company_aptitude','\"&lt;p style=&quot;outline: none; margin-bottom: 12px; text-indent: 2em; font-size: 18px; line-height: 30px; color: rgb(40, 40, 40); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Arial, Helvetica, sans-serif;&quot;&gt;&lt;strong style=&quot;outline: none;&quot;&gt;为客户创造价值。&lt;/strong&gt;华为携手合作伙伴，为电信运营商提供创新、安全的网络设备，为行业客户提供开放、灵活、安全的ICT基础设施产品，为云服务客户提供稳定可靠、安全可信和可持续演进的云服务。华为智能终端和智能手机，正在帮助人们享受高品质的数字工作、生活和娱乐体验。&lt;/p&gt;&lt;p style=&quot;outline: none; margin-bottom: 12px; text-indent: 2em; font-size: 18px; line-height: 30px; color: rgb(40, 40, 40); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Arial, Helvetica, sans-serif;&quot;&gt;&lt;strong style=&quot;outline: none;&quot;&gt;保障网络安全稳定运行。&lt;/strong&gt;从2018年开始，网络安全和隐私保护成为公司的最高纲领。30多年来，华为和运营商一起建设了1,500多张网络，帮助世界超过30亿人口实现联接，我们保持了良好的安全记录。&lt;/p&gt;&lt;p style=&quot;outline: none; margin-bottom: 12px; text-indent: 2em; font-size: 18px; line-height: 30px; color: rgb(40, 40, 40); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Arial, Helvetica, sans-serif;&quot;&gt;&lt;strong style=&quot;outline: none;&quot;&gt;推动产业良性发展。&lt;/strong&gt;华为主张开放、合作、共赢，与客户、伙伴合作创新、扩大产业价值，形成健康良性的产业生态系统。华为加入400多个标准组织、产业联盟和开源社区，积极参与和支持主流标准的制定，推动产业良性发展。推动社会可持续发展。华为致力消除数字鸿沟、促进数字包容，在珠峰、北极圈内等偏远地区建设网络，在西非埃博拉疫区、日本海啸核泄漏、中国汶川大地震等重大灾难现场恢复通信；同时，积极推进绿色低碳和节能环保，帮助培养本地ICT人才，促进数字经济发展。&lt;/p&gt;&lt;p style=&quot;outline: none; margin-bottom: 12px; text-indent: 2em; font-size: 18px; line-height: 30px; color: rgb(40, 40, 40); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Arial, Helvetica, sans-serif;&quot;&gt;&lt;strong style=&quot;outline: none;&quot;&gt;为奋斗者提供舞台。&lt;/strong&gt;华为坚持&ldquo;以奋斗者为本&rdquo;，以责任贡献来评价员工和选拔干部，为员工提供了全球化发展平台、与世界对话的机会，使大量年轻人有机会担当重任，快速成长，也使得十几万员工通过个人的努力，收获了合理的回报与值得回味的人生经历。&lt;/p&gt;\"'),
	('company_cultural','\"&lt;p style=&quot;outline: none; margin-bottom: 12px; text-indent: 2em; font-size: 18px; line-height: 30px; color: rgb(40, 40, 40); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Arial, Helvetica, sans-serif;&quot;&gt;华为30年坚持聚焦在主航道，抵制一切诱惑；坚持不走捷径，拒绝机会主义，踏踏实实，长期投入，厚积薄发；坚持以客户为中心，以奋斗者为本，长期艰苦奋斗，坚持自我批判。&lt;/p&gt;&lt;p style=&quot;outline: none; margin-bottom: 12px; text-indent: 2em; font-size: 18px; line-height: 30px; color: rgb(40, 40, 40); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Arial, Helvetica, sans-serif;&quot;&gt;我们不会辜负时代慷慨赋予我们的历史性机遇，为构建万物互联的智能世界，一往无前。&lt;/p&gt;\"'),
	('company_profile','\"&lt;p style=&quot;outline: none; margin-bottom: 12px; text-indent: 2em; font-size: 18px; line-height: 30px; color: rgb(40, 40, 40); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Arial, Helvetica, sans-serif;&quot;&gt;华为创立于1987年，是全球领先的ICT（信息与通信）基础设施和智能终端提供商，我们致力于把数字世界带入每个人、每个家庭、每个组织，构建万物互联的智能世界。目前华为有19.4万员工，业务遍及170多个国家和地区，服务30多亿人口。&lt;/p&gt;&lt;p style=&quot;outline: none; margin-bottom: 12px; text-indent: 2em; font-size: 18px; line-height: 30px; color: rgb(40, 40, 40); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Arial, Helvetica, sans-serif;&quot;&gt;我们在通信网络、IT、智能终端和云服务等领域为客户提供有竞争力、安全可信赖的产品、解决方案与服务，与生态伙伴开放合作，持续为客户创造价值，释放个人潜能，丰富家庭生活，激发组织创新。华为坚持围绕客户需求持续创新，加大基础研究投入，厚积薄发，推动世界进步。&lt;/p&gt;\"'),
	('files','\"\"'),
	('friend_link','[{\"sort_id\":\"11\",\"title\":\"腾讯\",\"url\":\"www.qq.ccom\",\"status\":\"1\"},{\"sort_id\":\"1\",\"title\":\"百度\",\"url\":\"www.baidu.com\",\"status\":\"2\"}]'),
	('join_us','\"&lt;div class=&quot;general_con_c_ri_word&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; color: rgb(102, 102, 102); font-family: 微软雅黑; font-size: 12px; background-color: rgb(246, 246, 246);&quot;&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;相信梦想，相信技术的力量&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;加入快递100，我们一起改变世界&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;地址：深圳市南山区金蝶软件园&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;&amp;nbsp;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;&lt;strong style=&quot;text-size-adjust: none; line-height: 50px;&quot;&gt;开发类&lt;/strong&gt;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;职位：架构师&lt;a href=&quot;http://jobs.zhaopin.com/000152478271093.htm&quot; target=&quot;_blank&quot; style=&quot;text-size-adjust: none; outline: none; color: rgb(50, 120, 230);&quot;&gt;（去智联招聘看看）&lt;/a&gt;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;技能要求：&lt;br style=&quot;text-size-adjust: none;&quot;&gt;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;1、3年以上互联网行业大规模系统设计开发和项目经验；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;2、扎实的Java基础，能完成项目核心代码的编写；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;3、理解zookeeper、redis、kafka的实现方式，具备相关性能分析及调优能力；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;4、了解oracle的性能分析及调优；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;5、熟悉互联网系统整套研发体系，做过产品的架构规划和性能调优；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;6、具备良好的需求分析能力、业务和技术方案策划及设计能力；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;&amp;nbsp;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;综合素质要求：&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;1、良好的沟通能力和高度的责任感；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;2、对技术富有热情；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;&amp;nbsp;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;其他要求：&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;1、5年及以上Java开发经验；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;2、本科及以上学历；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;&amp;nbsp;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;职位：Java开发工程师&lt;a href=&quot;http://jobs.zhaopin.com/000152478271180.htm&quot; target=&quot;_blank&quot; style=&quot;text-size-adjust: none; outline: none; color: rgb(50, 120, 230);&quot;&gt;（去智联招聘看看）&lt;/a&gt;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;岗位职责：&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;1、完成系统框架和核心代码的实现&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;2、系统开发测试、部署和集成；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;3、负责解决开发过程中的技术问题；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;4、参与代码维护与备份。&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;&amp;nbsp;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;任职要求：&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;1、计算机相关专业，全日制本科，3年以上Java软件开发经验&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;2、精通Java语言,熟悉J2EE相关技术，基础扎实，熟练掌握常用Java技术框架，能编写高质量简洁清晰的代码&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;3、对于Java基础技术体系（包括JVM、类装载机制、多线程并发、IO、网络）有一定的掌握和应用经验&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;4、熟悉ORACLE、NoSQL等主流数据库；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;5、对于高并发、高稳定可用性、高性能、大数据处理有过实际项目产品经验者优先。&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;6、有运营支撑系统项目开发经验者优先；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;7、、熟悉Linux常用命令，熟悉常用java应用服务器 (Tomcat) 和 Web服务器（Nginx, Apache）能独立在上面进行测试和部署；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;8、工作认真负责，能承受项目工作压力；较强的责任心及团队合作精神，有独立解决问题和快速学懂运用新技术的能力；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;&amp;nbsp;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;职位：Web前端开发工程师&lt;a href=&quot;http://jobs.zhaopin.com/000152478270750.htm&quot; target=&quot;_blank&quot; style=&quot;text-size-adjust: none; outline: none; color: rgb(50, 120, 230);&quot;&gt;（去智联招聘看看）&lt;/a&gt;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;岗位职责：&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;1、负责快递超市、快递管家、物料商城、快递学院网站开发与维护&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;2、负责快递管家微信小程序开发与维护&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;3、根据项目需求，分析并给出合理的页面前端结构解决方案，与设计师、后端开发工程师配合完成项目工作&lt;/p&gt;&lt;p4、团队配合，参与前端架构的设计和规范化工作，优化代码实现，提高产品性能 style=&quot;text-size-adjust: none; color: rgb(0, 0, 0); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Verdana, arial, sans-serif; font-size: 14px;&quot;&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;&amp;nbsp;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;任职要求：&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;1、全日制本科及以上学历，计算机相关专业，有3年及以上开发经验&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;2、熟练掌握HTML(5),CSS(3),javascript,Ajax等相关技术&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;3、熟悉至少一种框架（如jQuery, React，Vue，AngularJS等）&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;4、深刻理解Web标准，在可用性、浏览器兼容性等方面有实践经验&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;5、熟练掌握使用WebStorm,Photoshop等开发工具&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;6、遵守团队的代码格式、结构的规定，编写易读、易维护、高质量、高效率的代码&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;7、团队意识强，富有责任心，乐观积极，擅长沟通&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;&amp;nbsp;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;Android开发工程师&amp;nbsp;&lt;a href=&quot;http://jobs.zhaopin.com/000152478270761.htm&quot; targe=&quot;blank&quot; style=&quot;text-size-adjust: none; outline: none; color: rgb(50, 120, 230);&quot;&gt;（去智联招聘看看）&lt;/a&gt;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;工作内容：&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;1、独立负责Android平台下的应用程序开发、设计和维护，负责Android App的发布；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;2、配合完成Android项目的架构设计、方案的制定；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;3、跟进Android的新技术发展，编写设计开发及实现文档&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;4、负责优化移动产品的质量、性能、用户体验；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;&amp;nbsp;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;任职要求：&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;1、本科及以上学历，计算机相关专业。&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;2、具备3年及以上的Android移动应用一线研发经验，有蓝牙打印开发经验更佳。&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;3、具备独立开发的能力。&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;4、熟悉Android系统开发常见问题的原因及解决方式，熟悉Android系统回收问题。&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;5、熟悉常用的设计模式（请提供至少一款参与开发的上线作品）&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;&amp;nbsp;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;信息安全工程师&amp;nbsp;&lt;a href=&quot;http://jobs.zhaopin.com/000152478270785.htm&quot; target=&quot;_blank&quot; style=&quot;text-size-adjust: none; outline: none; color: rgb(50, 120, 230);&quot;&gt;（去智联招聘看看）&lt;/a&gt;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;工作职责：&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;1、负责公司服务器的安全基线检查与加固；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;2、负责公司线上系统安全漏洞发现和修复跟进；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;3、参与制定信息安全制度与规范、保障业务安全发展；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;4、负责公司内部的信息安全培训；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;5、负责公司的信息安全审计、风险评估&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;6、负责系统平台安全规划设计、建设；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;&amp;nbsp;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;任职要求：&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;1、计算机相关专业本科及以上学历，至少两年以上信息安全领域工作经验；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;2、熟悉信息安全体系和安全标准（BS7799或ISO27001或安全等级保护），能够独立完成安全体系的建设，提供完整性的解决&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;方案，能熟练使用安全监控、漏洞扫描、补丁追踪等安全工具进行信息安全评估；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;3、熟悉常用安全工具，如：AWVS、appscan、nessus等自动化扫描工具；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;4、熟悉Apache、Tomcat、Nginx等Web中间件，了解相关安全漏洞或入侵手段，有一定的安全加固实践；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;5、有责任心，良好的对外沟通和团队协作能力。&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;&lt;strong style=&quot;text-size-adjust: none; line-height: 50px;&quot;&gt;电商类&lt;/strong&gt;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;电商运营总监/经理&amp;nbsp;&lt;a href=&quot;http://jobs.zhaopin.com/000152478270967.htm&quot; target=&quot;_blank&quot; style=&quot;text-size-adjust: none; outline: none; color: rgb(50, 120, 230);&quot;&gt;（去智联招聘看看）&lt;/a&gt;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;职位描述：&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;1.负责快递100电商业务（快递领域）的整体规划、营销、推广等工作&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;2.负责商城的日常策划、上架、推广、销售、售后服务等经营与管理工作&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;3.挖掘用户需求，开拓适合目标客户群的类目和商品。&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;4.优化平台内用户的购买转化路径，提升客单价及复购率。&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;5.运营团队的组建、培训和管理，目标的分解和执行，标准化流程的制定提升运营效率，活动策划和执行&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;6.负责部门运营日常管理性工作，保证部门运营流程畅通&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;&amp;nbsp;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;职位要求：&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;1.5年以上电商运营经验；有独立商城运营经验的，优先考虑&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;2.精通互联网运营，有项目策划、筹备、搭建、实施上线、运营、推广等经历&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;3.善于挖掘垂直领域用户的需求，熟悉目标用户形态及切入点&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;4.对数据分析有敏锐的感觉，并能对数据有效挖掘&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;5.能根据行业不同时期的市场特点作出适时的策略调整和方法改进&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;6、勤奋、责任心强、执行力强、具备良好的团队合作精神和市场开拓的能力，创新能力强.&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;&amp;nbsp;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;电商品类经理&amp;nbsp;&lt;a href=&quot;http://jobs.zhaopin.com/000152478271091.htm&quot; target=&quot;_blank&quot; style=&quot;text-size-adjust: none; outline: none; color: rgb(50, 120, 230);&quot;&gt;（去智联招聘看看）&lt;/a&gt;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;岗位职责：&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;1、负责垂直行业电商平台的市场调查分析、寻找热卖产品，发掘卖点；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;2、产品的前期调查分析，搜集、分析、汇总、评估新产品的信息；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;3、总结产品的反馈信息，针对产品质量、功能性问题进行持续迭代；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;4、定期进行产品数据分析和产品架构评估，控制产品生命周期。&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;5、负责商品销售引导的页面展示规划、内容运营、活动策划，提升商品销量；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;&amp;nbsp;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;职位要求：&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;1、全日制本科及以上，3 年以上互联网产品或运营经验；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;2、对智能硬件领域感兴趣，并有深度使用经历。&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;3、优秀的沟通协调能力，擅长多部门协作；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;4、优秀的学习能力和时刻开放的心态；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;&amp;nbsp;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;电商客服&amp;nbsp;&lt;a href=&quot;http://jobs.zhaopin.com/000152478271090.htm&quot; target=&quot;_blank&quot; style=&quot;text-size-adjust: none; outline: none; color: rgb(50, 120, 230);&quot;&gt;（去智联招聘看看）&lt;/a&gt;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;职位描述：&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;1、售前售后咨询：通过线上即时通讯工具和电话与客户沟通，回答客户相关咨询，提供体贴周到的售前售后服务；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;2、疑难问题处理：处理问题、安排进展、跟进进程、沟通及疑难问题服务的意识跟能力；异常快递订单的反馈、跟踪工作；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;3、客服数据统计：客户退换货的跟踪和处理，以及客户的退换货记录工作；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;&amp;nbsp;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;任职要求：&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;1、全日制大专及以上学历，具有较强的抗压能力，适应能力；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;2、熟悉计算机基本知识及操作，能够熟练使用文档处理工具；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;3、优秀的语言沟通能力和销售服务意识,熟悉网购流程,有淘宝网店及其他店铺客服经验者优先;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;4、有强烈的责任感和高效的执行力，良好的服务意识、耐心和责任心；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;&amp;nbsp;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;&lt;strong style=&quot;text-size-adjust: none; line-height: 50px;&quot;&gt;营销类&lt;/strong&gt;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;城市经理&amp;nbsp;&lt;a href=&quot;http://jobs.zhaopin.com/000152478270495.htm&quot; target=&quot;_blank&quot; style=&quot;text-size-adjust: none; outline: none; color: rgb(50, 120, 230);&quot;&gt;（去智联招聘看看）&lt;/a&gt;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;岗位职责：&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;1. 开拓线下加盟合作渠道，推进传统快递站点、承包区、发展快递员入驻快递超市平台；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;2. 根据公司下达的销售拓展等营运任务，制定所管辖区域加盟商工作计划确保各项营运指标如期完成；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;3. 根据总部加盟商管理政策进行日常加盟商管理&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;4.及时协调各方资源解决区域加盟管理中的突发事件&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;5.建立维护区域快递业务圈，与外部保持良好的关系&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;&amp;nbsp;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;任职资格：&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;1.本科及以上学历，有2年工作经验，拥有加盟招商或快递站点管理经验者优先；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;2.有较强的开拓意识和把握机会的能力，能独立进行市场开拓和潜在客户开发；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;3.抗压能力、执行力强，具备处理突发事件的能力；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;4.擅长人际交往，性格外向，具有优秀的客户沟通与谈判能力；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;5.需适应长期性出差工作，可匹配定向城市。&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;&amp;nbsp;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;分销经理&amp;nbsp;&lt;a href=&quot;http://jobs.zhaopin.com/CC000152478J00073098608.htm&quot; target=&quot;_blank&quot; style=&quot;text-size-adjust: none; outline: none; color: rgb(50, 120, 230);&quot;&gt;（去智联招聘看看）&lt;/a&gt;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;工作内容&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;1. 按照公司的市场发展目标，负责全国分销渠道发展策略的制订，如产品线的设定、产品价格体系的维护，掌握竞品动态及促销活动计划，并制订出相应策略。&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;2. 负责区域内经销商的开发、维护和管理，负责市场的开拓、客户的开发、区域布局及新客户的谈判工作；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;3.负责分销渠道的创新管理和终端的服务提升，建立和完善售前售中售后的服务管理体系，确保有效推广。&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;4. 负责分销终端客户增值服务的方案设计与推广，并负责内部客户服务系统的不断完善以使其更专业地应对市场对品牌的要求。&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;5. 对业务运营成本，利润，销量等关键指标负责，负责产品运营及销售数据的分析、总结，完成各类周期性报表；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;6. 参与分销渠道人员的监督奖励机制，年度绩效考核，需求培训的开发，优化销售组织结构，建立全面的分销人员的运作系统。&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;&amp;nbsp;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;职位要求&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;1. 本科全日制及以上学历，至少5年以上的分销渠道管理工作经验，熟悉分销终端渠道的实践操作流程以及售前售中的服务管理体系。&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;2. 良好的分析和提案能力，较强的执行和监督管理能力，并具备同等相关的实践经验。&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;3. 良好的客户服务意识和理念，在客户增值服务的开发提升以及营销服务的优化方面具有一定的实践经验。&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;4. 具备清晰的表达能力和良好的沟通技巧，且目标感明确。&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;&amp;nbsp;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;&lt;strong style=&quot;text-size-adjust: none; line-height: 50px;&quot;&gt;综合类&lt;/strong&gt;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;产品经理&amp;nbsp;&lt;a href=&quot;http://jobs.zhaopin.com/000152478270805.htm&quot; style=&quot;text-size-adjust: none; outline: none; color: rgb(50, 120, 230);&quot;&gt;（去智联招聘看看）&lt;/a&gt;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;工作职责：&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;1. 负责快递100快递员端（派件业务方向）的产品设计，并对产品最终的用户体验负责；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;2. 针对业务需求，能独立完成方案论证、原型设计、输出PRD文档；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;3. 定期分析产品相关数据，洞悉产品潜在优化方向；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;4. 关注行业相关政策及动态，分析行业发展机会。&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;&amp;nbsp;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;工作要求：&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;1. 本科及以上学历，心理学相关专业加分；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;2. 3~5年互联网行业产品工作经验，物流行业加分。&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;3. 有独立负责产品设计经验加分；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;4. 工作积极主动，有持续的热情和责任心，对产品品质有追求，善于团队合作，能承受高强度的工作压力；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;5、简历请提供至少一个深度参与的成功项目案例。&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;&amp;nbsp;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;用户运营专家&amp;nbsp;&lt;a href=&quot;http://jobs.zhaopin.com/000152478270804.htm&quot; target=&quot;blank&quot; style=&quot;text-size-adjust: none; outline: none; color: rgb(50, 120, 230);&quot;&gt;（去智联招聘看看）&lt;/a&gt;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;岗位职责：&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;1、负责沉默用户（快递员端）的激活并提升整体活跃度；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;2、挖掘快递100平台内、外的快递员用户，提升新用户转化；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;3、探索线上线下的拉新渠道，并建立和完善线上线下引流的长效机制；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;4、负责快递行业相关平台及企业合作。&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;5、分析运营数据，从数据中发现问题和机会，定期与产品团队沟通产品迭代方案。&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;&amp;nbsp;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;任职资格：&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;1、本科及以上学历&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;2、5年以上互联网服务或者流通行业相关工作经验&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;3、了解快递员群体，了解快递行业的运作机制（基础前提）。&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;4、有较强的用户及数据分析能力，善于文案策划。&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;5、思维活跃，善于沟通和协调资源，能承担较强的工作压力。&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;6、简历请提供至少一个深度参与的成功项目案例。&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;&amp;nbsp;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;产品运营经理（查询业务&lt;a href=&quot;http://jobs.zhaopin.com/000152478270872.htm&quot; style=&quot;text-size-adjust: none; outline: none; color: rgb(50, 120, 230);&quot;&gt;（去智联招聘看看）&lt;/a&gt;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;职位描述：&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;1、负责快递100个人端产品全年的运营策略制定和落地，结合渠道制定推广、活动运营方案，逐步建立产品运营体系；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;2、负责协调和拓展公司内外部平台推广资源，保证产品运营方案、合作方案可以有效的推动业务快速发展；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;3、围绕用户的拉新、留存、活跃等指标，制定相应的用户体系、积分体系，沉淀平台商业化氛围，并对投入产出比负责；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;4、日常对自身产品、竞品的各项指标进行数据收集、跟踪、监控，分析数据并定期输出运营报告，为产品迭代、创新提供改进建议；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;&amp;nbsp;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;职位要求：&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;1、有从0到1的冷启动运营经验、App成功推广经验优先&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;2、对快递行业有兴趣、爱研究，对国际快递、海淘、代购群体有深入了解优先；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;3、能准确把握用户心理，熟悉互联网产品运营的各种办法，有较强的数据分析与逻辑分析能力；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;4、团队合作精神，思维跳跃，善于沟通，细心扛压&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;&amp;nbsp;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;UI设计&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;岗位职责：&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;1、负责产品规划及创意过程，设定整体视觉风格和UI设计，包括手机端及PC端；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;2、制定各项目界面设计流程与规范，同时负责维护和更新；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;3、能够配合团队高效完成设计方案，与开发工程师保持良好沟通，对设计有严格的执行力；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;4、负责产品日常运营活动及品牌维护提供设计支持；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;&amp;nbsp;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;岗位要求：&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;1、全日制本科以上学历,美术，设计或相关专业（此职位申请需附有作品集）&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;2、从事UI设计行业工作3年以上，具有独立完成项目视觉风格推导及实现的工作经验；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;3、具有体系化的设计理论与娴熟的设计技巧，善于捕捉设计流行趋势；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;4、熟练掌握各种绘图工具软件PS，AI，sketch等；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;5、富有激情，积极主动，关注细节，学习能力强；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;6、擅长手绘，动效者优先；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;&amp;nbsp;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;品牌策划&amp;nbsp;&lt;a href=&quot;http://jobs.zhaopin.com/000152478271039.htm&quot; style=&quot;text-size-adjust: none; outline: none; color: rgb(50, 120, 230);&quot;&gt;（去智联招聘看看）&lt;/a&gt;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;工作职责：&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;1、 负责快递100及相关产品的品牌运营推广，并协助各产品部门完成相关推广的需求；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;2、 负责推广和运营活动的创意和实施执行，包括创意内容输出、稿件撰写、互动玩法设计、引流转化、传播展示等；同时通过数据分析，即时调整活动策略，优化活动效果；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;3、 对外部渠道的合作沟通，参与商务沟通，落实合作计划并实施；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;4、 协助进行官方自媒体传播矩阵的搭建，内容规划，以及相关执行；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;&amp;nbsp;&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;任职要求：&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;1、全日制本科及以上学历，2年以上工作经验，汉语言文学、新闻、广告、传播学及其相关专业；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;2、熟悉互联网动态，对互联网运营和传播有一定认知，有成功的活动（线上）策划经验；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;3、能够独立开展活动运营的能力，具备数据分析能力；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;4、思维活跃，有较强的活动创意能力，尤其是关于互联网产品的玩法和内容创意；&lt;/p&gt;&lt;p style=&quot;text-size-adjust: none; margin-bottom: 0px; padding: 0px; text-indent: 2em; color: rgb(130, 130, 130);&quot;&gt;5、文字功底强，有较强的文案输出能力；&lt;/p&gt;&lt;/p4、团队配合，参与前端架构的设计和规范化工作，优化代码实现，提高产品性能&gt;&lt;/div&gt;\"'),
	('menu_index','[{\"sort_id\":\"1\",\"title\":\"首页\",\"url\":\"/index.html\",\"status\":\"1\"},{\"sort_id\":\"2\",\"title\":\"关于我们\",\"url\":\"/about.html\",\"status\":\"1\"},{\"sort_id\":\"3\",\"title\":\"产品展示\",\"url\":\"/gallery.html\",\"status\":\"1\"},{\"sort_id\":\"3\",\"title\":\"加入我们\",\"url\":\"/join_us.html\",\"status\":\"1\"},{\"sort_id\":\"4\",\"title\":\"联系我们\",\"url\":\"/contact.html\",\"status\":\"1\"}]'),
	('service_range','\"&lt;p style=&quot;outline: none; margin-bottom: 12px; text-indent: 2em; font-size: 18px; line-height: 30px; color: rgb(40, 40, 40); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Arial, Helvetica, sans-serif;&quot;&gt;&lt;strong style=&quot;outline: none;&quot;&gt;为客户创造价值。&lt;/strong&gt;华为携手合作伙伴，为电信运营商提供创新、安全的网络设备，为行业客户提供开放、灵活、安全的ICT基础设施产品，为云服务客户提供稳定可靠、安全可信和可持续演进的云服务。华为智能终端和智能手机，正在帮助人们享受高品质的数字工作、生活和娱乐体验。&lt;/p&gt;&lt;p style=&quot;outline: none; margin-bottom: 12px; text-indent: 2em; font-size: 18px; line-height: 30px; color: rgb(40, 40, 40); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Arial, Helvetica, sans-serif;&quot;&gt;&lt;strong style=&quot;outline: none;&quot;&gt;保障网络安全稳定运行。&lt;/strong&gt;从2018年开始，网络安全和隐私保护成为公司的最高纲领。30多年来，华为和运营商一起建设了1,500多张网络，帮助世界超过30亿人口实现联接，我们保持了良好的安全记录。&lt;/p&gt;&lt;p style=&quot;outline: none; margin-bottom: 12px; text-indent: 2em; font-size: 18px; line-height: 30px; color: rgb(40, 40, 40); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Arial, Helvetica, sans-serif;&quot;&gt;&lt;strong style=&quot;outline: none;&quot;&gt;推动产业良性发展。&lt;/strong&gt;华为主张开放、合作、共赢，与客户、伙伴合作创新、扩大产业价值，形成健康良性的产业生态系统。华为加入400多个标准组织、产业联盟和开源社区，积极参与和支持主流标准的制定，推动产业良性发展。推动社会可持续发展。华为致力消除数字鸿沟、促进数字包容，在珠峰、北极圈内等偏远地区建设网络，在西非埃博拉疫区、日本海啸核泄漏、中国汶川大地震等重大灾难现场恢复通信；同时，积极推进绿色低碳和节能环保，帮助培养本地ICT人才，促进数字经济发展。&lt;/p&gt;&lt;p style=&quot;outline: none; margin-bottom: 12px; text-indent: 2em; font-size: 18px; line-height: 30px; color: rgb(40, 40, 40); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Arial, Helvetica, sans-serif;&quot;&gt;&lt;strong style=&quot;outline: none;&quot;&gt;为奋斗者提供舞台。&lt;/strong&gt;华为坚持&ldquo;以奋斗者为本&rdquo;，以责任贡献来评价员工和选拔干部，为员工提供了全球化发展平台、与世界对话的机会，使大量年轻人有机会担当重任，快速成长，也使得十几万员工通过个人的努力，收获了合理的回报与值得回味的人生经历。&lt;/p&gt;\"'),
	('template','lassic'),
	('we_hope','\"&lt;p style=&quot;outline: none; margin-bottom: 12px; text-indent: 2em; font-size: 18px; line-height: 30px; color: rgb(40, 40, 40); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Arial, Helvetica, sans-serif;&quot;&gt;华为30年坚持聚焦在主航道，抵制一切诱惑；坚持不走捷径，拒绝机会主义，踏踏实实，长期投入，厚积薄发；坚持以客户为中心，以奋斗者为本，长期艰苦奋斗，坚持自我批判。&lt;/p&gt;&lt;p style=&quot;outline: none; margin-bottom: 12px; text-indent: 2em; font-size: 18px; line-height: 30px; color: rgb(40, 40, 40); font-family: &amp;quot;Microsoft YaHei&amp;quot;, Arial, Helvetica, sans-serif;&quot;&gt;我们不会辜负时代慷慨赋予我们的历史性机遇，为构建万物互联的智能世界，一往无前。&lt;/p&gt;\"');

/*!40000 ALTER TABLE `co_config` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table co_content
# ------------------------------------------------------------

DROP TABLE IF EXISTS `co_content`;

CREATE TABLE `co_content` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(300) NOT NULL DEFAULT '' COMMENT '文章标题',
  `cate_id` int(11) unsigned NOT NULL COMMENT '文章分类',
  `is_top` tinyint(1) unsigned NOT NULL DEFAULT '2' COMMENT '文章重要性，1推荐置顶，2不推',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态',
  `is_show` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否显示1显示，2不显示',
  `author` varchar(200) DEFAULT '0' COMMENT '文章作者	',
  `keywords` varchar(500) DEFAULT NULL COMMENT '关键字',
  `description` varchar(500) DEFAULT NULL COMMENT '网页描述	',
  `url` varchar(300) DEFAULT NULL COMMENT '外部链接	',
  `content` longtext COMMENT '文章内容',
  `create_time` int(10) unsigned NOT NULL,
  `create_user` int(10) unsigned NOT NULL,
  `update_time` int(10) unsigned DEFAULT '0',
  `update_user` int(10) unsigned DEFAULT '0',
  `delete_user` int(10) unsigned DEFAULT '0',
  `delete_time` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `co_content` WRITE;
/*!40000 ALTER TABLE `co_content` DISABLE KEYS */;

INSERT INTO `co_content` (`id`, `title`, `cate_id`, `is_top`, `status`, `is_show`, `author`, `keywords`, `description`, `url`, `content`, `create_time`, `create_user`, `update_time`, `update_user`, `delete_user`, `delete_time`)
VALUES
	(1,'我要买飞机',7,2,1,1,'admin','dsfasdfasdf','asdfasdfasdf','sdfasdf','&lt;p&gt;sdfasdfasdfa发送到发送&lt;/p&gt;&lt;p&gt;&lt;br&gt;&lt;/p&gt;&lt;p&gt;阿斯顿发送到发啊撒&lt;img src=&quot;http://sephp.a.com/upload/file/955638227140648969821.jpg&quot; data-filename=&quot;插入图片&quot; style=&quot;width: 25%;&quot;&gt;&lt;/p&gt;',1537527202,1,0,0,0,0),
	(2,'充值流程',3,2,1,1,'admin','fa s d f','a s d fa s d fa s d f','阿斯顿发送到发','',1537527300,1,0,0,0,0),
	(3,'售后流程',5,2,1,1,'','阿就会快乐；立刻就会哭','说到发送的发送到发阿斯顿','','',1537527351,1,0,0,0,0),
	(4,'发展既要',2,2,1,1,'admin','','到发','','',1537585159,1,0,0,0,0);

/*!40000 ALTER TABLE `co_content` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table co_content_cate
# ------------------------------------------------------------

DROP TABLE IF EXISTS `co_content_cate`;

CREATE TABLE `co_content_cate` (
  `cate_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(300) NOT NULL DEFAULT '' COMMENT '类名',
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父级id',
  `is_show` tinyint(1) unsigned DEFAULT '1' COMMENT '首页显示，1显示2不显示',
  `path` varchar(100) NOT NULL DEFAULT '0' COMMENT '路径',
  `level` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '等级，级别',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态1可用2禁用',
  `remark` varchar(500) DEFAULT NULL COMMENT '描述,备注',
  `create_user` int(11) unsigned NOT NULL,
  `create_time` int(11) unsigned NOT NULL,
  `keywords` varchar(500) DEFAULT NULL COMMENT '关键字',
  `description` varchar(500) DEFAULT NULL COMMENT '描述',
  `sort_num` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '排序号码',
  `child_num` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '子类数量',
  PRIMARY KEY (`cate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `co_content_cate` WRITE;
/*!40000 ALTER TABLE `co_content_cate` DISABLE KEYS */;

INSERT INTO `co_content_cate` (`cate_id`, `name`, `parent_id`, `is_show`, `path`, `level`, `status`, `remark`, `create_user`, `create_time`, `keywords`, `description`, `sort_num`, `child_num`)
VALUES
	(1,'关于我们',4,1,'0',1,1,'',1,1537001111,'据了解阿莱克斯简单快乐发送','说到发送到发送的',1,2),
	(2,'日常妙招',1,1,'0-1',2,1,NULL,1,1537003308,'sssssssfasdfasdfasd','实打实分',1,2),
	(3,'联系我们',0,1,'0',1,1,NULL,1,1537003355,'新产品','是否',1,1),
	(4,'电子产品',3,1,'0-3',2,1,NULL,1,1537003373,'阿斯顿发送到','',1,0),
	(5,'可以试试',2,1,'0-1-2',3,1,NULL,1,1537003919,'回家看了就好看就好','',1,0),
	(6,'一起健身',2,1,'0-1-2',3,1,NULL,1,1537008693,'收到发发撒的发','阿斯顿发',1,0),
	(7,'技术跟新',1,2,'0-1',2,1,NULL,1,1537008710,'a s d f s d f','dsfasdfasd是发送到发dfasdfasdf',1,0),
	(8,'合作案例',0,1,'0',1,1,NULL,1,1537009126,'可节省空间','就会快乐JKL;LKJHKL;',100,1),
	(9,'找鸭子',8,1,'0-8',2,1,NULL,1,1537009151,'','',2,0);

/*!40000 ALTER TABLE `co_content_cate` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table co_file
# ------------------------------------------------------------

DROP TABLE IF EXISTS `co_file`;

CREATE TABLE `co_file` (
  `file_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(500) DEFAULT NULL COMMENT '标题',
  `member_id` char(32) DEFAULT '0' COMMENT '作者uid',
  `intro` text COMMENT '简介',
  `path` varchar(200) DEFAULT '' COMMENT '路径(图片地址，或者原视频地址)',
  `m3u8` varchar(200) DEFAULT NULL COMMENT '视频分片地址',
  `url` varchar(200) NOT NULL DEFAULT '' COMMENT 'url地址。',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '1启用，2禁用，3待审核',
  `size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'byte',
  `long` int(11) DEFAULT '0' COMMENT '时长秒',
  `type` varchar(100) NOT NULL DEFAULT '' COMMENT '1图片2小说3视频',
  `top_num` int(11) unsigned DEFAULT '0' COMMENT '顶',
  `tread_num` int(11) unsigned DEFAULT '0' COMMENT '踩',
  `view_num` int(11) unsigned DEFAULT '0' COMMENT '浏览量',
  `addtime` int(11) unsigned NOT NULL,
  `adduser` int(32) NOT NULL,
  `uptime` int(11) unsigned NOT NULL,
  `upuser` char(32) NOT NULL DEFAULT '',
  `deltime` int(11) DEFAULT '0',
  `deluser` char(1) DEFAULT '0',
  PRIMARY KEY (`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `co_file` WRITE;
/*!40000 ALTER TABLE `co_file` DISABLE KEYS */;

INSERT INTO `co_file` (`file_id`, `title`, `member_id`, `intro`, `path`, `m3u8`, `url`, `status`, `size`, `long`, `type`, `top_num`, `tread_num`, `view_num`, `addtime`, `adduser`, `uptime`, `upuser`, `deltime`, `deluser`)
VALUES
	(1,'美女写真','0',NULL,'/upload/image/57/29/02/b6bac8489b7e8c7528a59657c0fb69a3.jpg',NULL,'',1,0,0,'1',NULL,NULL,NULL,1586208384,1,1586208384,'1',0,'0'),
	(2,'小鸟','0',NULL,'/upload/image/39/76/04/b6bac8489b7e8c7528a59657c0fb69a3.jpg',NULL,'',2,0,0,'1',NULL,NULL,NULL,1586233488,1,1586252435,'1',0,'0'),
	(3,'小鸟','0',NULL,'',NULL,'',2,0,0,'1',NULL,NULL,NULL,1586252109,1,1586252109,'1',1586252454,'1'),
	(4,'小鸟','0',NULL,'',NULL,'',1,0,0,'1',NULL,NULL,NULL,1586252196,1,1586252196,'1',1586252201,'1'),
	(5,'小鸟','0',NULL,'',NULL,'',1,0,0,'1',NULL,NULL,NULL,1586252229,1,1586252229,'1',1586252232,'1'),
	(6,'辣妈','0',NULL,'/upload/image/16/76/19/d1967c556b59e08be3a62c68c003b09e.jpg',NULL,'',1,132669,0,'1',NULL,NULL,NULL,1586252632,1,1586252632,'1',0,'0'),
	(7,'你怎么看','0',NULL,'/upload/image/67/52/85/b0be6d63747a34821f43884a988745be.jpg',NULL,'',1,368609,0,'1',NULL,NULL,NULL,1586252670,1,1586252670,'1',0,'0'),
	(8,' 斗破苍穹','0','&lt;p&gt;&lt;strong&gt;&amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp;收到鸣锣开道发卡斯蒂略卡送到家啦时间的鲁昆吉里卡世界大力士觉得卢卡斯嘉陵道街拉萨到发送空间的卡拉斯京打开了卡&lt;/strong&gt;&lt;/p&gt;','/upload/image/67/02/36/b6bac8489b7e8c7528a59657c0fb69a3.jpg',NULL,'',1,298038,0,'2',NULL,NULL,NULL,1586254887,1,1586254887,'1',0,'0'),
	(9,' 斗破苍穹','0','&lt;p&gt;&lt;strong&gt;&amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp;收到鸣锣开道发卡斯蒂略卡送到家啦时间的鲁昆吉里卡世界大力士觉得卢卡斯嘉陵道街拉萨到发送空间的卡拉斯京打开了卡&lt;/strong&gt;&lt;/p&gt;','/upload/image/67/02/36/b6bac8489b7e8c7528a59657c0fb69a3.jpg',NULL,'',1,298038,0,'2',NULL,NULL,NULL,1586324270,1,1586324270,'1',0,'0'),
	(10,'sadfasdasdasd','0',NULL,'/upload/video/19/29/84/706bfc2cfa453e405cf666fa0eb2802a.mp4','upload/m3u8/86/86/59/706bfc2cfa453e405cf666fa0eb2802a.mp4.m3u8','',1,9123837,163,'3',0,0,0,1586447812,1,1586447812,'1',0,'0'),
	(11,'yyyyyyyyy','0',NULL,'/upload/video/29/35/32/28f079daafc03d8c07b40a8b48ce0e9d.mp4','upload/m3u8/07/47/41/28f079daafc03d8c07b40a8b48ce0e9d.mp4.m3u8','',1,176496,6,'3',0,0,0,1586453516,1,1586453516,'1',0,'0'),
	(17,'eeeeeeeee','0',NULL,'/upload/video/49/44/45/2d3f18156fad9497c596d2d4f19d97ec.mp4','upload/m3u8/21/89/51/2d3f18156fad9497c596d2d4f19d97ec.mp4.m3u8','',1,8060123,60,'3',0,0,0,1586454249,1,1586454249,'1',0,'0'),
	(18,'RRRRRRRR','0',NULL,'/upload/video/08/94/50/4889798fc6ac69f6549586c969fddfce.mp4','upload/m3u8/20/50/83/4889798fc6ac69f6549586c969fddfce.mp4.m3u8','',1,56245164,436,'3',0,0,0,1586454345,1,1586454345,'1',0,'0'),
	(19,'RRRRRRRR','0',NULL,'/upload/video/08/94/50/4889798fc6ac69f6549586c969fddfce.mp4','upload/m3u8/37/71/19/4889798fc6ac69f6549586c969fddfce.mp4.m3u8','',1,56245164,436,'3',0,0,0,1586454366,1,1586454366,'1',0,'0');

/*!40000 ALTER TABLE `co_file` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table co_file_labe
# ------------------------------------------------------------

DROP TABLE IF EXISTS `co_file_labe`;

CREATE TABLE `co_file_labe` (
  `labe_id` int(11) NOT NULL,
  `file_id` int(11) NOT NULL,
  PRIMARY KEY (`labe_id`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `co_file_labe` WRITE;
/*!40000 ALTER TABLE `co_file_labe` DISABLE KEYS */;

INSERT INTO `co_file_labe` (`labe_id`, `file_id`)
VALUES
	(5,1),
	(5,2),
	(5,3),
	(5,4),
	(5,5),
	(5,18);

/*!40000 ALTER TABLE `co_file_labe` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table co_gallery
# ------------------------------------------------------------

DROP TABLE IF EXISTS `co_gallery`;

CREATE TABLE `co_gallery` (
  `gallery_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(300) NOT NULL DEFAULT '',
  `cover_img` varchar(300) NOT NULL DEFAULT '',
  `intro` text,
  `price` varchar(9) DEFAULT '0',
  `currency` varchar(10) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  `addtime` int(11) NOT NULL,
  `adduser` char(32) NOT NULL DEFAULT '',
  `uptime` int(11) NOT NULL,
  `upuser` char(32) NOT NULL DEFAULT '',
  `deltime` int(11) DEFAULT '0',
  `deluser` char(32) DEFAULT '0',
  PRIMARY KEY (`gallery_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `co_gallery` WRITE;
/*!40000 ALTER TABLE `co_gallery` DISABLE KEYS */;

INSERT INTO `co_gallery` (`gallery_id`, `title`, `cover_img`, `intro`, `price`, `currency`, `status`, `addtime`, `adduser`, `uptime`, `upuser`, `deltime`, `deluser`)
VALUES
	(1,'一号产品','/upload/image/95/52/69/9d8353c9fba7c8d3b2b35911ce4aecf0.jpg','&lt;ul&gt;&lt;li&gt;货号：K02&lt;/li&gt;&lt;li&gt;材质：pp&lt;/li&gt;&lt;li&gt;规格：225.4x197.4x41（mm）&lt;/li&gt;&lt;li&gt;容量：1000ml&lt;/li&gt;&lt;li&gt;包装数：80pcs&lt;/li&gt;&lt;li&gt;箱规：45.8x20.7x41.5（cm）&lt;/li&gt;&lt;/ul&gt;','222','CNY',1,1586577228,'1',1586579062,'1',0,'0'),
	(2,'二号产品','/upload/image/78/22/38/bb48734bf47c01ab8aff11ed303ab2d9.jpg','&lt;p&gt;在不少旁观者的眼里，智能化几乎成了一种避之唯恐不及的&ldquo;瘟疫&rdquo;，开始攀附上大大小小、各式各样的工具和设备，从水杯、灯泡、体重秤这样的小物件，再到冰箱、洗衣机这些生活中的庞然大物。&lt;/p&gt;\r\n&lt;p&gt;兜兜转转之后，这场&ldquo;瘟疫&rdquo;又找上了在生活中不那么起眼的自行车。然而，在搭上智能化的顺风车之前，你可知道自行车的历史？虽然，在乐视超级自行车的发布会上，它已经用了自行车史上有着重要地位的三个名字&mdash;&mdash;斯塔利、西夫拉克、阿尔普迪埃&mdash;&mdash;来命名自家的自行车，但那远远不够。Gizmodo 为我们梳理了自行车发展的关键节点。&lt;/p&gt;\r\n&lt;p&gt;在开始之前，我们先来看看丹麦的设计师制作的动画，一分钟看完自行车近 200 年的演变。&lt;/p&gt;\r\n&lt;p&gt;比较公认的说法是，第一辆自行车由法国手工艺人西夫拉克（M&eacute;d&eacute; de Sivrac）设计，在两个轮子上安装了支架并配上马鞍，前进的话需要用脚蹬地提供动力。这还只是一个很简单的雏形，没有方向舵，转弯的时候需要骑行者下车抬起前轮，稳定性也不好。&lt;/p&gt;\r\n&lt;p&gt;德国人杜莱斯（Karl Drais von Sauerbronn）制作了一辆和西夫拉克的设计相近的两轮车子，增加了车把，可以改变行进中的方向，速度可以达到 15km/h。不过，还是需要靠双脚蹬地提供动力。&lt;/p&gt;\r\n&lt;p&gt;这时候第一辆真正意义上的自行车诞生了，是由苏格兰铁匠麦克米伦（Kirkpatrik Macmillan）设计的，它还有一个专门的名字&mdash;&mdash;Velocipede。&lt;/p&gt;\r\n&lt;p&gt;在不少旁观者的眼里，智能化几乎成了一种避之唯恐不及的&ldquo;瘟疫&rdquo;，开始攀附上大大小小、各式各样的工具和设备，从水杯、灯泡、体重秤这样的小物件，再到冰箱、洗衣机这些生活中的庞然大物。&lt;/p&gt;\r\n&lt;p&gt;兜兜转转之后，这场&ldquo;瘟疫&rdquo;又找上了在生活中不那么起眼的自行车。然而，在搭上智能化的顺风车之前，你可知道自行车的历史？虽然，在乐视超级自行车的发布会上，它已经用了自行车史上有着重要地位的三个名字&mdash;&mdash;斯塔利、西夫拉克、阿尔普迪埃&mdash;&mdash;来命名自家的自行车，但那远远不够。Gizmodo 为我们梳理了自行车发展的关键节点。&lt;/p&gt;\r\n&lt;p&gt;在开始之前，我们先来看看丹麦的设计师制作的动画，一分钟看完自行车近 200 年的演变。&lt;/p&gt;\r\n&lt;p&gt;比较公认的说法是，第一辆自行车由法国手工艺人西夫拉克（M&eacute;d&eacute; de Sivrac）设计，在两个轮子上安装了支架并配上马鞍，前进的话需要用脚蹬地提供动力。这还只是一个很简单的雏形，没有方向舵，转&lt;/p&gt;','9999.90','CNY',1,1586578930,'1',1586578930,'1',1586579018,'1'),
	(3,'一号产品','/upload/image/77/70/18/09f3f088a266836dd6802f710034bd47.jpg','&lt;p&gt;&amp;nbsp; &amp;nbsp; &amp;nbsp;&amp;nbsp;高品质的生活是我们每个人的追求，即使就只有我们一个人我们依旧想要享受最为舒适自在的生活。放松休息是我们在劳累了一天回到家里最希望做的事，所以一个舒适的单人沙发是必不可少的。沙发并不是大家认为的只有多人才会实用，单人沙发依旧能够带来意想不到的实用效果。可能有些朋友还没有使用过单人沙发，在这里可以给大家介绍一下它的特点以及比较不错的单人沙发品牌。&lt;/p&gt;','99.99','USD',1,1586580359,'1',1586580359,'1',0,'0'),
	(4,'三号产品','/upload/image/76/08/20/f9c05d737fb888615e8c08ce24d4f925.jpg','&lt;p&gt;&amp;nbsp; &amp;nbsp; &amp;nbsp;&amp;nbsp;高品质的生活是我们每个人的追求，即使就只有我们一个人我们依旧想要享受最为舒适自在的生活。放松休息是我们在劳累了一天回到家里最希望做的事，所以一个舒适的单人沙发是必不可少的。沙发并不是大家认为的只有多人才会实用，单人沙发依旧能够带来意想不到的实用效果。可能有些朋友还没有使用过单人沙发，在这里可以给大家介绍一下它的特点以及比较不错的单人沙发品牌。&lt;/p&gt;','88.99','USD',1,1586580406,'1',1586580406,'1',0,'0'),
	(5,'四号产品','/upload/image/56/29/66/d4cb764091f1d05095b288f68db819d7.jpg','&lt;p&gt;&amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp;高品质的生活是我们每个人的追求，即使就只有我们一个人我们依旧想要享受最为舒适自在的生活。放松休息是我们在劳累了一天回到家里最希望做的事，所以一个舒适的单人沙发是必不可少的。沙发并不是大家认为的只有多人才会实用，单人沙发依旧能够带来意想不到的实用效果。可能有些朋友还没有使用过单人沙发，在这里可以给大家介绍一下它的特点以及比较不错的单人沙发品牌。&lt;/p&gt;','199.99','USD',1,1586580441,'1',1586580441,'1',0,'0'),
	(6,'五号产品','/upload/image/98/77/33/89fa0e7f55a9631ebda22e84a723cb3a.jpg','&lt;p&gt;&amp;nbsp; &amp;nbsp;&amp;nbsp;高品质的生活是我们每个人的追求，即使就只有我们一个人我们依旧想要享受最为舒适自在的生活。放松休息是我们在劳累了一天回到家里最希望做的事，所以一个舒适的单人沙发是必不可少的。沙发并不是大家认为的只有多人才会实用，单人沙发依旧能够带来意想不到的实用效果。可能有些朋友还没有使用过单人沙发，在这里可以给大家介绍一下它的特点以及比较不错的单人沙发品牌。&lt;/p&gt;','299.90','USD',1,1586580826,'1',1586580826,'1',0,'0'),
	(7,'六号产品','/upload/image/47/29/44/dd7b5eff5a31b171aeeba836430d2763.jpg','&lt;p&gt;&amp;nbsp; &amp;nbsp;&amp;nbsp;高品质的生活是我们每个人的追求，即使就只有我们一个人我们依旧想要享受最为舒适自在的生活。放松休息是我们在劳累了一天回到家里最希望做的事，所以一个舒适的单人沙发是必不可少的。沙发并不是大家认为的只有多人才会实用，单人沙发依旧能够带来意想不到的实用效果。可能有些朋友还没有使用过单人沙发，在这里可以给大家介绍一下它的特点以及比较不错的单人沙发品牌。&lt;/p&gt;','188.12','USD',1,1586580865,'1',1586580865,'1',0,'0'),
	(8,'七号产品','/upload/image/81/64/81/41e4936928bc73bed1ee60a33eb34f81.jpg','&lt;p&gt;&amp;nbsp; &amp;nbsp; &amp;nbsp;&amp;nbsp;高品质的生活是我们每个人的追求，即使就只有我们一个人我们依旧想要享受最为舒适自在的生活。放松休息是我们在劳累了一天回到家里最希望做的事，所以一个舒适的单人沙发是必不可少的。沙发并不是大家认为的只有多人才会实用，单人沙发依旧能够带来意想不到的实用效果。可能有些朋友还没有使用过单人沙发，在这里可以给大家介绍一下它的特点以及比较不错的单人沙发品牌。&lt;/p&gt;','99','USD',1,1586580928,'1',1586580928,'1',0,'0');

/*!40000 ALTER TABLE `co_gallery` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table co_image_attach
# ------------------------------------------------------------

DROP TABLE IF EXISTS `co_image_attach`;

CREATE TABLE `co_image_attach` (
  `attach_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '图片关联表ID',
  `target_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '对象id-外键',
  `target_type` varchar(20) NOT NULL DEFAULT '0' COMMENT '对象类型',
  `image_id` char(32) NOT NULL DEFAULT '0' COMMENT '图片的主键-外键关联image表',
  `last_modified` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`attach_id`),
  KEY `index_1` (`target_id`,`target_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table co_images
# ------------------------------------------------------------

DROP TABLE IF EXISTS `co_images`;

CREATE TABLE `co_images` (
  `image_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(200) DEFAULT NULL,
  `path` varchar(300) NOT NULL DEFAULT '' COMMENT '本地路径',
  `url` varchar(500) DEFAULT '' COMMENT '互联网地址 ',
  `size` varchar(10) DEFAULT NULL COMMENT '大小kb',
  `type` int(11) DEFAULT NULL COMMENT '1动图，2图片，3动画',
  `status` int(11) DEFAULT NULL COMMENT '1启用，2禁用，3待审核',
  `addtime` int(11) NOT NULL,
  `adduser` char(32) NOT NULL DEFAULT '',
  `uptime` int(11) NOT NULL,
  `upuser` char(32) NOT NULL DEFAULT '',
  `deltime` int(11) DEFAULT '0',
  `deluser` char(32) DEFAULT '0',
  PRIMARY KEY (`image_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table co_labes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `co_labes`;

CREATE TABLE `co_labes` (
  `labe_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `labe_name` varchar(30) DEFAULT NULL,
  `addtime` int(11) NOT NULL,
  `adduser` char(32) NOT NULL DEFAULT '',
  `uptime` int(11) NOT NULL,
  `upuser` char(32) NOT NULL DEFAULT '',
  `deltime` int(11) DEFAULT '0',
  `deluser` char(32) DEFAULT '0',
  PRIMARY KEY (`labe_id`),
  UNIQUE KEY `labe_name` (`labe_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `co_labes` WRITE;
/*!40000 ALTER TABLE `co_labes` DISABLE KEYS */;

INSERT INTO `co_labes` (`labe_id`, `labe_name`, `addtime`, `adduser`, `uptime`, `upuser`, `deltime`, `deluser`)
VALUES
	(5,'香港',1586189502,'1',1586189502,'1',0,'0');

/*!40000 ALTER TABLE `co_labes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table co_login_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `co_login_log`;

CREATE TABLE `co_login_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `session_id` varchar(60) DEFAULT '' COMMENT '用户登陆session_id ',
  `app_token` char(64) DEFAULT NULL,
  `status` tinyint(1) unsigned NOT NULL COMMENT '1登陆成功2登录失败',
  `login_ip` varchar(20) DEFAULT NULL COMMENT '登陆IP地址',
  `username` varchar(100) DEFAULT NULL COMMENT '登陆用户名称',
  `login_time` int(10) unsigned NOT NULL COMMENT '登陆时间',
  `login_uid` char(32) NOT NULL DEFAULT '0' COMMENT '登陆用户id',
  `agent` varchar(1000) DEFAULT NULL COMMENT '浏览器信息',
  `user_type` enum('admin','member') NOT NULL DEFAULT 'admin' COMMENT 'admin后台用户',
  `remark` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `co_login_log` WRITE;
/*!40000 ALTER TABLE `co_login_log` DISABLE KEYS */;

INSERT INTO `co_login_log` (`id`, `session_id`, `app_token`, `status`, `login_ip`, `username`, `login_time`, `login_uid`, `agent`, `user_type`, `remark`)
VALUES
	(1,'ka4n0rp0es5tlsva5c290rc1o6',NULL,1,'127.0.0.1','admin',1541652488,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36','admin',NULL),
	(2,'ka4n0rp0es5tlsva5c290rc1o6',NULL,1,'127.0.0.1','gangkui003',1541652713,'6','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36','admin',NULL),
	(3,'ka4n0rp0es5tlsva5c290rc1o6',NULL,1,'127.0.0.1','gangkui003',1541663249,'6','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36','admin',NULL),
	(4,'ka4n0rp0es5tlsva5c290rc1o6',NULL,1,'127.0.0.1','gangkui003',1541663463,'6','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36','admin',NULL),
	(5,'ka4n0rp0es5tlsva5c290rc1o6',NULL,2,'127.0.0.1','gangkui002',1541663594,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36','admin','用户名或者密码错误'),
	(6,'ka4n0rp0es5tlsva5c290rc1o6',NULL,2,'127.0.0.1','gangkui002',1541663599,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36','admin','用户名或者密码错误'),
	(7,'ka4n0rp0es5tlsva5c290rc1o6',NULL,1,'127.0.0.1','gangkui001',1541663626,'11','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36','admin',NULL),
	(8,'ka4n0rp0es5tlsva5c290rc1o6',NULL,1,'127.0.0.1','admin',1541666475,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36','admin',NULL),
	(9,'ka4n0rp0es5tlsva5c290rc1o6',NULL,1,'127.0.0.1','admin',1541666669,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36','admin',NULL),
	(10,'3es2dhof7u9qa27gko6384i9t7',NULL,2,'127.0.0.1','gangkui001',1541670999,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0 Safari/605.1.15','admin','用户名或者密码错误'),
	(11,'3es2dhof7u9qa27gko6384i9t7',NULL,1,'127.0.0.1','gangkui001',1541671024,'11','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0 Safari/605.1.15','admin',NULL),
	(12,'ka4n0rp0es5tlsva5c290rc1o6',NULL,1,'127.0.0.1','admin',1541671184,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36','admin',NULL),
	(13,'ka4n0rp0es5tlsva5c290rc1o6',NULL,1,'127.0.0.1','admin',1541671923,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36','admin',NULL),
	(14,'ka4n0rp0es5tlsva5c290rc1o6',NULL,1,'127.0.0.1','gangkui001',1541671952,'11','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36','admin',NULL),
	(15,'ka4n0rp0es5tlsva5c290rc1o6',NULL,1,'127.0.0.1','gangkui001',1541672566,'11','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36','admin',NULL),
	(16,'ka4n0rp0es5tlsva5c290rc1o6',NULL,1,'127.0.0.1','gangkui001',1541673499,'11','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36','admin',NULL),
	(17,'myprefix-brcmrvlo54bapnm4hm8mqjact6',NULL,1,'127.0.0.1','gangkui001',1542114074,'11','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36','admin',NULL),
	(18,'t6ju3io3uj97dbusfcrucgnb45',NULL,1,'127.0.0.1','admin',1542255720,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(19,'fs1lr2kerrlagmsmns1210e5j3',NULL,1,'127.0.0.1','admin',1542255731,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(20,'k3e6sb9n872ocrhbgas18svao0',NULL,1,'127.0.0.1','admin',1542255781,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(21,'gad4an9vbc5a7h619r4uc8bi12',NULL,1,'127.0.0.1','admin',1542256020,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(22,'3soob4n9q2igqup2lucb04mks3',NULL,1,'127.0.0.1','admin',1542256070,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(23,'fb8p8cmd39hiqc2nt30u21qpa1',NULL,1,'127.0.0.1','admin',1542256273,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(24,'i0f9dcgti8qk0pomone3222fq7',NULL,1,'127.0.0.1','admin',1542256281,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(25,'e3k56iobiveacg9hvlo79k3600',NULL,1,'127.0.0.1','admin',1542256356,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(26,'v2ba02m7e69cu1p299r45vqev2',NULL,1,'127.0.0.1','admin',1542256396,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(27,'1tti0a2lmlcu04cs3upk3cd8c2',NULL,1,'127.0.0.1','admin',1542256465,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(28,'myprefix-brcmrvlo54bapnm4hm8mqjact6',NULL,1,'127.0.0.1','admin',1542256558,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(29,'myprefix-brcmrvlo54bapnm4hm8mqjact6',NULL,1,'127.0.0.1','admin',1542256880,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(30,'9jp4p7vpt8f61q0m4lmu3ngk90',NULL,1,'127.0.0.1','admin',1542256959,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(31,'jepgibupjem1hc93n154vogvj2',NULL,1,'127.0.0.1','admin',1542256965,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(32,'uhtk8inecd8p2aciu0tg2k2e93',NULL,1,'127.0.0.1','admin',1542256993,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(33,'4ma9opvlqb9n3tupsiv3v9a3f5',NULL,1,'127.0.0.1','admin',1542257064,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(34,'tai3urqrlg2g12pn5cl17cb9l2',NULL,1,'127.0.0.1','admin',1542257100,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(35,'s04qkivuh4dk79h338sa2npgm6',NULL,1,'127.0.0.1','admin',1542257155,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(36,'psaq6a4p8n3276f0c9i83keku3',NULL,1,'127.0.0.1','admin',1542257181,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(37,'3ccvnrhhhqd8mng4mj9hs5i113',NULL,1,'127.0.0.1','admin',1542257258,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(38,'tmr1e4l9v91ersgeg82jqf5k10',NULL,1,'127.0.0.1','admin',1542257306,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(39,'myprefix-brcmrvlo54bapnm4hm8mqjact6',NULL,1,'127.0.0.1','admin',1542257397,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(40,'8dgblmo9tnpg28m5mk6pd07hc4',NULL,1,'127.0.0.1','admin',1542257418,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(41,'71pu3jiqh12bcf4lanmipq5dj5',NULL,1,'127.0.0.1','admin',1542257425,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(42,'b0ee2j87jodesemkcr6ldhknq4',NULL,1,'127.0.0.1','admin',1542257466,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(43,'s8c3gt8p1ioas0j32fi4pb4mg4',NULL,1,'127.0.0.1','admin',1542257548,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(44,'6perv7psdbs195mb8gg6pak5l0',NULL,1,'127.0.0.1','admin',1542257661,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(45,'cgj5da5tfsl9oe4ua20oarn587',NULL,1,'127.0.0.1','admin',1542257667,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(46,'lsqpd5rf50si39cmma0dvkdpi2',NULL,1,'127.0.0.1','admin',1542266764,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(47,'v0qqpe5l32ja5nvh503qmsmi61',NULL,1,'127.0.0.1','admin',1542266765,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(48,'cfb94rqasarkkmac9hh8in1i17',NULL,1,'127.0.0.1','admin',1542266803,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(49,'gqjfkrfroqmei6rr3mgdqegq30',NULL,1,'127.0.0.1','admin',1542266852,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(50,'tp7uvagdijosn6qpo1a3irfdt7',NULL,1,'127.0.0.1','admin',1542266999,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(51,'t2tsnr9lfst4oogqb860272id5',NULL,1,'127.0.0.1','admin',1542267276,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(52,'myprefix-brcmrvlo54bapnm4hm8mqjact6',NULL,1,'127.0.0.1','admin',1542267334,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(53,'kbc1op51k73dn7au7raffq4cr4',NULL,1,'127.0.0.1','admin',1542268392,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(54,'v9fhvisuumdf05u4vjelj94m21',NULL,1,'127.0.0.1','admin',1542360186,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(55,'53lkms8qpucb33a957oq172jf3',NULL,1,'127.0.0.1','admin',1542360275,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(56,'09r243kn1ltpbsms327igrjmn1',NULL,1,'127.0.0.1','admin',1542360281,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(57,'gt0befg5ng88s6ogp45r9skb87',NULL,1,'127.0.0.1','admin',1542360297,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(58,'796pf1ibif71kgkdjc5eqc3pm0',NULL,1,'127.0.0.1','admin',1542360348,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(59,'3b1q88neo8p7uld5fa4t58ie41',NULL,1,'127.0.0.1','admin',1542360359,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(60,'cmgv414fhdgg03ne2ac6alelp6',NULL,1,'127.0.0.1','admin',1542360406,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(61,'dl6p36j67o55lh9ol55pd0rtk1',NULL,1,'127.0.0.1','admin',1542360492,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(62,'245uah9gpr2r1ia0n0o284u7r0',NULL,1,'127.0.0.1','admin',1542369258,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(63,'q1a30ltml5nr7qfk2oeg380e83',NULL,1,'127.0.0.1','admin',1542425736,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(64,'8n2bj4ht9hv006g2vqk0mdvjo2',NULL,1,'127.0.0.1','admin',1542623928,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(65,'oceufq48junehgmvdgvr715292',NULL,1,'127.0.0.1','admin',1542806409,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36','admin',NULL),
	(66,'e5j04cr7lk7oufn7i5v21o8a54',NULL,1,'127.0.0.1','admin',1543549074,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Safari/537.36','admin',NULL),
	(67,'b3rp4598u8r1e9mo5cp26q4t85',NULL,1,'127.0.0.1','admin',1545817751,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36','admin',NULL),
	(68,'eg0h75o3ovobqgcfes2pcfbbl2',NULL,1,'127.0.0.1','admin',1545829619,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36','admin',NULL),
	(69,'s74kf4mo9ts3ks0l6v5secchn0',NULL,2,'127.0.0.1','admin',1545898398,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:64.0) Gecko/20100101 Firefox/64.0','admin','用户名或者密码错误'),
	(70,'s74kf4mo9ts3ks0l6v5secchn0',NULL,1,'127.0.0.1','admin',1545898408,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:64.0) Gecko/20100101 Firefox/64.0','admin',NULL),
	(71,'6je5opa88ljsvv1n7n5rm7g953',NULL,1,'127.0.0.1','admin',1545900420,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36','admin',NULL),
	(72,'1ln6fjjrbina5s5du131meuts4',NULL,1,'127.0.0.1','admin',1564542585,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Safari/537.36','admin',NULL),
	(73,'in7pj989hkpdcpkbgpacqnu0l0',NULL,1,'127.0.0.1','admin',1564634313,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.142 Safari/537.36','admin',NULL),
	(74,'pi98q3nt376ur0caultto706us',NULL,1,'127.0.0.1','admin',1570765439,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36','admin',NULL),
	(75,'pi98q3nt376ur0caultto706us',NULL,1,'127.0.0.1','admin',1570765475,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36','admin',NULL),
	(76,'pi98q3nt376ur0caultto706us',NULL,1,'127.0.0.1','admin',1570765912,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36','admin',NULL),
	(77,'pi98q3nt376ur0caultto706us',NULL,1,'127.0.0.1','admin',1570766231,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36','admin',NULL),
	(78,'fl7cp105e12ldfjc3hpccb0lf2',NULL,1,'127.0.0.1','admin',1570787554,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36','admin',NULL),
	(79,'as122ti9nuc8tlonrq0ml3ucn8',NULL,1,'127.0.0.1','admin',1570855937,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36','admin',NULL),
	(80,'brplbb6pub9ck2iiqndkv2dt4t',NULL,1,'127.0.0.1','admin',1570872083,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36','admin',NULL),
	(81,'s59f51fej7rfm505t91kok11ve',NULL,1,'127.0.0.1','admin',1571052232,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36','admin',NULL),
	(82,'guh59igealt57qmtbhnh1ka8eq',NULL,1,'127.0.0.1','admin',1571111611,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36','admin',NULL),
	(83,'61c40jq4jttgqilu7n9eqdkf32',NULL,1,'127.0.0.1','admin',1571126625,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36','admin',NULL),
	(84,'qnsso83iskgd6bcj640lm725fp',NULL,1,'127.0.0.1','admin',1571142399,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36','admin',NULL),
	(85,'77tbiadi2elupln0a8m62ptedt',NULL,1,'127.0.0.1','admin',1571197304,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36','admin',NULL),
	(86,'vfasl6scaepmd66a42q03v4mjg',NULL,1,'127.0.0.1','admin',1571211730,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36','admin',NULL),
	(87,'q6ptfqcnb15jfrd7nm8l4tef90',NULL,1,'127.0.0.1','admin',1571283678,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36','admin',NULL),
	(88,'hobbbakattdgtiravfodg77e6b',NULL,1,'127.0.0.1','admin',1571303372,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36','admin',NULL),
	(89,'hobbbakattdgtiravfodg77e6b',NULL,1,'127.0.0.1','admin',1571303379,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36','admin',NULL),
	(90,'kdvovgtarfptarpbemenhohmsd',NULL,1,'127.0.0.1','admin',1571316227,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36','admin',NULL),
	(91,'f7b7pqjgrtl0jtts2o5jf1oipc',NULL,1,'127.0.0.1','admin',1571650684,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36','admin',NULL),
	(92,'dmpgmt7fgh7loal6mrq5p1r9p7',NULL,1,'127.0.0.1','admin',1571665539,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.90 Safari/537.36','admin',NULL),
	(93,'ciaq6htmg3h2ultjh54h5655a6',NULL,1,'127.0.0.1','admin',1571716893,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(94,'c9di87jf9b47b2o3d762ar6a9n',NULL,1,'127.0.0.1','admin',1571729216,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(95,'tn96efsrolmi32omps3nr35l66',NULL,1,'127.0.0.1','admin',1571748633,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(96,'0t88epl7faj46jav4unncpc3fh',NULL,1,'127.0.0.1','admin',1571800309,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(97,'vmcffcagbm6ttdjthdu0eg9en4',NULL,1,'127.0.0.1','admin',1571815514,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(98,'5nqn3k48cd8rmfuojhh18ela5r',NULL,1,'127.0.0.1','admin',1571834652,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(99,'dmhq0v7bmtpsiv5alv886tpg1v',NULL,1,'127.0.0.1','admin',1571905045,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(100,'j3pejpsj8skfa33bb9jothv12a',NULL,1,'127.0.0.1','admin',1571922544,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(101,'12in3ibqjv357o3tp0vivqo7a1',NULL,1,'127.0.0.1','admin',1571972594,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(102,'12in3ibqjv357o3tp0vivqo7a1',NULL,1,'127.0.0.1','admin',1571975639,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(103,'12in3ibqjv357o3tp0vivqo7a1',NULL,1,'127.0.0.1','admin',1571975807,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(104,'12in3ibqjv357o3tp0vivqo7a1',NULL,1,'127.0.0.1','admin',1571976483,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(105,'12in3ibqjv357o3tp0vivqo7a1',NULL,1,'127.0.0.1','admin',1571976525,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(106,'12in3ibqjv357o3tp0vivqo7a1',NULL,1,'127.0.0.1','admin',1571976864,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(107,'12in3ibqjv357o3tp0vivqo7a1',NULL,1,'127.0.0.1','admin',1571976904,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(108,'12in3ibqjv357o3tp0vivqo7a1',NULL,1,'127.0.0.1','admin',1571976920,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(109,'12in3ibqjv357o3tp0vivqo7a1',NULL,1,'127.0.0.1','admin',1571976941,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(110,'12in3ibqjv357o3tp0vivqo7a1',NULL,1,'127.0.0.1','admin',1571977131,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(111,'12in3ibqjv357o3tp0vivqo7a1',NULL,2,'127.0.0.1','admin1',1571978194,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin','用户名或者密码错误'),
	(112,'12in3ibqjv357o3tp0vivqo7a1',NULL,1,'127.0.0.1','admin',1571978308,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(113,'12in3ibqjv357o3tp0vivqo7a1',NULL,1,'127.0.0.1','admin',1571978603,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(114,'12in3ibqjv357o3tp0vivqo7a1',NULL,1,'127.0.0.1','admin',1571978907,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(115,'12in3ibqjv357o3tp0vivqo7a1',NULL,1,'127.0.0.1','admin',1571979036,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(116,'curc868u8msgpdg02gtsqrp1ai',NULL,1,'127.0.0.1','admin',1571987155,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(117,'73m6dqbbmlgv0abct25ocliloq',NULL,1,'127.0.0.1','admin',1572008316,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(118,'3av3us71ctdjf818r1vmh1e50v',NULL,1,'127.0.0.1','admin',1572116084,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.131 Safari/537.36','admin',NULL),
	(119,'atsgnqq63seoo8inkl773lqjgj',NULL,1,'127.0.0.1','admin',1572156860,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.131 Safari/537.36','admin',NULL),
	(120,'2agl7ursu7g9rvp38uejsblbu9',NULL,1,'127.0.0.1','admin',1572171804,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.131 Safari/537.36','admin',NULL),
	(121,'7rp0j0aold5d9vbb98lrs85s26',NULL,1,'127.0.0.1','admin',1572451684,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.131 Safari/537.36','admin',NULL),
	(122,'vsm7fnvsvdtjkpf9ts1s3s352j',NULL,1,'127.0.0.1','gangkui',1572492667,'ed79914ea512d38bc1bbb9d7199a3af0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(123,'vsm7fnvsvdtjkpf9ts1s3s352j',NULL,1,'127.0.0.1','gangkui',1572492728,'ed79914ea512d38bc1bbb9d7199a3af0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(124,'vsm7fnvsvdtjkpf9ts1s3s352j',NULL,1,'127.0.0.1','gangkui',1572492768,'ed79914ea512d38bc1bbb9d7199a3af0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(125,'vsm7fnvsvdtjkpf9ts1s3s352j',NULL,1,'127.0.0.1','gangkui',1572493028,'ed79914ea512d38bc1bbb9d7199a3af0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(126,'vsm7fnvsvdtjkpf9ts1s3s352j',NULL,1,'127.0.0.1','gangkui',1572493149,'ed79914ea512d38bc1bbb9d7199a3af0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(127,'vsm7fnvsvdtjkpf9ts1s3s352j',NULL,1,'127.0.0.1','gangkui',1572493159,'ed79914ea512d38bc1bbb9d7199a3af0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(128,'vsm7fnvsvdtjkpf9ts1s3s352j',NULL,1,'127.0.0.1','gangkui',1572494577,'ed79914ea512d38bc1bbb9d7199a3af0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(129,'vsm7fnvsvdtjkpf9ts1s3s352j',NULL,1,'127.0.0.1','gangkui',1572494594,'ed79914ea512d38bc1bbb9d7199a3af0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(130,'vsm7fnvsvdtjkpf9ts1s3s352j',NULL,1,'127.0.0.1','gangkui',1572494708,'ed79914ea512d38bc1bbb9d7199a3af0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(131,'vsm7fnvsvdtjkpf9ts1s3s352j',NULL,2,'127.0.0.1','gangkui',1572497504,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin','用户名或者密码错误'),
	(132,'vsm7fnvsvdtjkpf9ts1s3s352j',NULL,1,'127.0.0.1','admin',1572497514,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(133,'vsm7fnvsvdtjkpf9ts1s3s352j',NULL,1,'127.0.0.1','admin',1572497680,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(134,'3an90dtnfk48kj9knuu0cfi7vk',NULL,1,'127.0.0.1','gangkui',1572505460,'ed79914ea512d38bc1bbb9d7199a3af0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(135,'bh3qqs3ul3o218vdcjkqu6nt57',NULL,1,'127.0.0.1','gangkui',1572519844,'ed79914ea512d38bc1bbb9d7199a3af0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(136,'o5grn58acf86j5ke22g53sjjai',NULL,2,'127.0.0.1','gangkui',1573207363,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin','用户名或者密码错误'),
	(137,'o5grn58acf86j5ke22g53sjjai',NULL,2,'127.0.0.1','admin',1573207371,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin','用户名或者密码错误'),
	(138,'o5grn58acf86j5ke22g53sjjai',NULL,2,'127.0.0.1','',1573209006,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin','用户名或者密码错误'),
	(139,'o5grn58acf86j5ke22g53sjjai',NULL,2,'127.0.0.1','',1573209010,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin','用户名或者密码错误'),
	(140,'o5grn58acf86j5ke22g53sjjai',NULL,2,'127.0.0.1','',1573210840,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin','用户名或者密码错误'),
	(141,'o5grn58acf86j5ke22g53sjjai',NULL,2,'127.0.0.1','',1573210846,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin','用户名或者密码错误'),
	(142,'o5grn58acf86j5ke22g53sjjai',NULL,2,'127.0.0.1','',1573210886,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin','用户名或者密码错误'),
	(143,'o5grn58acf86j5ke22g53sjjai',NULL,2,'127.0.0.1','',1573210891,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin','用户名或者密码错误'),
	(144,'o5grn58acf86j5ke22g53sjjai',NULL,2,'127.0.0.1','',1573210970,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin','用户名或者密码错误'),
	(145,'o5grn58acf86j5ke22g53sjjai',NULL,2,'127.0.0.1','',1573210974,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin','用户名或者密码错误'),
	(146,'o5grn58acf86j5ke22g53sjjai',NULL,2,'127.0.0.1','admin',1573211047,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin','用户名或者密码错误'),
	(147,'o5grn58acf86j5ke22g53sjjai',NULL,2,'127.0.0.1','admin',1573211051,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin','用户名或者密码错误'),
	(148,'ttmt6pqhte8ls32a48al8b0jf6',NULL,2,'127.0.0.1','admin',1573217994,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin','用户名或者密码错误'),
	(149,'ttmt6pqhte8ls32a48al8b0jf6',NULL,2,'127.0.0.1','admin',1573218131,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin','用户名或者密码错误'),
	(150,'3el3s0dgq6dvorlmv8majaq907',NULL,1,'127.0.0.1','admin',1573271531,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(151,'3el3s0dgq6dvorlmv8majaq907',NULL,1,'127.0.0.1','admin',1573271536,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(152,'8pbdi9gjpokruveo4ss2c1iu1r',NULL,2,'127.0.0.1','admin',1573286384,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin','用户名或者密码错误'),
	(153,'8pbdi9gjpokruveo4ss2c1iu1r',NULL,2,'127.0.0.1','admin',1573286387,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin','用户名或者密码错误'),
	(154,'8pbdi9gjpokruveo4ss2c1iu1r','',1,'127.0.0.1','admin',1573287650,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(155,'8pbdi9gjpokruveo4ss2c1iu1r',NULL,2,'127.0.0.1','',1573296217,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin','用户名或者密码错误'),
	(156,'8pbdi9gjpokruveo4ss2c1iu1r',NULL,2,'127.0.0.1','',1573296238,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin','用户名或者密码错误'),
	(157,'8pbdi9gjpokruveo4ss2c1iu1r',NULL,2,'127.0.0.1','',1573296249,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin','用户名或者密码错误'),
	(158,'8pbdi9gjpokruveo4ss2c1iu1r',NULL,2,'127.0.0.1','',1573296250,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin','用户名或者密码错误'),
	(159,'8pbdi9gjpokruveo4ss2c1iu1r',NULL,2,'127.0.0.1','',1573296316,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin','用户名或者密码错误'),
	(160,'8pbdi9gjpokruveo4ss2c1iu1r',NULL,2,'127.0.0.1','',1573296331,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin','用户名或者密码错误'),
	(161,'8pbdi9gjpokruveo4ss2c1iu1r',NULL,2,'127.0.0.1','',1573296332,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin','用户名或者密码错误'),
	(162,'8pbdi9gjpokruveo4ss2c1iu1r',NULL,2,'127.0.0.1','',1573296332,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin','用户名或者密码错误'),
	(163,'8pbdi9gjpokruveo4ss2c1iu1r',NULL,2,'127.0.0.1','',1573296332,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin','用户名或者密码错误'),
	(164,'8pbdi9gjpokruveo4ss2c1iu1r',NULL,2,'127.0.0.1','',1573296416,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin','用户名或者密码错误'),
	(165,'8pbdi9gjpokruveo4ss2c1iu1r',NULL,2,'127.0.0.1','',1573296454,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin','用户名或者密码错误'),
	(166,'8pbdi9gjpokruveo4ss2c1iu1r',NULL,2,'127.0.0.1','',1573296483,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin','用户名或者密码错误'),
	(167,'8pbdi9gjpokruveo4ss2c1iu1r',NULL,2,'127.0.0.1','',1573296498,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin','用户名或者密码错误'),
	(168,'8pbdi9gjpokruveo4ss2c1iu1r',NULL,2,'127.0.0.1','',1573296512,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin','用户名或者密码错误'),
	(169,'','',1,'127.0.0.1','admin',1573296585,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(170,'','',1,'127.0.0.1','admin',1573296746,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(171,'','',1,'127.0.0.1','admin',1573297694,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(172,'','',1,'127.0.0.1','admin',1573297701,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(173,'','',1,'127.0.0.1','admin',1573297711,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(174,'','',1,'127.0.0.1','admin',1573464988,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(175,'','',1,'127.0.0.1','admin',1573465390,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(176,'','',1,'127.0.0.1','admin',1573465499,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(177,'','',1,'127.0.0.1','admin',1573465588,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(178,'','',1,'127.0.0.1','admin',1573465606,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(179,'','',1,'127.0.0.1','admin',1573465609,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(180,'','yTg0LuL85fAE10vBc4ca4238a0b923820dcc509a6f75849bZAzDCBjzUxPmuUOv',1,'127.0.0.1','admin',1573465730,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(181,'','jfCa2v6rHwbbSrh2c4ca4238a0b923820dcc509a6f75849bWamzphNwmlEeXKSt',1,'127.0.0.1','admin',1573465746,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(182,'','AoYTqBpH77vVjsw7c4ca4238a0b923820dcc509a6f75849bDRGKEcim2TqaJlXq',1,'127.0.0.1','admin',1573465751,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(183,'','IXueZvG6Es5LaNsoc4ca4238a0b923820dcc509a6f75849bMVgZr1sZ4rG3TDXp',1,'127.0.0.1','admin',1573480521,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(184,'','yfUXaCEFOm4rxeSRc4ca4238a0b923820dcc509a6f75849bpDEY25uOoqEsMgG3',1,'127.0.0.1','admin',1573480538,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(185,'','KUTmRkQbQb5hz8sUc4ca4238a0b923820dcc509a6f75849bILcOJunECGdXfcfR',1,'127.0.0.1','admin',1573480538,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(186,'','RaywpI9mgwjXAJorc4ca4238a0b923820dcc509a6f75849ba7Zpg5dnk2wAOAOJ',1,'127.0.0.1','admin',1573480538,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(187,'','P8d8RBTgSwgjqUa4c4ca4238a0b923820dcc509a6f75849bQN5hYsmHNyMZnIj0',1,'127.0.0.1','admin',1573480540,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(188,'','gzPQggtbOJ19eI5pc4ca4238a0b923820dcc509a6f75849bnhQalEUlQI7VKJm2',1,'127.0.0.1','admin',1573532571,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(189,'kobr5cp2v7cm3amdqgkgln7kcn','',1,'127.0.0.1','admin',1573617234,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(190,'','Kz9AQqpEk8rMfryrc4ca4238a0b923820dcc509a6f75849b0duivIvaYa7emFro',1,'127.0.0.1','admin',1573631672,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36','admin',NULL),
	(191,'1sne14aagdvbnk9npacf7ij4l4',NULL,2,'127.0.0.1','',1573807915,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Safari/605.1.15','admin','用户名或者密码错误'),
	(192,'1sne14aagdvbnk9npacf7ij4l4',NULL,2,'127.0.0.1','',1573807925,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Safari/605.1.15','admin','用户名或者密码错误'),
	(193,'','xatCWQ0FYvSdzZVkc4ca4238a0b923820dcc509a6f75849bdDwfBLIvKoscUmbl',1,'127.0.0.1','admin',1573808036,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Safari/605.1.15','admin',NULL),
	(194,'','Lo9K2ByTW0OtxKPWc4ca4238a0b923820dcc509a6f75849bfU9JUIrpQmkUkjdW',1,'127.0.0.1','admin',1573808147,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Safari/605.1.15','admin',NULL),
	(195,'','hxQ4Ji3HPjdfIi59c4ca4238a0b923820dcc509a6f75849bYmvICuPVm8Bnodah',1,'127.0.0.1','admin',1573808148,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Safari/605.1.15','admin',NULL),
	(196,'','rUl69uohEsuDuBWdc4ca4238a0b923820dcc509a6f75849bRCiW9uD9UHdRLl1A',1,'127.0.0.1','admin',1573808958,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Safari/605.1.15','admin',NULL),
	(197,'','FihqrSt2zuvJ8LRnc4ca4238a0b923820dcc509a6f75849bMruCLcun9cyNwSZn',1,'127.0.0.1','admin',1573808959,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Safari/605.1.15','admin',NULL),
	(198,'','IILUAF6TUkHEXiIrc4ca4238a0b923820dcc509a6f75849bGLttcEFjxHgpWiwv',1,'127.0.0.1','admin',1573808960,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Safari/605.1.15','admin',NULL),
	(199,'','QmQOA72efoqc9zlhc4ca4238a0b923820dcc509a6f75849bEbRLoilumn7EnUPy',1,'127.0.0.1','admin',1573808960,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Safari/605.1.15','admin',NULL),
	(200,'','ClOktGFmipXvKzlHc4ca4238a0b923820dcc509a6f75849bdVEFud7pncIfXor1',1,'127.0.0.1','admin',1573808961,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Safari/605.1.15','admin',NULL),
	(201,'','C8PvMfxdMgnOwLtDc4ca4238a0b923820dcc509a6f75849by433830klWf0GGki',1,'127.0.0.1','admin',1573809076,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Safari/605.1.15','admin',NULL),
	(202,'','S0cHkuZA8aNOKESwc4ca4238a0b923820dcc509a6f75849bBjL9gl3rgcfk1oGm',1,'127.0.0.1','admin',1573810935,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Safari/605.1.15','admin',NULL),
	(203,'1sne14aagdvbnk9npacf7ij4l4',NULL,2,'127.0.0.1','',1573810938,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Safari/605.1.15','admin','用户名或者密码错误'),
	(204,'','7ObgsBAfRTQISZ17c4ca4238a0b923820dcc509a6f75849bloKU62E7CYwUqKq1',1,'127.0.0.1','admin',1573810955,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0.3 Safari/605.1.15','admin',NULL),
	(205,'6ocums5673kukh2mfc91c440ud',NULL,2,'127.0.0.1','admin',1575366263,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36','admin','用户名或者密码错误'),
	(206,'6ocums5673kukh2mfc91c440ud',NULL,2,'127.0.0.1','admin',1575366268,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36','admin','用户名或者密码错误'),
	(207,'6ocums5673kukh2mfc91c440ud',NULL,2,'127.0.0.1','admin',1575366273,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36','admin','用户名或者密码错误'),
	(208,'6ocums5673kukh2mfc91c440ud',NULL,2,'127.0.0.1','admin',1575366279,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36','admin','用户名或者密码错误'),
	(209,'6ocums5673kukh2mfc91c440ud',NULL,2,'127.0.0.1','admin',1575366285,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36','admin','用户名或者密码错误'),
	(210,'6ocums5673kukh2mfc91c440ud','',1,'127.0.0.1','admin',1575366291,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36','admin',NULL),
	(211,'6ocums5673kukh2mfc91c440ud',NULL,2,'127.0.0.1','',1575366429,'0','Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1','member','用户名或者密码错误'),
	(212,'6ocums5673kukh2mfc91c440ud',NULL,2,'127.0.0.1','',1575366443,'0','Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1','member','用户名或者密码错误'),
	(213,'bo8sd2gtvre7gsrt0rplp3r11l','',1,'127.0.0.1','admin',1580721967,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36','admin',NULL),
	(214,'9rh48smpse1el3cv5md0fs7b69','',1,'127.0.0.1','admin',1580898047,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36','admin',NULL),
	(215,'mgnraltr8rim1t6vbm7eoe7ulh',NULL,2,'127.0.0.1','admin',1580898922,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36','admin','用户名或者密码错误'),
	(216,'mgnraltr8rim1t6vbm7eoe7ulh',NULL,2,'127.0.0.1','admin',1580898926,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36','admin','用户名或者密码错误'),
	(217,'mgnraltr8rim1t6vbm7eoe7ulh',NULL,2,'127.0.0.1','admin',1580898931,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36','admin','用户名或者密码错误'),
	(218,'mgnraltr8rim1t6vbm7eoe7ulh',NULL,2,'127.0.0.1','admin',1580898937,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36','admin','用户名或者密码错误'),
	(219,'mgnraltr8rim1t6vbm7eoe7ulh',NULL,2,'127.0.0.1','admin',1580899267,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36','admin','用户名或者密码错误'),
	(220,'mgnraltr8rim1t6vbm7eoe7ulh',NULL,2,'127.0.0.1','admin',1580899274,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36','admin','用户名或者密码错误'),
	(221,'mgnraltr8rim1t6vbm7eoe7ulh',NULL,2,'127.0.0.1','admin',1580899293,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36','admin','用户名或者密码错误'),
	(222,'9rh48smpse1el3cv5md0fs7b69',NULL,2,'127.0.0.1','admin',1580899311,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36','admin','用户名或者密码错误'),
	(223,'9rh48smpse1el3cv5md0fs7b69',NULL,2,'127.0.0.1','admin',1580899318,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36','admin','用户名或者密码错误'),
	(224,'9rh48smpse1el3cv5md0fs7b69',NULL,2,'127.0.0.1','admin',1580899323,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36','admin','用户名或者密码错误'),
	(225,'9rh48smpse1el3cv5md0fs7b69',NULL,2,'127.0.0.1','admin',1580899329,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36','admin','用户名或者密码错误'),
	(226,'9rh48smpse1el3cv5md0fs7b69','',1,'127.0.0.1','admin',1580899335,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36','admin',NULL),
	(227,'mgnraltr8rim1t6vbm7eoe7ulh','',1,'127.0.0.1','admin',1580899341,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36','admin',NULL),
	(228,'mgnraltr8rim1t6vbm7eoe7ulh','',1,'127.0.0.1','admin',1580977516,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36','admin',NULL),
	(229,'mgnraltr8rim1t6vbm7eoe7ulh','',1,'127.0.0.1','admin',1580977540,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.130 Safari/537.36','admin',NULL),
	(230,'onep3512068ps04735p600ptnf',NULL,2,'127.0.0.1','admin',1585367963,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36','admin','用户名或者密码错误'),
	(231,'onep3512068ps04735p600ptnf',NULL,2,'127.0.0.1','admin',1585367967,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36','admin','用户名或者密码错误'),
	(232,'onep3512068ps04735p600ptnf',NULL,2,'127.0.0.1','admin',1585367975,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36','admin','用户名或者密码错误'),
	(233,'onep3512068ps04735p600ptnf',NULL,2,'127.0.0.1','admin',1585369788,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36','admin','用户名或者密码错误'),
	(234,'onep3512068ps04735p600ptnf','',1,'127.0.0.1','admin',1585369794,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36','admin',NULL),
	(235,'onep3512068ps04735p600ptnf',NULL,2,'127.0.0.1','admin',1586165293,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36','admin','用户名或者密码错误'),
	(236,'onep3512068ps04735p600ptnf',NULL,2,'127.0.0.1','admin',1586165354,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36','admin','用户名或者密码错误'),
	(237,'onep3512068ps04735p600ptnf',NULL,2,'127.0.0.1','admin',1586165359,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36','admin','用户名或者密码错误'),
	(238,'onep3512068ps04735p600ptnf',NULL,2,'127.0.0.1','admin',1586165509,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36','admin','用户名或者密码错误'),
	(239,'onep3512068ps04735p600ptnf',NULL,2,'127.0.0.1','admin',1586165538,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36','admin','用户名或者密码错误'),
	(240,'onep3512068ps04735p600ptnf',NULL,2,'127.0.0.1','admin',1586165543,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36','admin','用户名或者密码错误'),
	(241,'onep3512068ps04735p600ptnf',NULL,2,'127.0.0.1','admin',1586165592,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36','admin','用户名或者密码错误'),
	(242,'onep3512068ps04735p600ptnf',NULL,2,'127.0.0.1','admin',1586165595,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36','admin','用户名或者密码错误'),
	(243,'onep3512068ps04735p600ptnf',NULL,2,'127.0.0.1','admin',1586165648,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36','admin','用户名或者密码错误'),
	(244,'onep3512068ps04735p600ptnf',NULL,2,'127.0.0.1','admin',1586165721,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36','admin','用户名或者密码错误'),
	(245,'onep3512068ps04735p600ptnf',NULL,2,'127.0.0.1','admin',1586165750,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36','admin','用户名或者密码错误'),
	(246,'onep3512068ps04735p600ptnf',NULL,2,'127.0.0.1','admin',1586165796,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36','admin','用户名或者密码错误'),
	(247,'onep3512068ps04735p600ptnf',NULL,2,'127.0.0.1','admin',1586165799,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36','admin','用户名或者密码错误'),
	(248,'onep3512068ps04735p600ptnf',NULL,2,'127.0.0.1','admin',1586165808,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36','admin','用户名或者密码错误'),
	(249,'onep3512068ps04735p600ptnf',NULL,2,'127.0.0.1','admin',1586165814,'0','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36','admin','用户名或者密码错误'),
	(250,'onep3512068ps04735p600ptnf','',1,'127.0.0.1','admin',1586165818,'1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36','admin',NULL);

/*!40000 ALTER TABLE `co_login_log` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table co_member
# ------------------------------------------------------------

DROP TABLE IF EXISTS `co_member`;

CREATE TABLE `co_member` (
  `member_id` char(32) NOT NULL DEFAULT '' COMMENT '会员用户名',
  `member_lv_id` mediumint(8) unsigned DEFAULT '0' COMMENT '会员等级',
  `group_id` int(11) DEFAULT '0',
  `realname` varchar(50) DEFAULT NULL COMMENT '真实姓名',
  `nickname` varchar(100) DEFAULT NULL COMMENT '会员昵称',
  `point` int(10) DEFAULT '0' COMMENT '积分',
  `addr` varchar(255) DEFAULT NULL COMMENT '地址',
  `mobile` varchar(50) DEFAULT NULL COMMENT '手机',
  `email` varchar(200) DEFAULT '' COMMENT 'EMAIL',
  `refer_id` varchar(50) DEFAULT NULL COMMENT '来源ID',
  `refer_url` varchar(200) DEFAULT NULL COMMENT '推广来源URL',
  `reg_ip` varchar(30) DEFAULT NULL COMMENT '注册时IP地址',
  `state` tinyint(1) DEFAULT '0' COMMENT '会员验证状态',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '1启用2禁用',
  `remark` text COMMENT '备注',
  `experience` int(10) DEFAULT '0' COMMENT '经验值',
  `resetpwd` varchar(255) DEFAULT NULL COMMENT '找回密码唯一标示',
  `resetpwdtime` int(10) unsigned DEFAULT NULL COMMENT '找回密码时间',
  `source` enum('pc','wap','weixin','api') DEFAULT 'pc' COMMENT '平台来源',
  `session_id` varchar(50) DEFAULT NULL,
  `addtime` int(10) unsigned NOT NULL DEFAULT '0',
  `adduser` char(32) DEFAULT '0',
  `uptime` int(10) unsigned DEFAULT '0',
  `upuser` char(32) DEFAULT '0',
  `deluser` char(32) DEFAULT '0',
  `deltime` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`member_id`),
  KEY `ind_email` (`email`),
  KEY `ind_disabled` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员信息表';

LOCK TABLES `co_member` WRITE;
/*!40000 ALTER TABLE `co_member` DISABLE KEYS */;

INSERT INTO `co_member` (`member_id`, `member_lv_id`, `group_id`, `realname`, `nickname`, `point`, `addr`, `mobile`, `email`, `refer_id`, `refer_url`, `reg_ip`, `state`, `status`, `remark`, `experience`, `resetpwd`, `resetpwdtime`, `source`, `session_id`, `addtime`, `adduser`, `uptime`, `upuser`, `deluser`, `deltime`)
VALUES
	('36dabe09c80cf27b732114d7c9c807bb',0,0,'','',0,'0','','','','','/index/?ct=index&amp;ac=regist',0,1,'',0,'',0,'pc',NULL,1572491077,'-1',0,'0','0',0),
	('ed79914ea512d38bc1bbb9d7199a3af0',0,0,'王刚','干锅儿',0,'0','567890','','','','/index/?ct=index&amp;ac=regist',0,1,'',0,'',0,'pc',NULL,1572463485,'-1',0,'0','0',0);

/*!40000 ALTER TABLE `co_member` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table co_member_advance
# ------------------------------------------------------------

DROP TABLE IF EXISTS `co_member_advance`;

CREATE TABLE `co_member_advance` (
  `log_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '日志id',
  `member_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `money` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '出入金额',
  `message` varchar(255) DEFAULT NULL COMMENT '管理备注',
  `mtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '交易时间',
  `payment_id` varchar(20) DEFAULT NULL COMMENT '支付单号',
  `order_id` bigint(20) unsigned DEFAULT NULL COMMENT '订单号',
  `paymethod` varchar(100) DEFAULT NULL COMMENT '支付方式',
  `memo` varchar(100) DEFAULT NULL COMMENT '业务摘要',
  `import_money` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '存入金额',
  `explode_money` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '支出金额',
  `member_advance` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '当前余额',
  `shop_advance` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '商店余额',
  `disabled` enum('true','false') NOT NULL DEFAULT 'false' COMMENT '失效',
  PRIMARY KEY (`log_id`),
  KEY `ind_mtime` (`mtime`),
  KEY `ind_disabled` (`disabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员余额明细表';



# Dump of table co_member_coupon
# ------------------------------------------------------------

DROP TABLE IF EXISTS `co_member_coupon`;

CREATE TABLE `co_member_coupon` (
  `cpns_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '会员优惠券ID',
  `member_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '会员ID',
  `result` enum('fail','succ') NOT NULL DEFAULT 'succ' COMMENT '优惠卷使用结果',
  `disabled` enum('true','false') NOT NULL DEFAULT 'false' COMMENT '优惠券无效(过期)',
  `remark` varchar(666) DEFAULT NULL COMMENT '备注',
  `create_time` int(10) unsigned zerofill NOT NULL COMMENT '使用时间',
  `create_ip` varchar(20) NOT NULL DEFAULT '' COMMENT '使用IP地址',
  PRIMARY KEY (`cpns_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员使用优惠卷记录表';



# Dump of table co_member_group
# ------------------------------------------------------------

DROP TABLE IF EXISTS `co_member_group`;

CREATE TABLE `co_member_group` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table co_member_lv
# ------------------------------------------------------------

DROP TABLE IF EXISTS `co_member_lv`;

CREATE TABLE `co_member_lv` (
  `member_lv_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT '等级名称',
  `status` tinyint(255) unsigned NOT NULL DEFAULT '1' COMMENT '1已启用2已禁用',
  `dis_count` varchar(20) DEFAULT '100' COMMENT '会员折扣率',
  `pre_id` mediumint(9) DEFAULT NULL COMMENT '前一级别ID',
  `default_lv` enum('1','2') NOT NULL DEFAULT '2' COMMENT '是否默认，1是2不是',
  `lv_type` enum('retail','wholesale','dealer') DEFAULT 'retail' COMMENT '等级类型',
  `point` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '所需积分',
  `experience` int(10) DEFAULT '0' COMMENT '经验值',
  `expiretime` int(10) DEFAULT '0' COMMENT '积分过期时间',
  PRIMARY KEY (`member_lv_id`),
  UNIQUE KEY `ind_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员等级表';

LOCK TABLES `co_member_lv` WRITE;
/*!40000 ALTER TABLE `co_member_lv` DISABLE KEYS */;

INSERT INTO `co_member_lv` (`member_lv_id`, `name`, `status`, `dis_count`, `pre_id`, `default_lv`, `lv_type`, `point`, `experience`, `expiretime`)
VALUES
	(5,'普通会员',1,'110',NULL,'1','retail',0,0,0),
	(10,'青铜会员',1,'100',NULL,'2','retail',5000,0,0),
	(11,'银牌会员',1,'0.00',NULL,'2','retail',20000,0,0),
	(12,'黄金会员',1,'100',NULL,'2','retail',50000,0,0),
	(13,'铂金会员',1,'0',NULL,'2','retail',100000,0,0),
	(14,'钻石会员',1,'0',NULL,'2','retail',500000,0,0),
	(15,'终极VIP会员',1,'0',NULL,'2','retail',10000000,0,0);

/*!40000 ALTER TABLE `co_member_lv` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table co_member_msg
# ------------------------------------------------------------

DROP TABLE IF EXISTS `co_member_msg`;

CREATE TABLE `co_member_msg` (
  `msg_id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `for_id` int(11) DEFAULT '0' COMMENT '回复哪个信件',
  `from_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '发起会员ID',
  `from_uname` varchar(100) DEFAULT '' COMMENT '发信者',
  `from_type` int(11) DEFAULT '0' COMMENT '发信类型',
  `to_id` mediumint(8) unsigned DEFAULT '0' COMMENT '目标会员ID',
  `to_uname` varchar(100) DEFAULT NULL COMMENT '目标会员姓名',
  `subject` varchar(100) NOT NULL COMMENT '消息主题',
  `content` text NOT NULL COMMENT '内容',
  `order_id` bigint(20) DEFAULT '0' COMMENT '订单ID',
  `create_time` int(10) unsigned DEFAULT NULL COMMENT '发送时间',
  `to_time` int(10) unsigned DEFAULT NULL COMMENT '发送时间',
  `has_read` enum('true','false') DEFAULT 'false' COMMENT '是否已读',
  `keep_unread` enum('true','false') DEFAULT 'false' COMMENT '保持未读',
  `has_star` enum('true','false') DEFAULT 'false' COMMENT '是否打上星标',
  `has_sent` enum('true','false') DEFAULT 'true' COMMENT '是否发送',
  `send_ip` varchar(20) DEFAULT NULL COMMENT '发送IP地址',
  PRIMARY KEY (`msg_id`),
  KEY `ind_to_id` (`to_id`,`has_read`,`has_sent`),
  KEY `ind_from_id` (`from_id`,`has_read`,`has_sent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table co_member_pam
# ------------------------------------------------------------

DROP TABLE IF EXISTS `co_member_pam`;

CREATE TABLE `co_member_pam` (
  `member_id` char(32) NOT NULL DEFAULT '' COMMENT '账户序号ID',
  `username` varchar(100) NOT NULL DEFAULT '' COMMENT '登录名',
  `password` varchar(225) NOT NULL DEFAULT '' COMMENT '登录密码',
  `password_account` char(10) DEFAULT '' COMMENT '加密字符串',
  `wechat_openid` varchar(225) DEFAULT NULL COMMENT '微信openid',
  `app_token` char(64) DEFAULT NULL COMMENT 'app登陆tokne',
  `session_id` varchar(50) DEFAULT NULL,
  `uptime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后一次更新时间',
  PRIMARY KEY (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员密码表';

LOCK TABLES `co_member_pam` WRITE;
/*!40000 ALTER TABLE `co_member_pam` DISABLE KEYS */;

INSERT INTO `co_member_pam` (`member_id`, `username`, `password`, `password_account`, `wechat_openid`, `app_token`, `session_id`, `uptime`)
VALUES
	('36dabe09c80cf27b732114d7c9c807bb','gangkui001','$2y$10$nLCRHEgqJNpRVU9aiX59l./BSilQj.freTW5QHzSljsYIZ8HRvC3e','','',NULL,NULL,0),
	('ed79914ea512d38bc1bbb9d7199a3af0','gangkui','$2y$10$Qe9mUfxUYh5vPOM4OUcFYeReKz0twNyPxbNF5cxSYax/vBt.NAnY2','','',NULL,'vsm7fnvsvdtjkpf9ts1s3s352j',0);

/*!40000 ALTER TABLE `co_member_pam` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table co_message
# ------------------------------------------------------------

DROP TABLE IF EXISTS `co_message`;

CREATE TABLE `co_message` (
  `msg_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT '',
  `member_id` char(32) DEFAULT '0',
  `email` varchar(100) DEFAULT '',
  `mobile` varchar(300) NOT NULL DEFAULT '',
  `ip` varchar(30) DEFAULT NULL,
  `text` text,
  `addtime` int(11) NOT NULL,
  `uptime` int(11) NOT NULL,
  PRIMARY KEY (`msg_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `co_message` WRITE;
/*!40000 ALTER TABLE `co_message` DISABLE KEYS */;

INSERT INTO `co_message` (`msg_id`, `username`, `member_id`, `email`, `mobile`, `ip`, `text`, `addtime`, `uptime`)
VALUES
	(1,'SDFASDFA','0','','3123123123123','127.0.0.1',' ASSASDasdadfdsgadsgdhfdhsareDADSFGS',1586544251,1586544251);

/*!40000 ALTER TABLE `co_message` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table co_novel_content
# ------------------------------------------------------------

DROP TABLE IF EXISTS `co_novel_content`;

CREATE TABLE `co_novel_content` (
  `content_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `file_id` int(11) NOT NULL,
  `title` varchar(200) NOT NULL DEFAULT '',
  `path` varchar(200) NOT NULL DEFAULT '' COMMENT '文章内容路径',
  `addtime` int(11) NOT NULL,
  `adduser` char(32) NOT NULL DEFAULT '',
  `uptime` int(11) NOT NULL,
  `upuser` char(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`content_id`),
  KEY `file_id` (`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `co_novel_content` WRITE;
/*!40000 ALTER TABLE `co_novel_content` DISABLE KEYS */;

INSERT INTO `co_novel_content` (`content_id`, `file_id`, `title`, `path`, `addtime`, `adduser`, `uptime`, `upuser`)
VALUES
	(3,9,'第二章 拔叔的私房菜','novel/70/26/40/9-1586324743-SkumwcmZAKKzPLVL.txt',1586324743,'1',1586325167,'1'),
	(4,9,'第二章 拔叔的私房菜','novel/17/41/44/9-1586324980-KzIs4nbMyWPPfpmY.txt',1586324980,'1',1586325091,'1');

/*!40000 ALTER TABLE `co_novel_content` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table co_payments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `co_payments`;

CREATE TABLE `co_payments` (
  `payment_id` varchar(20) NOT NULL DEFAULT '' COMMENT '支付单号',
  `order_id` bigint(20) unsigned NOT NULL COMMENT '订单ID',
  `money` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '支付金额',
  `cur_money` decimal(20,3) NOT NULL DEFAULT '0.000' COMMENT '支付货币金额',
  `member_id` varchar(100) DEFAULT NULL COMMENT '会员用户名',
  `status` enum('succ','failed','cancel','error','invalid','progress','timeout','ready') NOT NULL DEFAULT 'ready' COMMENT '支付状态',
  `pay_name` varchar(100) DEFAULT NULL COMMENT '支付描述名称',
  `pay_type` enum('online','offline','deposit') NOT NULL DEFAULT 'online' COMMENT '支付类型',
  `t_payed` int(10) unsigned DEFAULT '0' COMMENT '支付完成时间',
  `payment_bn` varchar(32) DEFAULT '' COMMENT '支付单唯一编号',
  `account` varchar(50) DEFAULT NULL COMMENT '收款账号',
  `bank` varchar(50) DEFAULT NULL COMMENT '收款银行',
  `pay_account` varchar(50) DEFAULT NULL COMMENT '支付账户',
  `currency` varchar(10) DEFAULT NULL COMMENT '货币',
  `paycost` decimal(20,3) DEFAULT NULL COMMENT '支付网关费用',
  `pay_app_id` varchar(100) NOT NULL DEFAULT '0' COMMENT '支付方式名称',
  `pay_ver` varchar(50) DEFAULT NULL COMMENT '支付版本号',
  `ip` varchar(20) DEFAULT NULL COMMENT '支付IP',
  `t_begin` int(10) unsigned DEFAULT NULL COMMENT '支付开始时间',
  `t_confirm` int(10) unsigned DEFAULT NULL COMMENT '支付确认时间',
  `memo` longtext COMMENT '支付注释',
  `return_url` varchar(100) DEFAULT NULL COMMENT '支付返回地址',
  `disabled` enum('true','false') DEFAULT 'false' COMMENT '支付单状态',
  `trade_no` varchar(30) DEFAULT NULL COMMENT '支付单交易编号',
  `thirdparty_account` varchar(50) DEFAULT '' COMMENT '第三方支付账户',
  `addtime` int(11) NOT NULL,
  `adduser` char(32) NOT NULL DEFAULT '',
  `uptime` int(11) DEFAULT '0',
  `upuser` char(32) DEFAULT '0',
  PRIMARY KEY (`payment_id`),
  KEY `ind_disabled` (`disabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
