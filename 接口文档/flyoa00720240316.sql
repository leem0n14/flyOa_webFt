/*
Navicat MySQL Data Transfer

Source Server         : 2202
Source Server Version : 80013
Source Host           : localhost:3306
Source Database       : flyoa007

Target Server Type    : MYSQL
Target Server Version : 80013
File Encoding         : 65001

Date: 2024-03-16 20:34:06
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for company
-- ----------------------------
DROP TABLE IF EXISTS `company`;
CREATE TABLE `company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(255) NOT NULL,
  `company_leader` varchar(255) NOT NULL,
  `company_detail` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of company
-- ----------------------------
INSERT INTO `company` VALUES ('1', '测试企业', '王玫', 'shjkgS');
INSERT INTO `company` VALUES ('2', 'a企业', '李月', 'asdvfig');
INSERT INTO `company` VALUES ('3', 'b企业', '李十四', '传说');
INSERT INTO `company` VALUES ('4', 'hy企业', '李月', 'moon');
INSERT INTO `company` VALUES ('5', 'hvfas企业', '刘禅', 'asfasawf');
INSERT INTO `company` VALUES ('6', 'c企业', '曹操', 'fasfa');

-- ----------------------------
-- Table structure for event
-- ----------------------------
DROP TABLE IF EXISTS `event`;
CREATE TABLE `event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `event_name` varchar(255) NOT NULL,
  `event_status` varchar(255) DEFAULT NULL,
  `event_leader` varchar(255) NOT NULL,
  `event_outlay` int(11) DEFAULT NULL,
  `event_realIncome` int(11) DEFAULT NULL,
  `event_expectIncome` int(11) DEFAULT NULL,
  `event_belongCompany` varchar(255) DEFAULT NULL,
  `event_secret` varchar(255) DEFAULT NULL,
  `event_leader_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of event
-- ----------------------------
INSERT INTO `event` VALUES ('1', '果园种植', '规划中', '王志承', '0', '0', '0', null, '012404hy', '1');
INSERT INTO `event` VALUES ('2', '大事件', '规划中', '刘培金', '0', '0', '0', null, '123456', '2');
INSERT INTO `event` VALUES ('3', 'web', '规划中', '张三', '0', '0', '0', '', 'aaaaaa', '3');
INSERT INTO `event` VALUES ('4', '007', '规划中', '刘备', '0', '0', '0', '', 'dzfsfg', '4');

-- ----------------------------
-- Table structure for eventstomembers
-- ----------------------------
DROP TABLE IF EXISTS `eventstomembers`;
CREATE TABLE `eventstomembers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `eventUser_role` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of eventstomembers
-- ----------------------------
INSERT INTO `eventstomembers` VALUES ('1', '1', '1', '项目负责人');
INSERT INTO `eventstomembers` VALUES ('2', '2', '1', '普通职员');
INSERT INTO `eventstomembers` VALUES ('3', '4', '1', '普通职员');
INSERT INTO `eventstomembers` VALUES ('4', '2', '2', '项目负责人');
INSERT INTO `eventstomembers` VALUES ('5', '1', '2', '普通职员');
INSERT INTO `eventstomembers` VALUES ('10', '6', '2', '普通职员');
INSERT INTO `eventstomembers` VALUES ('13', '3', '5', '项目负责人');
INSERT INTO `eventstomembers` VALUES ('15', '1', '1', '项目负责人');
INSERT INTO `eventstomembers` VALUES ('16', '2', '2', '项目负责人');
INSERT INTO `eventstomembers` VALUES ('17', '3', '3', '项目负责人');
INSERT INTO `eventstomembers` VALUES ('18', '4', '4', '项目负责人');

-- ----------------------------
-- Table structure for material
-- ----------------------------
DROP TABLE IF EXISTS `material`;
CREATE TABLE `material` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `material_name` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `event_name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of material
-- ----------------------------

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) NOT NULL,
  `user_id` varchar(255) NOT NULL,
  `user_role` varchar(255) DEFAULT NULL,
  `user_avatorUrl` varchar(255) DEFAULT NULL,
  `member_belongCompany` varchar(255) DEFAULT NULL,
  `user_email` varchar(255) DEFAULT NULL,
  `user_mobile` varchar(255) DEFAULT NULL,
  `union_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES ('1', '王志承', '012404', '普通职员', null, null, null, null, 'hsdcvbsiklv');
INSERT INTO `member` VALUES ('2', '刘培金', '11108', '普通职员', null, null, null, null, 'dvhszjvciz');
INSERT INTO `member` VALUES ('3', '张三', '202303', '普通职员', null, null, null, null, 'asdhijfglo');
INSERT INTO `member` VALUES ('4', '刘备', '1005', '普通职员', null, null, null, null, 'zhvkfvbaofi');
INSERT INTO `member` VALUES ('5', '张飞', '1007', '普通职员', null, null, null, null, 'sahdvivf');
INSERT INTO `member` VALUES ('6', '林笑', '1006', '普通职员', null, 'b企业', null, null, 'sahdviashjk');

-- ----------------------------
-- Table structure for officialseal
-- ----------------------------
DROP TABLE IF EXISTS `officialseal`;
CREATE TABLE `officialseal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `officialSeal_name` varchar(255) NOT NULL,
  `officialSeal_describe` varchar(255) DEFAULT NULL,
  `officialSeal_belongEvent` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of officialseal
-- ----------------------------
INSERT INTO `officialseal` VALUES ('1', '申请xx专利', null, '果园种植');
INSERT INTO `officialseal` VALUES ('2', '申请xx专利', null, '大事件');
INSERT INTO `officialseal` VALUES ('3', '仪器', null, 'web');

-- ----------------------------
-- Table structure for outpay
-- ----------------------------
DROP TABLE IF EXISTS `outpay`;
CREATE TABLE `outpay` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `outpay_belongEvent` varchar(255) NOT NULL,
  `outpay_num` int(11) DEFAULT NULL,
  `outpay_reason` varchar(255) DEFAULT NULL,
  `outpay_status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of outpay
-- ----------------------------
INSERT INTO `outpay` VALUES ('1', '果园种植', '1900', '购买仪器', '审核中');
INSERT INTO `outpay` VALUES ('2', '大事件', '1900', '申请xx专利', '审核中');
INSERT INTO `outpay` VALUES ('3', '果园种植', '8000', '树苗买卖', '审核中');
INSERT INTO `outpay` VALUES ('4', 'web', '500', '服务器购买', '审核中');

-- ----------------------------
-- Table structure for task
-- ----------------------------
DROP TABLE IF EXISTS `task`;
CREATE TABLE `task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_name` varchar(255) DEFAULT NULL,
  `task_describe` varchar(255) DEFAULT NULL,
  `task_status` varchar(255) DEFAULT NULL,
  `task_leader` varchar(255) DEFAULT NULL,
  `task_belongEvent` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of task
-- ----------------------------
INSERT INTO `task` VALUES ('5', '需求设计', '需求设计', '进行中', '王志承', '果园种植');
INSERT INTO `task` VALUES ('7', 'aschjvjkvcf', 'csjkcvsigcoiu', '规划中', '王志承', '果园种植');
INSERT INTO `task` VALUES ('8', 'cjsoagb', 'fdrsujgbos', '规划中', '王志承', '果园种植');
INSERT INTO `task` VALUES ('9', 'sbvdopgsopdb', 'dnmasvv', '停止中', '刘培金', '果园种植');
INSERT INTO `task` VALUES ('11', '交接工作', '交付工作', '规划中', '刘培金', '果园种植');
INSERT INTO `task` VALUES ('12', '007', 'sdagae', '已完成', '刘备', '果园种植');
INSERT INTO `task` VALUES ('13', '007', 'sdagae', '规划中', '刘备', '大事件');
INSERT INTO `task` VALUES ('14', 'vcbaolvb', 'sgdasegeas', '规划中', '刘备', '大事件');
INSERT INTO `task` VALUES ('18', '设计', '设计文档', '规划中', '林笑', '大事件');
INSERT INTO `task` VALUES ('21', '开发会议', '开发会议', '规划中', '王志承', '果园种植');
