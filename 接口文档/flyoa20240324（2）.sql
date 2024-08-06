/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 80034
 Source Host           : 127.0.0.1:3306
 Source Schema         : flyoa20240324

 Target Server Type    : MySQL
 Target Server Version : 80034
 File Encoding         : 65001

 Date: 25/03/2024 22:17:07
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for company
-- ----------------------------
DROP TABLE IF EXISTS `company`;
CREATE TABLE `company`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `company_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `company_leader` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `company_detail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `company_tenantKey` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `company_displayId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of company
-- ----------------------------
INSERT INTO `company` VALUES (1, '测试企业', '王玫', 'shjkgS', '12', 'iii');
INSERT INTO `company` VALUES (2, 'a企业', '李月', 'asdvfig', '23', 'oooo');
INSERT INTO `company` VALUES (3, 'b企业', '李十四', '传说', '34', 'yyy');
INSERT INTO `company` VALUES (4, 'hy企业', '李月', 'moon', '54', 'ttt');
INSERT INTO `company` VALUES (5, 'hvfas企业', '刘禅', 'asfasawf', '54754', 'rrr');
INSERT INTO `company` VALUES (6, 'c企业', '曹操', 'fasfa', '623', 'cccc');
INSERT INTO `company` VALUES (8, '飞书二次开发demo', NULL, NULL, '16c3bbc0005ed75d', 'FKE78DZ813M');

-- ----------------------------
-- Table structure for event
-- ----------------------------
DROP TABLE IF EXISTS `event`;
CREATE TABLE `event`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `event_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `event_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `event_leader` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `event_outlay` int NULL DEFAULT NULL,
  `event_realIncome` int NULL DEFAULT NULL,
  `event_expectIncome` int NULL DEFAULT NULL,
  `event_belongCompany` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `event_secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `event_leader_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of event
-- ----------------------------
INSERT INTO `event` VALUES (1, '果园种植', '进行中', 'xc', 80000, 0, 100000, 'b企业', '012404hy', '1');
INSERT INTO `event` VALUES (2, '大事件', '规划中', '刘备', 0, 0, 0, '', '123456', '4');
INSERT INTO `event` VALUES (3, 'web', '规划中', '张三', 0, 0, 0, '', 'aaaaaa', '3');
INSERT INTO `event` VALUES (5, '007', '停止中', '林笑', 100000, 0, 10000, '测试企业', 'scvhjksvc', '6');
INSERT INTO `event` VALUES (6, '测试1', '规划中', '王志承', 1, 1, 1, '飞书二次开发demo', '1', '8');
INSERT INTO `event` VALUES (7, '', '规划中', '王志承', 0, 0, 0, '飞书二次开发demo', '', '8');
INSERT INTO `event` VALUES (8, '测试2', '规划中', '王志承', 2312, 215412, 12312, '飞书二次开发demo', '412', '8');

-- ----------------------------
-- Table structure for eventstomembers
-- ----------------------------
DROP TABLE IF EXISTS `eventstomembers`;
CREATE TABLE `eventstomembers`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `event_id` int NOT NULL,
  `eventUser_role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of eventstomembers
-- ----------------------------
INSERT INTO `eventstomembers` VALUES (1, 1, 1, '项目负责人');
INSERT INTO `eventstomembers` VALUES (2, 2, 1, '普通职员');
INSERT INTO `eventstomembers` VALUES (3, 4, 1, '普通职员');
INSERT INTO `eventstomembers` VALUES (4, 2, 2, '普通职员');
INSERT INTO `eventstomembers` VALUES (5, 1, 2, '普通职员');
INSERT INTO `eventstomembers` VALUES (10, 6, 2, '普通职员');
INSERT INTO `eventstomembers` VALUES (20, 4, 2, '项目负责人');
INSERT INTO `eventstomembers` VALUES (21, 6, 1, '普通职员');
INSERT INTO `eventstomembers` VALUES (23, 8, 5, '普通职员');
INSERT INTO `eventstomembers` VALUES (24, 6, 5, '项目负责人');
INSERT INTO `eventstomembers` VALUES (25, 1, 5, '普通职员');
INSERT INTO `eventstomembers` VALUES (26, 8, 6, '项目负责人');
INSERT INTO `eventstomembers` VALUES (27, 8, 7, '项目负责人');
INSERT INTO `eventstomembers` VALUES (28, 8, 1, '普通职员');
INSERT INTO `eventstomembers` VALUES (29, 8, 3, '普通职员');
INSERT INTO `eventstomembers` VALUES (30, 8, 8, '项目负责人');

-- ----------------------------
-- Table structure for material
-- ----------------------------
DROP TABLE IF EXISTS `material`;
CREATE TABLE `material`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `material_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `event_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of material
-- ----------------------------

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user_avatorUrl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `member_belongCompany` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user_email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user_mobile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `union_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES (1, 'xc', '012404', '普通职员', NULL, NULL, NULL, NULL, 'hsdcvbsiklv');
INSERT INTO `member` VALUES (2, '刘培金', '11108', '普通职员', NULL, NULL, NULL, NULL, 'dvhszjvciz');
INSERT INTO `member` VALUES (3, '张三', '202303', '普通职员', NULL, NULL, NULL, NULL, 'asdhijfglo');
INSERT INTO `member` VALUES (4, '刘备', '1005', '普通职员', NULL, NULL, NULL, NULL, 'zhvkfvbaofi');
INSERT INTO `member` VALUES (5, '张飞', '1007', '普通职员', NULL, NULL, NULL, NULL, 'sahdvivf');
INSERT INTO `member` VALUES (6, '林笑', '1006', '普通职员', NULL, 'b企业', NULL, NULL, 'sahdviashjk');
INSERT INTO `member` VALUES (8, '王志承', 'ou_1b3b96f6191d01e0e983eecc00d220d4', '普通职员', 'https://s1-imfile.feishucdn.com/static-resource/v1/v3_007b_261f08da-80dd-4ce5-9d41-c6f56945e26g~?image_size=72x72&cut_type=&quality=&format=image&sticker_format=.webp', NULL, NULL, NULL, 'on_44a9a8124cbbb66c2087df1eb9862a97');

-- ----------------------------
-- Table structure for officialseal
-- ----------------------------
DROP TABLE IF EXISTS `officialseal`;
CREATE TABLE `officialseal`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `officialSeal_describe` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `officialSeal_date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `officialSeal_unity` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `officialSeal_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `officialSeal_belongEvent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `officialSeal_file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `officialSeal_files` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `officialSeal_otherfiles` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of officialseal
-- ----------------------------
INSERT INTO `officialseal` VALUES (1, '申请专利', '20240317', '测试企业', '公章', '果园种植', '申请xx专利', '', '');
INSERT INTO `officialseal` VALUES (2, '申请专利', '20240317', '测试企业', '公章', '007', '申请xx专利', '', '');

-- ----------------------------
-- Table structure for outpay
-- ----------------------------
DROP TABLE IF EXISTS `outpay`;
CREATE TABLE `outpay`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `outpay_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `outpay_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `outpay_total` int NULL DEFAULT NULL,
  `outpay_belongEvent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `outpay_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of outpay
-- ----------------------------
INSERT INTO `outpay` VALUES (2, '设备购买', '仪器购买', 2200, '果园种植', '已通过');
INSERT INTO `outpay` VALUES (3, '设备购买', '仪器购买', 2200, '果园种植', '已通过');
INSERT INTO `outpay` VALUES (4, '设备购买', '打印机', 2200, '果园种植', '审核中');
INSERT INTO `outpay` VALUES (5, '差旅费', '项目合作方沟通', 800, '大事件', '已通过');
INSERT INTO `outpay` VALUES (6, '餐饮费', '团建', 1900, '大事件', '审核中');
INSERT INTO `outpay` VALUES (7, '餐饮费', '吃饭', 1900, '大事件', '审核中');
INSERT INTO `outpay` VALUES (8, '餐饮费', '吃饭', 500, '果园种植', '审核中');

-- ----------------------------
-- Table structure for outpay_detail
-- ----------------------------
DROP TABLE IF EXISTS `outpay_detail`;
CREATE TABLE `outpay_detail`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `outpay_num` int NULL DEFAULT NULL,
  `outpay_date` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `outpay_describe` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `outpay_belongOutpay` int NOT NULL,
  `outpay_member_string` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of outpay_detail
-- ----------------------------
INSERT INTO `outpay_detail` VALUES (2, 1000, '20230505', '仪器购买', 2, NULL);
INSERT INTO `outpay_detail` VALUES (3, 1000, '20240123', '仪器购买', 3, NULL);
INSERT INTO `outpay_detail` VALUES (4, 200, '20240123', '打印机购买', 4, NULL);
INSERT INTO `outpay_detail` VALUES (5, 800, '20240303', '沟通需求', 5, NULL);
INSERT INTO `outpay_detail` VALUES (6, 1700, '20240328', '团建', 6, NULL);
INSERT INTO `outpay_detail` VALUES (7, 200, '20240314', '吃饭', 7, NULL);
INSERT INTO `outpay_detail` VALUES (8, 500, '20240321', '吃饭', 8, NULL);

-- ----------------------------
-- Table structure for task
-- ----------------------------
DROP TABLE IF EXISTS `task`;
CREATE TABLE `task`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `task_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `task_describe` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `task_statu` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `task_leader` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `task_belongEvent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of task
-- ----------------------------
INSERT INTO `task` VALUES (5, '需求设计', '需求设计', '进行中', '王志承', '果园种植');
INSERT INTO `task` VALUES (7, 'aschjvjkvcf', 'csjkcvsigcoiu', '规划中', '王志承', '果园种植');
INSERT INTO `task` VALUES (8, 'cjsoagb', 'fdrsujgbos', '规划中', '王志承', '果园种植');
INSERT INTO `task` VALUES (9, 'sbvdopgsopdb', 'dnmasvv', '停止中', '刘培金', '果园种植');
INSERT INTO `task` VALUES (11, '交接工作', '交付工作', '规划中', '刘培金', '果园种植');
INSERT INTO `task` VALUES (12, '007', 'sdagae', '已完成', '刘备', '果园种植');
INSERT INTO `task` VALUES (13, '007', 'sdagae', '规划中', '刘备', '大事件');
INSERT INTO `task` VALUES (14, 'vcbaolvb', 'sgdasegeas', '规划中', '刘备', '大事件');
INSERT INTO `task` VALUES (18, '设计', '设计文档', '规划中', '林笑', '大事件');
INSERT INTO `task` VALUES (21, '开发会议', '开发会议', '规划中', '王志承', '果园种植');
INSERT INTO `task` VALUES (23, '1', '123123', '规划中', '', '测试1');

SET FOREIGN_KEY_CHECKS = 1;
