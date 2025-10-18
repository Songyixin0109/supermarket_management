/*
 Navicat Premium Dump SQL

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80031 (8.0.31)
 Source Host           : localhost:3306
 Source Schema         : onlineshop

 Target Server Type    : MySQL
 Target Server Version : 80031 (8.0.31)
 File Encoding         : 65001

 Date: 18/10/2025 21:50:55
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id` ASC, `permission_id` ASC) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id` ASC, `codename` ASC) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 93 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add permission', 1, 'add_permission');
INSERT INTO `auth_permission` VALUES (2, 'Can change permission', 1, 'change_permission');
INSERT INTO `auth_permission` VALUES (3, 'Can delete permission', 1, 'delete_permission');
INSERT INTO `auth_permission` VALUES (4, 'Can view permission', 1, 'view_permission');
INSERT INTO `auth_permission` VALUES (5, 'Can add group', 2, 'add_group');
INSERT INTO `auth_permission` VALUES (6, 'Can change group', 2, 'change_group');
INSERT INTO `auth_permission` VALUES (7, 'Can delete group', 2, 'delete_group');
INSERT INTO `auth_permission` VALUES (8, 'Can view group', 2, 'view_group');
INSERT INTO `auth_permission` VALUES (9, 'Can add user', 3, 'add_user');
INSERT INTO `auth_permission` VALUES (10, 'Can change user', 3, 'change_user');
INSERT INTO `auth_permission` VALUES (11, 'Can delete user', 3, 'delete_user');
INSERT INTO `auth_permission` VALUES (12, 'Can view user', 3, 'view_user');
INSERT INTO `auth_permission` VALUES (13, 'Can add content type', 4, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (14, 'Can change content type', 4, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (15, 'Can delete content type', 4, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (16, 'Can view content type', 4, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (17, 'Can add session', 5, 'add_session');
INSERT INTO `auth_permission` VALUES (18, 'Can change session', 5, 'change_session');
INSERT INTO `auth_permission` VALUES (19, 'Can delete session', 5, 'delete_session');
INSERT INTO `auth_permission` VALUES (20, 'Can view session', 5, 'view_session');
INSERT INTO `auth_permission` VALUES (21, 'Can add auth group', 6, 'add_authgroup');
INSERT INTO `auth_permission` VALUES (22, 'Can change auth group', 6, 'change_authgroup');
INSERT INTO `auth_permission` VALUES (23, 'Can delete auth group', 6, 'delete_authgroup');
INSERT INTO `auth_permission` VALUES (24, 'Can view auth group', 6, 'view_authgroup');
INSERT INTO `auth_permission` VALUES (25, 'Can add auth group permissions', 7, 'add_authgrouppermissions');
INSERT INTO `auth_permission` VALUES (26, 'Can change auth group permissions', 7, 'change_authgrouppermissions');
INSERT INTO `auth_permission` VALUES (27, 'Can delete auth group permissions', 7, 'delete_authgrouppermissions');
INSERT INTO `auth_permission` VALUES (28, 'Can view auth group permissions', 7, 'view_authgrouppermissions');
INSERT INTO `auth_permission` VALUES (29, 'Can add auth permission', 8, 'add_authpermission');
INSERT INTO `auth_permission` VALUES (30, 'Can change auth permission', 8, 'change_authpermission');
INSERT INTO `auth_permission` VALUES (31, 'Can delete auth permission', 8, 'delete_authpermission');
INSERT INTO `auth_permission` VALUES (32, 'Can view auth permission', 8, 'view_authpermission');
INSERT INTO `auth_permission` VALUES (33, 'Can add auth user', 9, 'add_authuser');
INSERT INTO `auth_permission` VALUES (34, 'Can change auth user', 9, 'change_authuser');
INSERT INTO `auth_permission` VALUES (35, 'Can delete auth user', 9, 'delete_authuser');
INSERT INTO `auth_permission` VALUES (36, 'Can view auth user', 9, 'view_authuser');
INSERT INTO `auth_permission` VALUES (37, 'Can add auth user groups', 10, 'add_authusergroups');
INSERT INTO `auth_permission` VALUES (38, 'Can change auth user groups', 10, 'change_authusergroups');
INSERT INTO `auth_permission` VALUES (39, 'Can delete auth user groups', 10, 'delete_authusergroups');
INSERT INTO `auth_permission` VALUES (40, 'Can view auth user groups', 10, 'view_authusergroups');
INSERT INTO `auth_permission` VALUES (41, 'Can add auth user user permissions', 11, 'add_authuseruserpermissions');
INSERT INTO `auth_permission` VALUES (42, 'Can change auth user user permissions', 11, 'change_authuseruserpermissions');
INSERT INTO `auth_permission` VALUES (43, 'Can delete auth user user permissions', 11, 'delete_authuseruserpermissions');
INSERT INTO `auth_permission` VALUES (44, 'Can view auth user user permissions', 11, 'view_authuseruserpermissions');
INSERT INTO `auth_permission` VALUES (45, 'Can add django content type', 12, 'add_djangocontenttype');
INSERT INTO `auth_permission` VALUES (46, 'Can change django content type', 12, 'change_djangocontenttype');
INSERT INTO `auth_permission` VALUES (47, 'Can delete django content type', 12, 'delete_djangocontenttype');
INSERT INTO `auth_permission` VALUES (48, 'Can view django content type', 12, 'view_djangocontenttype');
INSERT INTO `auth_permission` VALUES (49, 'Can add django migrations', 13, 'add_djangomigrations');
INSERT INTO `auth_permission` VALUES (50, 'Can change django migrations', 13, 'change_djangomigrations');
INSERT INTO `auth_permission` VALUES (51, 'Can delete django migrations', 13, 'delete_djangomigrations');
INSERT INTO `auth_permission` VALUES (52, 'Can view django migrations', 13, 'view_djangomigrations');
INSERT INTO `auth_permission` VALUES (53, 'Can add django session', 14, 'add_djangosession');
INSERT INTO `auth_permission` VALUES (54, 'Can change django session', 14, 'change_djangosession');
INSERT INTO `auth_permission` VALUES (55, 'Can delete django session', 14, 'delete_djangosession');
INSERT INTO `auth_permission` VALUES (56, 'Can view django session', 14, 'view_djangosession');
INSERT INTO `auth_permission` VALUES (57, 'Can add admin', 15, 'add_admin');
INSERT INTO `auth_permission` VALUES (58, 'Can change admin', 15, 'change_admin');
INSERT INTO `auth_permission` VALUES (59, 'Can delete admin', 15, 'delete_admin');
INSERT INTO `auth_permission` VALUES (60, 'Can view admin', 15, 'view_admin');
INSERT INTO `auth_permission` VALUES (61, 'Can add employee info', 16, 'add_employeeinfo');
INSERT INTO `auth_permission` VALUES (62, 'Can change employee info', 16, 'change_employeeinfo');
INSERT INTO `auth_permission` VALUES (63, 'Can delete employee info', 16, 'delete_employeeinfo');
INSERT INTO `auth_permission` VALUES (64, 'Can view employee info', 16, 'view_employeeinfo');
INSERT INTO `auth_permission` VALUES (65, 'Can add merchant info', 17, 'add_merchantinfo');
INSERT INTO `auth_permission` VALUES (66, 'Can change merchant info', 17, 'change_merchantinfo');
INSERT INTO `auth_permission` VALUES (67, 'Can delete merchant info', 17, 'delete_merchantinfo');
INSERT INTO `auth_permission` VALUES (68, 'Can view merchant info', 17, 'view_merchantinfo');
INSERT INTO `auth_permission` VALUES (69, 'Can add purchase items', 18, 'add_purchaseitems');
INSERT INTO `auth_permission` VALUES (70, 'Can change purchase items', 18, 'change_purchaseitems');
INSERT INTO `auth_permission` VALUES (71, 'Can delete purchase items', 18, 'delete_purchaseitems');
INSERT INTO `auth_permission` VALUES (72, 'Can view purchase items', 18, 'view_purchaseitems');
INSERT INTO `auth_permission` VALUES (73, 'Can add user info', 19, 'add_userinfo');
INSERT INTO `auth_permission` VALUES (74, 'Can change user info', 19, 'change_userinfo');
INSERT INTO `auth_permission` VALUES (75, 'Can delete user info', 19, 'delete_userinfo');
INSERT INTO `auth_permission` VALUES (76, 'Can view user info', 19, 'view_userinfo');
INSERT INTO `auth_permission` VALUES (77, 'Can add merchant items', 20, 'add_merchantitems');
INSERT INTO `auth_permission` VALUES (78, 'Can change merchant items', 20, 'change_merchantitems');
INSERT INTO `auth_permission` VALUES (79, 'Can delete merchant items', 20, 'delete_merchantitems');
INSERT INTO `auth_permission` VALUES (80, 'Can view merchant items', 20, 'view_merchantitems');
INSERT INTO `auth_permission` VALUES (81, 'Can add inventory items', 21, 'add_inventoryitems');
INSERT INTO `auth_permission` VALUES (82, 'Can change inventory items', 21, 'change_inventoryitems');
INSERT INTO `auth_permission` VALUES (83, 'Can delete inventory items', 21, 'delete_inventoryitems');
INSERT INTO `auth_permission` VALUES (84, 'Can view inventory items', 21, 'view_inventoryitems');
INSERT INTO `auth_permission` VALUES (85, 'Can add purchase orders', 22, 'add_purchaseorders');
INSERT INTO `auth_permission` VALUES (86, 'Can change purchase orders', 22, 'change_purchaseorders');
INSERT INTO `auth_permission` VALUES (87, 'Can delete purchase orders', 22, 'delete_purchaseorders');
INSERT INTO `auth_permission` VALUES (88, 'Can view purchase orders', 22, 'view_purchaseorders');
INSERT INTO `auth_permission` VALUES (89, 'Can add sell orders', 23, 'add_sellorders');
INSERT INTO `auth_permission` VALUES (90, 'Can change sell orders', 23, 'change_sellorders');
INSERT INTO `auth_permission` VALUES (91, 'Can delete sell orders', 23, 'delete_sellorders');
INSERT INTO `auth_permission` VALUES (92, 'Can view sell orders', 23, 'view_sellorders');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `first_name` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_groups_user_id_group_id_94350c0c_uniq`(`user_id` ASC, `group_id` ASC) USING BTREE,
  INDEX `auth_user_groups_group_id_97559544_fk_auth_group_id`(`group_id` ASC) USING BTREE,
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq`(`user_id` ASC, `permission_id` ASC) USING BTREE,
  INDEX `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label` ASC, `model` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (2, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (1, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'user');
INSERT INTO `django_content_type` VALUES (4, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (15, 'OnlineShop', 'admin');
INSERT INTO `django_content_type` VALUES (6, 'OnlineShop', 'authgroup');
INSERT INTO `django_content_type` VALUES (7, 'OnlineShop', 'authgrouppermissions');
INSERT INTO `django_content_type` VALUES (8, 'OnlineShop', 'authpermission');
INSERT INTO `django_content_type` VALUES (9, 'OnlineShop', 'authuser');
INSERT INTO `django_content_type` VALUES (10, 'OnlineShop', 'authusergroups');
INSERT INTO `django_content_type` VALUES (11, 'OnlineShop', 'authuseruserpermissions');
INSERT INTO `django_content_type` VALUES (12, 'OnlineShop', 'djangocontenttype');
INSERT INTO `django_content_type` VALUES (13, 'OnlineShop', 'djangomigrations');
INSERT INTO `django_content_type` VALUES (14, 'OnlineShop', 'djangosession');
INSERT INTO `django_content_type` VALUES (16, 'OnlineShop', 'employeeinfo');
INSERT INTO `django_content_type` VALUES (21, 'OnlineShop', 'inventoryitems');
INSERT INTO `django_content_type` VALUES (17, 'OnlineShop', 'merchantinfo');
INSERT INTO `django_content_type` VALUES (20, 'OnlineShop', 'merchantitems');
INSERT INTO `django_content_type` VALUES (18, 'OnlineShop', 'purchaseitems');
INSERT INTO `django_content_type` VALUES (22, 'OnlineShop', 'purchaseorders');
INSERT INTO `django_content_type` VALUES (23, 'OnlineShop', 'sellorders');
INSERT INTO `django_content_type` VALUES (19, 'OnlineShop', 'userinfo');
INSERT INTO `django_content_type` VALUES (5, 'sessions', 'session');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'OnlineShop', '0001_initial', '2025-10-08 12:57:52.973080');
INSERT INTO `django_migrations` VALUES (2, 'contenttypes', '0001_initial', '2025-10-08 12:57:53.033763');
INSERT INTO `django_migrations` VALUES (3, 'contenttypes', '0002_remove_content_type_name', '2025-10-08 12:57:53.117794');
INSERT INTO `django_migrations` VALUES (4, 'auth', '0001_initial', '2025-10-08 12:57:53.815045');
INSERT INTO `django_migrations` VALUES (5, 'auth', '0002_alter_permission_name_max_length', '2025-10-08 12:57:53.883823');
INSERT INTO `django_migrations` VALUES (6, 'auth', '0003_alter_user_email_max_length', '2025-10-08 12:57:53.969754');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0004_alter_user_username_opts', '2025-10-08 12:57:53.980255');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0005_alter_user_last_login_null', '2025-10-08 12:57:54.090208');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0006_require_contenttypes_0002', '2025-10-08 12:57:54.093019');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0007_alter_validators_add_error_messages', '2025-10-08 12:57:54.100451');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0008_alter_user_username_max_length', '2025-10-08 12:57:54.212338');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0009_alter_user_last_name_max_length', '2025-10-08 12:57:54.318353');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0010_alter_group_name_max_length', '2025-10-08 12:57:54.434978');
INSERT INTO `django_migrations` VALUES (14, 'auth', '0011_update_proxy_permissions', '2025-10-08 12:57:54.452515');
INSERT INTO `django_migrations` VALUES (15, 'auth', '0012_alter_user_first_name_max_length', '2025-10-08 12:57:54.555039');
INSERT INTO `django_migrations` VALUES (16, 'sessions', '0001_initial', '2025-10-08 12:57:54.613787');
INSERT INTO `django_migrations` VALUES (17, 'OnlineShop', '0002_purchaseorders_created_at_purchaseorders_status_and_more', '2025-10-11 02:26:19.113599');
INSERT INTO `django_migrations` VALUES (18, 'OnlineShop', '0003_alter_merchantitems_merchant_items', '2025-10-11 02:28:17.879848');
INSERT INTO `django_migrations` VALUES (19, 'OnlineShop', '0004_employeeinfo_date_sellorders_updated_at_and_more', '2025-10-13 00:38:24.256766');
INSERT INTO `django_migrations` VALUES (20, 'OnlineShop', '0005_sellorders_is_deleted', '2025-10-14 04:34:46.207903');
INSERT INTO `django_migrations` VALUES (21, 'OnlineShop', '0006_alter_inventoryitems_items_name_and_more', '2025-10-15 02:06:08.374565');
INSERT INTO `django_migrations` VALUES (22, 'OnlineShop', '0007_rename_inventory_quantity_inventoryitems_inventory_quantity_and_more', '2025-10-15 08:56:09.994629');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('75uc4pzab8fi03mhd5gz746wrc7qmehc', 'eyJpbWFnZV9jb2RlIjoiTUFYWlAiLCJfc2Vzc2lvbl9leHBpcnkiOjYwfQ:1vA2FV:8nwMIlzouMsBZxWGN0fV6raPsKDoXiPLxhS09n3CMSo', '2025-10-18 08:26:13.463393');
INSERT INTO `django_session` VALUES ('879yudxsbablxi1epfvp0we5s19jcm6l', 'eyJpbWFnZV9jb2RlIjoiRVNUQlEiLCJfc2Vzc2lvbl9leHBpcnkiOjYwfQ:1vA2Uj:5jYZbLbvGR0ASokydSm4qNW0mbYeZJsV2hD8VYUKdKg', '2025-10-18 08:41:57.311082');
INSERT INTO `django_session` VALUES ('c9uxj5cdc0s05t9kypp5l09yas6ap8gl', 'eyJpbWFnZV9jb2RlIjoiRURTUVUiLCJfc2Vzc2lvbl9leHBpcnkiOjYwfQ:1vA2YT:-EH7MnDl6KLquz5RFvNtqUY5tkfwHZopqcPmNFnJgNo', '2025-10-18 08:45:49.940229');
INSERT INTO `django_session` VALUES ('j69yuwnlmci2teckzqrkbo8aeylozfgq', 'eyJpbWFnZV9jb2RlIjoiS01NUEkiLCJfc2Vzc2lvbl9leHBpcnkiOjYwfQ:1vA2Wp:ozjyp8MtkdwnaivUQ_i-1e2YovcuBV4XjAptJhTS9_w', '2025-10-18 08:44:07.516832');
INSERT INTO `django_session` VALUES ('mbyytk1erd602m06pa666hdxh5wv1tgc', 'eyJpbWFnZV9jb2RlIjoiTUdHVVIiLCJfc2Vzc2lvbl9leHBpcnkiOjYwfQ:1vA2fE:RIL3-HBLj-eZ7ZB2SaXF9FQKxzEva9RxYQ2kwvasSoE', '2025-10-18 08:52:48.077455');
INSERT INTO `django_session` VALUES ('mhe6xolmkheuaceyqey76t0jypichp62', 'eyJpbWFnZV9jb2RlIjoiSkhJQVciLCJfc2Vzc2lvbl9leHBpcnkiOjYwfQ:1vA2jC:fPzfJ0OFtTrVkugdgVh1EwpTiuT3vBCnZOwc13xvOXY', '2025-10-18 08:56:54.114746');
INSERT INTO `django_session` VALUES ('odanar57ktqpckfc1v8fxesq1pytltv7', 'eyJpbmZvIjp7ImlkIjoxLCJ1c2VybmFtZSI6ImFhYSIsInJvbGUiOiJhZG1pbiJ9LCJpbWFnZV9jb2RlIjoiUVBMSlMiLCJfc2Vzc2lvbl9leHBpcnkiOjYwfQ:1vA2Bf:8T6HL3dT3WUTP0sFDinAIUbJK0rfq_sGnPVjoRPyW88', '2025-10-18 08:22:15.185701');
INSERT INTO `django_session` VALUES ('tnq447su5ngzckec5ojjvav92zfs0hbb', 'eyJpbWFnZV9jb2RlIjoiTENKU0ciLCJfc2Vzc2lvbl9leHBpcnkiOjYwNDgwMCwiaW5mbyI6eyJpZCI6MSwidXNlcm5hbWUiOiJhYWEiLCJyb2xlIjoiYWRtaW4ifX0:1vA774:rmBWzhfVQ8tpnlSj7sGlZiXTsznynPAr7x9PAAzvvyo', '2025-10-25 13:36:50.425962');
INSERT INTO `django_session` VALUES ('w1qe6wgvqydboon65kzu1xzwg77z81xs', 'eyJpbWFnZV9jb2RlIjoiVFJBU1oiLCJfc2Vzc2lvbl9leHBpcnkiOjYwfQ:1vA2Pk:hmLi1XN5X39GY7YAd6CFBkbVmMfns6BkFVVCFV6ktL0', '2025-10-18 08:36:48.959794');
INSERT INTO `django_session` VALUES ('zidyz0ns6hljhwou7riqcgxz0dcvmtff', 'eyJpbWFnZV9jb2RlIjoiWVVNQlciLCJfc2Vzc2lvbl9leHBpcnkiOjYwfQ:1vA2b1:1usCRnmn5B0VrYxYGcC1WvDdrFN_im0Y3gHkUG8seDI', '2025-10-18 08:48:27.084703');

-- ----------------------------
-- Table structure for employee_info
-- ----------------------------
DROP TABLE IF EXISTS `employee_info`;
CREATE TABLE `employee_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `employee_name` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `password` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `gender` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `position` smallint NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `employee_name`(`employee_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of employee_info
-- ----------------------------
INSERT INTO `employee_info` VALUES (1, 'eee', '686592bbb48ac6aab292ed07355d4ad2', 'F', '18116348729', 1, '2025-10-13');

-- ----------------------------
-- Table structure for inventory_items
-- ----------------------------
DROP TABLE IF EXISTS `inventory_items`;
CREATE TABLE `inventory_items`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sell_price` decimal(10, 2) NOT NULL,
  `inventory_quantity` int NOT NULL,
  `items_name_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `inventory_items_items_name_id_cd24473b_fk_purchase_items_id`(`items_name_id` ASC) USING BTREE,
  CONSTRAINT `inventory_items_items_name_id_cd24473b_fk_purchase_items_id` FOREIGN KEY (`items_name_id`) REFERENCES `purchase_items` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of inventory_items
-- ----------------------------
INSERT INTO `inventory_items` VALUES (1, 2469.00, 50, 4);
INSERT INTO `inventory_items` VALUES (2, 33.00, 90, 46);
INSERT INTO `inventory_items` VALUES (3, 181.00, 70, 29);
INSERT INTO `inventory_items` VALUES (4, 519.00, 23, 34);
INSERT INTO `inventory_items` VALUES (5, 59.00, 50, 49);
INSERT INTO `inventory_items` VALUES (6, 52.00, 60, 53);
INSERT INTO `inventory_items` VALUES (7, 128.00, 35, 57);
INSERT INTO `inventory_items` VALUES (8, 55.00, 65, 59);
INSERT INTO `inventory_items` VALUES (9, 72.00, 50, 76);
INSERT INTO `inventory_items` VALUES (10, 77.00, 70, 75);
INSERT INTO `inventory_items` VALUES (11, 24.00, 100, 42);
INSERT INTO `inventory_items` VALUES (12, 17.00, 110, 47);
INSERT INTO `inventory_items` VALUES (13, 649.00, 80, 5);
INSERT INTO `inventory_items` VALUES (14, 1819.00, 58, 6);
INSERT INTO `inventory_items` VALUES (15, 72.00, 80, 14);
INSERT INTO `inventory_items` VALUES (16, 1689.00, 35, 10);
INSERT INTO `inventory_items` VALUES (17, 26.00, 90, 18);
INSERT INTO `inventory_items` VALUES (18, 30.00, 100, 19);
INSERT INTO `inventory_items` VALUES (19, 10.00, 160, 48);
INSERT INTO `inventory_items` VALUES (20, 59.00, 50, 60);
INSERT INTO `inventory_items` VALUES (21, 68.00, 75, 81);
INSERT INTO `inventory_items` VALUES (22, 30.00, 100, 66);

-- ----------------------------
-- Table structure for merchant_info
-- ----------------------------
DROP TABLE IF EXISTS `merchant_info`;
CREATE TABLE `merchant_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `merchant_name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `phone` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `email` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 66 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of merchant_info
-- ----------------------------
INSERT INTO `merchant_info` VALUES (1, 'Apple授权店', '', NULL, '');
INSERT INTO `merchant_info` VALUES (2, '华为终端', '', NULL, '');
INSERT INTO `merchant_info` VALUES (3, '北京小米', '', NULL, '');
INSERT INTO `merchant_info` VALUES (4, '索尼中国', '', NULL, '');
INSERT INTO `merchant_info` VALUES (5, '罗技旗舰店', '', NULL, '');
INSERT INTO `merchant_info` VALUES (6, '小米生态', '', NULL, '');
INSERT INTO `merchant_info` VALUES (7, '极米科技', '', NULL, '');
INSERT INTO `merchant_info` VALUES (8, '任天堂中国', '', NULL, '');
INSERT INTO `merchant_info` VALUES (9, '滴露官方', '', NULL, '');
INSERT INTO `merchant_info` VALUES (10, '维达华东仓', '', NULL, '');
INSERT INTO `merchant_info` VALUES (11, '尤妮佳中国', '', NULL, '');
INSERT INTO `merchant_info` VALUES (12, '宝洁中国', '', NULL, '');
INSERT INTO `merchant_info` VALUES (13, '联合利华', '', NULL, '');
INSERT INTO `merchant_info` VALUES (14, '立白集团', '', NULL, '');
INSERT INTO `merchant_info` VALUES (15, '洁柔中国', '', NULL, '');
INSERT INTO `merchant_info` VALUES (16, '3M中国', '', NULL, '');
INSERT INTO `merchant_info` VALUES (17, '花王中国', '', NULL, '');
INSERT INTO `merchant_info` VALUES (18, '蓝月亮', '', NULL, '');
INSERT INTO `merchant_info` VALUES (19, '威露士', '', NULL, '');
INSERT INTO `merchant_info` VALUES (20, '优衣库中国', '', NULL, '');
INSERT INTO `merchant_info` VALUES (21, '李宁体育', '', NULL, '');
INSERT INTO `merchant_info` VALUES (22, 'ZARA中国', '', NULL, '');
INSERT INTO `merchant_info` VALUES (23, 'H&M中国', '', NULL, '');
INSERT INTO `merchant_info` VALUES (24, '森马集团', '', NULL, '');
INSERT INTO `merchant_info` VALUES (25, '美邦中国', '', NULL, '');
INSERT INTO `merchant_info` VALUES (26, '安踏体育', '', NULL, '');
INSERT INTO `merchant_info` VALUES (27, '太平鸟', '', NULL, '');
INSERT INTO `merchant_info` VALUES (28, '茵曼中国', '', NULL, '');
INSERT INTO `merchant_info` VALUES (29, '波司登', '', NULL, '');
INSERT INTO `merchant_info` VALUES (30, '蕉内科技', '', NULL, '');
INSERT INTO `merchant_info` VALUES (31, '回力鞋业', '', NULL, '');
INSERT INTO `merchant_info` VALUES (32, '得力集团', '', NULL, '');
INSERT INTO `merchant_info` VALUES (33, '晨光文具', '', NULL, '');
INSERT INTO `merchant_info` VALUES (34, '中信出版社', '', NULL, '');
INSERT INTO `merchant_info` VALUES (35, '重庆出版社', '', NULL, '');
INSERT INTO `merchant_info` VALUES (36, '作家出版社', '', NULL, '');
INSERT INTO `merchant_info` VALUES (37, '译林出版社', '', NULL, '');
INSERT INTO `merchant_info` VALUES (38, '南海出版公司', '', NULL, '');
INSERT INTO `merchant_info` VALUES (39, '中国友谊出版公司', '', NULL, '');
INSERT INTO `merchant_info` VALUES (40, '北京联合出版公司', '', NULL, '');
INSERT INTO `merchant_info` VALUES (41, '机械工业出版社', '', NULL, '');
INSERT INTO `merchant_info` VALUES (42, '湖南文艺出版社', '', NULL, '');
INSERT INTO `merchant_info` VALUES (43, '三只松鼠', '', NULL, '');
INSERT INTO `merchant_info` VALUES (44, '康师傅华东', '', NULL, '');
INSERT INTO `merchant_info` VALUES (45, '旺旺集团', '', NULL, '');
INSERT INTO `merchant_info` VALUES (46, '良品铺子', '', NULL, '');
INSERT INTO `merchant_info` VALUES (47, '百草味', '', NULL, '');
INSERT INTO `merchant_info` VALUES (48, '亿滋中国', '', NULL, '');
INSERT INTO `merchant_info` VALUES (49, '五芳斋', '', NULL, '');
INSERT INTO `merchant_info` VALUES (50, '海底捞', '', NULL, '');
INSERT INTO `merchant_info` VALUES (51, '双汇集团', '', NULL, '');
INSERT INTO `merchant_info` VALUES (52, '百事食品', '', NULL, '');
INSERT INTO `merchant_info` VALUES (53, '恰恰食品', '', NULL, '');
INSERT INTO `merchant_info` VALUES (54, '王小卤', '', NULL, '');
INSERT INTO `merchant_info` VALUES (55, '农夫山泉', '', NULL, '');
INSERT INTO `merchant_info` VALUES (56, '中粮可口可乐', '', NULL, '');
INSERT INTO `merchant_info` VALUES (57, '元气森林', '', NULL, '');
INSERT INTO `merchant_info` VALUES (58, '三得利中国', '', NULL, '');
INSERT INTO `merchant_info` VALUES (59, '达能中国', '', NULL, '');
INSERT INTO `merchant_info` VALUES (60, '红牛中国', '', NULL, '');
INSERT INTO `merchant_info` VALUES (61, '椰树集团', '', NULL, '');
INSERT INTO `merchant_info` VALUES (62, '达能依云', '', NULL, '');
INSERT INTO `merchant_info` VALUES (63, '百事中国', '', NULL, '');
INSERT INTO `merchant_info` VALUES (64, '统一企业', '', NULL, '');
INSERT INTO `merchant_info` VALUES (65, '养乐多中国', '', NULL, '');

-- ----------------------------
-- Table structure for merchant_items
-- ----------------------------
DROP TABLE IF EXISTS `merchant_items`;
CREATE TABLE `merchant_items`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `merchant_price` decimal(10, 2) NOT NULL,
  `merchant_id` bigint NOT NULL,
  `merchant_items_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `merchant_items_merchant_id_6f8d6669_fk_merchant_info_id`(`merchant_id` ASC) USING BTREE,
  INDEX `merchant_items_merchant_items_id_bab6a212_fk_purchase_items_id`(`merchant_items_id` ASC) USING BTREE,
  CONSTRAINT `merchant_items_merchant_id_6f8d6669_fk_merchant_info_id` FOREIGN KEY (`merchant_id`) REFERENCES `merchant_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `merchant_items_merchant_items_id_bab6a212_fk_purchase_items_id` FOREIGN KEY (`merchant_items_id`) REFERENCES `purchase_items` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 85 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of merchant_items
-- ----------------------------
INSERT INTO `merchant_items` VALUES (1, 8999.00, 1, 1);
INSERT INTO `merchant_items` VALUES (2, 6999.00, 2, 2);
INSERT INTO `merchant_items` VALUES (3, 2299.00, 3, 3);
INSERT INTO `merchant_items` VALUES (4, 1899.00, 4, 4);
INSERT INTO `merchant_items` VALUES (5, 499.00, 5, 5);
INSERT INTO `merchant_items` VALUES (6, 1399.00, 1, 6);
INSERT INTO `merchant_items` VALUES (7, 129.00, 6, 7);
INSERT INTO `merchant_items` VALUES (8, 999.00, 2, 8);
INSERT INTO `merchant_items` VALUES (9, 3999.00, 7, 9);
INSERT INTO `merchant_items` VALUES (10, 1299.00, 6, 10);
INSERT INTO `merchant_items` VALUES (11, 3399.00, 4, 11);
INSERT INTO `merchant_items` VALUES (12, 2299.00, 8, 12);
INSERT INTO `merchant_items` VALUES (13, 39.90, 9, 13);
INSERT INTO `merchant_items` VALUES (14, 55.00, 10, 14);
INSERT INTO `merchant_items` VALUES (15, 12.50, 11, 15);
INSERT INTO `merchant_items` VALUES (16, 42.90, 12, 16);
INSERT INTO `merchant_items` VALUES (17, 28.50, 13, 17);
INSERT INTO `merchant_items` VALUES (18, 19.90, 14, 18);
INSERT INTO `merchant_items` VALUES (19, 22.90, 15, 19);
INSERT INTO `merchant_items` VALUES (20, 89.00, 16, 20);
INSERT INTO `merchant_items` VALUES (21, 59.00, 17, 21);
INSERT INTO `merchant_items` VALUES (22, 35.00, 18, 22);
INSERT INTO `merchant_items` VALUES (23, 29.90, 9, 23);
INSERT INTO `merchant_items` VALUES (24, 25.90, 19, 24);
INSERT INTO `merchant_items` VALUES (25, 79.90, 20, 25);
INSERT INTO `merchant_items` VALUES (26, 129.00, 21, 26);
INSERT INTO `merchant_items` VALUES (27, 259.00, 22, 27);
INSERT INTO `merchant_items` VALUES (28, 159.00, 23, 28);
INSERT INTO `merchant_items` VALUES (29, 139.00, 24, 29);
INSERT INTO `merchant_items` VALUES (30, 119.00, 25, 30);
INSERT INTO `merchant_items` VALUES (31, 149.00, 26, 31);
INSERT INTO `merchant_items` VALUES (32, 299.00, 27, 32);
INSERT INTO `merchant_items` VALUES (33, 189.00, 28, 33);
INSERT INTO `merchant_items` VALUES (34, 399.00, 29, 34);
INSERT INTO `merchant_items` VALUES (35, 89.00, 30, 35);
INSERT INTO `merchant_items` VALUES (36, 79.00, 31, 36);
INSERT INTO `merchant_items` VALUES (37, 9.90, 32, 37);
INSERT INTO `merchant_items` VALUES (38, 24.80, 33, 38);
INSERT INTO `merchant_items` VALUES (39, 6.50, 33, 39);
INSERT INTO `merchant_items` VALUES (40, 12.00, 32, 40);
INSERT INTO `merchant_items` VALUES (41, 15.00, 33, 41);
INSERT INTO `merchant_items` VALUES (42, 18.00, 32, 42);
INSERT INTO `merchant_items` VALUES (43, 22.00, 33, 43);
INSERT INTO `merchant_items` VALUES (44, 10.00, 32, 44);
INSERT INTO `merchant_items` VALUES (45, 8.00, 33, 45);
INSERT INTO `merchant_items` VALUES (46, 25.00, 32, 46);
INSERT INTO `merchant_items` VALUES (47, 13.00, 33, 47);
INSERT INTO `merchant_items` VALUES (48, 7.50, 32, 48);
INSERT INTO `merchant_items` VALUES (49, 45.00, 34, 49);
INSERT INTO `merchant_items` VALUES (50, 99.00, 35, 50);
INSERT INTO `merchant_items` VALUES (51, 28.00, 36, 51);
INSERT INTO `merchant_items` VALUES (52, 32.00, 37, 52);
INSERT INTO `merchant_items` VALUES (53, 39.50, 38, 53);
INSERT INTO `merchant_items` VALUES (54, 168.00, 39, 54);
INSERT INTO `merchant_items` VALUES (55, 49.50, 38, 55);
INSERT INTO `merchant_items` VALUES (56, 45.00, 40, 56);
INSERT INTO `merchant_items` VALUES (57, 98.00, 34, 57);
INSERT INTO `merchant_items` VALUES (58, 39.80, 41, 58);
INSERT INTO `merchant_items` VALUES (59, 42.00, 42, 59);
INSERT INTO `merchant_items` VALUES (60, 45.00, 42, 60);
INSERT INTO `merchant_items` VALUES (61, 89.90, 43, 61);
INSERT INTO `merchant_items` VALUES (62, 12.50, 44, 62);
INSERT INTO `merchant_items` VALUES (63, 18.00, 45, 63);
INSERT INTO `merchant_items` VALUES (64, 39.90, 46, 64);
INSERT INTO `merchant_items` VALUES (65, 35.00, 47, 65);
INSERT INTO `merchant_items` VALUES (66, 22.90, 48, 66);
INSERT INTO `merchant_items` VALUES (67, 25.00, 49, 67);
INSERT INTO `merchant_items` VALUES (68, 36.00, 50, 68);
INSERT INTO `merchant_items` VALUES (69, 13.50, 51, 69);
INSERT INTO `merchant_items` VALUES (70, 29.90, 52, 70);
INSERT INTO `merchant_items` VALUES (71, 8.90, 53, 71);
INSERT INTO `merchant_items` VALUES (72, 19.90, 54, 72);
INSERT INTO `merchant_items` VALUES (73, 22.00, 55, 73);
INSERT INTO `merchant_items` VALUES (74, 45.00, 56, 74);
INSERT INTO `merchant_items` VALUES (75, 59.00, 57, 75);
INSERT INTO `merchant_items` VALUES (76, 55.00, 58, 76);
INSERT INTO `merchant_items` VALUES (77, 42.00, 59, 77);
INSERT INTO `merchant_items` VALUES (78, 108.00, 60, 78);
INSERT INTO `merchant_items` VALUES (79, 66.00, 61, 79);
INSERT INTO `merchant_items` VALUES (80, 89.00, 62, 80);
INSERT INTO `merchant_items` VALUES (81, 52.00, 55, 81);
INSERT INTO `merchant_items` VALUES (82, 45.00, 63, 82);
INSERT INTO `merchant_items` VALUES (83, 48.00, 64, 83);
INSERT INTO `merchant_items` VALUES (84, 38.00, 65, 84);

-- ----------------------------
-- Table structure for onlineshop_admin
-- ----------------------------
DROP TABLE IF EXISTS `onlineshop_admin`;
CREATE TABLE `onlineshop_admin`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `password` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of onlineshop_admin
-- ----------------------------
INSERT INTO `onlineshop_admin` VALUES (1, 'aaa', '686592bbb48ac6aab292ed07355d4ad2');

-- ----------------------------
-- Table structure for purchase_items
-- ----------------------------
DROP TABLE IF EXISTS `purchase_items`;
CREATE TABLE `purchase_items`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `catalog` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 85 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of purchase_items
-- ----------------------------
INSERT INTO `purchase_items` VALUES (1, 'iPhone 16 Pro', '1T 原钛', '数码产品');
INSERT INTO `purchase_items` VALUES (2, '华为Mate70 Pro+ 512G 黑', '全网通5G 512G 黑', '数码产品');
INSERT INTO `purchase_items` VALUES (3, '小米平板7', 'WiFi版 深灰 11寸 256G', '数码产品');
INSERT INTO `purchase_items` VALUES (4, '索尼WH-1000XM5 耳机', '无线降噪 黑色', '数码产品');
INSERT INTO `purchase_items` VALUES (5, '罗技MX Master3S 鼠标', '蓝牙无线 石墨黑', '数码产品');
INSERT INTO `purchase_items` VALUES (6, '苹果AirPods4 降噪版', 'USB-C充电盒', '数码产品');
INSERT INTO `purchase_items` VALUES (7, '小米65W氮化镓充电器', '2C1A三口', '数码产品');
INSERT INTO `purchase_items` VALUES (8, '华为FreeBuds Pro3', '星闪连接 白', '数码产品');
INSERT INTO `purchase_items` VALUES (9, '极米H6 4K投影仪', '光学变焦 家用', '数码产品');
INSERT INTO `purchase_items` VALUES (10, '小米智能门锁2', '指纹NFC解锁', '数码产品');
INSERT INTO `purchase_items` VALUES (11, '索尼PS5 Slim 光驱版', '1TB固态 白色', '数码产品');
INSERT INTO `purchase_items` VALUES (12, '任天堂Switch OLED 日版', '7寸屏 白色', '数码产品');
INSERT INTO `purchase_items` VALUES (13, '滴露除菌洗衣液', '3kg 除菌款', '日用品');
INSERT INTO `purchase_items` VALUES (14, '维达卷纸', '140g*27卷 4层加厚', '日用品');
INSERT INTO `purchase_items` VALUES (15, '苏菲超熟睡卫生巾', '420mm 8片 夜用加长', '日用品');
INSERT INTO `purchase_items` VALUES (16, '海飞丝去屑洗发水', '750ml 清爽去油型', '日用品');
INSERT INTO `purchase_items` VALUES (17, '奥妙除螨洗衣粉', '1.8kg 家庭装', '日用品');
INSERT INTO `purchase_items` VALUES (18, '立白洗洁精', '1kg*2瓶 食品级', '日用品');
INSERT INTO `purchase_items` VALUES (19, '洁柔湿巾', '80抽*3包 无香型', '日用品');
INSERT INTO `purchase_items` VALUES (20, '3M口罩 KN95', '50只/盒 独立包装', '日用品');
INSERT INTO `purchase_items` VALUES (21, '花王蒸汽眼罩', '12片/盒 洋甘菊香', '日用品');
INSERT INTO `purchase_items` VALUES (22, '蓝月亮地板清洁剂', '除菌去味 2kg', '日用品');
INSERT INTO `purchase_items` VALUES (23, '滴露消毒液', '衣物家居通用 1.2L', '日用品');
INSERT INTO `purchase_items` VALUES (24, '威露士洗手液', '泡沫型 525ml*2', '日用品');
INSERT INTO `purchase_items` VALUES (25, '优衣库纯棉T恤', '圆领基础款 白色M', '服装');
INSERT INTO `purchase_items` VALUES (26, '李宁运动短裤', '速干透气 黑色L', '服装');
INSERT INTO `purchase_items` VALUES (27, 'ZARA牛仔夹克', '秋冬新款 深蓝M', '服装');
INSERT INTO `purchase_items` VALUES (28, 'H&M卫衣 灰色L', '连帽加绒', '服装');
INSERT INTO `purchase_items` VALUES (29, '森马直筒牛仔裤', '弹力修身 XL', '服装');
INSERT INTO `purchase_items` VALUES (30, '美特斯邦威衬衫', '商务免烫 白色', '服装');
INSERT INTO `purchase_items` VALUES (31, '安踏针织运动裤', '加绒束脚 L', '服装');
INSERT INTO `purchase_items` VALUES (32, '太平鸟毛呢外套', 'M', '服装');
INSERT INTO `purchase_items` VALUES (33, '茵曼碎花连衣裙', '棉麻长袖 S', '服装');
INSERT INTO `purchase_items` VALUES (34, '波司登羽绒服', '90绒 可脱卸帽 175/96A', '服装');
INSERT INTO `purchase_items` VALUES (35, '蕉内秋裤', '抗菌保暖 灰色L', '服装');
INSERT INTO `purchase_items` VALUES (36, '回力帆布鞋', '经典款 39码白', '服装');
INSERT INTO `purchase_items` VALUES (37, '得力中性笔', '黑色水笔  0.5mm 12支/盒', '文具');
INSERT INTO `purchase_items` VALUES (38, 'A4 70g 复印纸', '高白不卡纸 500张/包', '文具');
INSERT INTO `purchase_items` VALUES (39, '晨光便利贴', '100张/本 3*3英寸 6色', '文具');
INSERT INTO `purchase_items` VALUES (40, '得力固体胶', '快干型 40g 10支/盒', '文具');
INSERT INTO `purchase_items` VALUES (41, '晨光荧光笔', '6支套装 柔色系', '文具');
INSERT INTO `purchase_items` VALUES (42, '得力文件夹', '插页式  A4 10个/包', '文具');
INSERT INTO `purchase_items` VALUES (43, '晨光订书机', '金属机身 中号', '文具');
INSERT INTO `purchase_items` VALUES (44, '得力长尾夹', '彩色混装 32mm 40只/盒', '文具');
INSERT INTO `purchase_items` VALUES (45, '晨光橡皮擦', '无屑干净 30块/盒', '文具');
INSERT INTO `purchase_items` VALUES (46, '得力美工刀', '自动锁刃 18mm 10把/盒', '文具');
INSERT INTO `purchase_items` VALUES (47, '晨光笔袋', '帆布材质 大容量 黑', '文具');
INSERT INTO `purchase_items` VALUES (48, '得力标签贴', '可书写 1*2英寸 12色', '文具');
INSERT INTO `purchase_items` VALUES (49, '《人类简史》新版', '赫拉利著 精装', '书籍');
INSERT INTO `purchase_items` VALUES (50, '《三体》全集 1-3', '刘慈欣科幻经典', '书籍');
INSERT INTO `purchase_items` VALUES (51, '《活着》余华著', '长篇小说', '书籍');
INSERT INTO `purchase_items` VALUES (52, '《小王子》精装插图版', '中法对照', '书籍');
INSERT INTO `purchase_items` VALUES (53, '《解忧杂货店》', '东野圭吾治愈系', '书籍');
INSERT INTO `purchase_items` VALUES (54, '《明朝那些事儿》全套', '1-9册礼盒', '书籍');
INSERT INTO `purchase_items` VALUES (55, '《霍乱时期的爱情》', '马尔克斯著', '书籍');
INSERT INTO `purchase_items` VALUES (56, '《房思琪的初恋乐园》', '林奕含著', '书籍');
INSERT INTO `purchase_items` VALUES (57, '《原则》桥水基金', '瑞·达利欧', '书籍');
INSERT INTO `purchase_items` VALUES (58, '《被讨厌的勇气》', '阿德勒心理学', '书籍');
INSERT INTO `purchase_items` VALUES (59, '《云边有个小卖部》', '张嘉佳著', '书籍');
INSERT INTO `purchase_items` VALUES (60, '《长安的荔枝》', '马伯庸历史小说', '书籍');
INSERT INTO `purchase_items` VALUES (61, '三只松鼠每日坚果', '25小包混合装 750g', '食品');
INSERT INTO `purchase_items` VALUES (62, '康师傅红烧牛肉面', '经典口味 5连包', '食品');
INSERT INTO `purchase_items` VALUES (63, '旺旺雪饼', '原味米饼 520g 大袋', '食品');
INSERT INTO `purchase_items` VALUES (64, '良品铺子猪肉脯', '200g 靖江风味', '食品');
INSERT INTO `purchase_items` VALUES (65, '百草味麻辣牛肉', '100g 独立小包装', '食品');
INSERT INTO `purchase_items` VALUES (66, '奥利奥夹心饼干', '520g 原味大包装', '食品');
INSERT INTO `purchase_items` VALUES (67, '五芳斋粽子', '咸蛋黄肉粽 200g*2 真空包装', '食品');
INSERT INTO `purchase_items` VALUES (68, '海底捞自热火锅', '麻辣嫩牛 435g', '食品');
INSERT INTO `purchase_items` VALUES (69, '双汇王中王火腿肠', '经典淀粉肠 40g*10支', '食品');
INSERT INTO `purchase_items` VALUES (70, '乐事薯片', '70g*6连包 混合口味', '食品');
INSERT INTO `purchase_items` VALUES (71, '恰恰香瓜子', '山核桃味 200g', '食品');
INSERT INTO `purchase_items` VALUES (72, '王小卤虎皮凤爪', '128g 麻辣味', '食品');
INSERT INTO `purchase_items` VALUES (73, '农夫山泉饮用天然水', '550ml*24 无添加天然水', '饮料');
INSERT INTO `purchase_items` VALUES (74, '可口可乐经典罐', '原装经典 330ml*24', '饮料');
INSERT INTO `purchase_items` VALUES (75, '元气森林白桃苏打气泡水', '0糖0脂  480ml*15', '饮料');
INSERT INTO `purchase_items` VALUES (76, '三得利乌龙茶', '无糖原味 500ml*24', '饮料');
INSERT INTO `purchase_items` VALUES (77, '脉动青柠口味', '维生素饮料 600ml*15', '饮料');
INSERT INTO `purchase_items` VALUES (78, '红牛维生素风味饮料', '原味 250ml*24', '饮料');
INSERT INTO `purchase_items` VALUES (79, '椰树牌椰汁', '天然植物蛋白 245ml*24罐', '饮料');
INSERT INTO `purchase_items` VALUES (80, '依云天然矿泉水', '法国进口 500ml*24', '饮料');
INSERT INTO `purchase_items` VALUES (81, '东方树叶茉莉花茶', '无糖茶 500ml*15', '饮料');
INSERT INTO `purchase_items` VALUES (82, '百事可乐无糖', '零卡 330ml*24', '饮料');
INSERT INTO `purchase_items` VALUES (83, '统一阿萨姆奶茶', '原味  500ml*15', '饮料');
INSERT INTO `purchase_items` VALUES (84, '养乐多活性乳酸菌', '原味 50瓶 100ml*5排', '饮料');

-- ----------------------------
-- Table structure for purchase_orders
-- ----------------------------
DROP TABLE IF EXISTS `purchase_orders`;
CREATE TABLE `purchase_orders`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `purchase_quantity` int NOT NULL,
  `employee_id` bigint NULL DEFAULT NULL,
  `merchant_items_id` bigint NULL DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `status` smallint UNSIGNED NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `purchase_orders_employee_id_153f1e1f_fk_employee_info_id`(`employee_id` ASC) USING BTREE,
  INDEX `purchase_orders_merchant_items_id_9ba50751_fk_merchant_items_id`(`merchant_items_id` ASC) USING BTREE,
  CONSTRAINT `purchase_orders_employee_id_153f1e1f_fk_employee_info_id` FOREIGN KEY (`employee_id`) REFERENCES `employee_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `purchase_orders_merchant_items_id_9ba50751_fk_merchant_items_id` FOREIGN KEY (`merchant_items_id`) REFERENCES `merchant_items` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `purchase_orders_chk_1` CHECK (`status` >= 0)
) ENGINE = InnoDB AUTO_INCREMENT = 85 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of purchase_orders
-- ----------------------------
INSERT INTO `purchase_orders` VALUES (1, 30, 1, 1, '2025-10-15 00:49:34.380790', 2, '2025-10-15 03:00:10.648265');
INSERT INTO `purchase_orders` VALUES (2, 25, 1, 2, '2025-10-15 00:49:34.392785', 2, '2025-10-15 02:59:45.285824');
INSERT INTO `purchase_orders` VALUES (3, 40, 1, 3, '2025-10-15 00:49:34.407297', 2, '2025-10-15 08:21:36.503780');
INSERT INTO `purchase_orders` VALUES (4, 50, 1, 4, '2025-10-15 00:49:34.418294', 2, '2025-10-15 08:24:43.343326');
INSERT INTO `purchase_orders` VALUES (5, 80, 1, 5, '2025-10-15 00:49:34.426294', 2, '2025-10-15 08:35:01.772099');
INSERT INTO `purchase_orders` VALUES (6, 60, 1, 6, '2025-10-15 00:49:34.432294', 2, '2025-10-15 08:35:14.488181');
INSERT INTO `purchase_orders` VALUES (7, 100, 1, 7, '2025-10-15 00:49:34.439302', 1, '2025-10-15 00:49:34.440311');
INSERT INTO `purchase_orders` VALUES (8, 70, 1, 8, '2025-10-15 00:49:34.445311', 1, '2025-10-15 00:49:34.445311');
INSERT INTO `purchase_orders` VALUES (9, 20, 1, 9, '2025-10-15 00:49:34.453356', 1, '2025-10-15 00:49:34.453356');
INSERT INTO `purchase_orders` VALUES (10, 35, 1, 10, '2025-10-15 00:49:34.459355', 2, '2025-10-16 11:36:15.271270');
INSERT INTO `purchase_orders` VALUES (11, 15, 1, 11, '2025-10-15 00:49:34.465890', 1, '2025-10-15 00:49:34.465890');
INSERT INTO `purchase_orders` VALUES (12, 25, 1, 12, '2025-10-15 00:49:34.473889', 1, '2025-10-15 00:49:34.473889');
INSERT INTO `purchase_orders` VALUES (13, 60, 1, 13, '2025-10-15 00:49:34.483889', 1, '2025-10-15 00:49:34.483889');
INSERT INTO `purchase_orders` VALUES (14, 80, 1, 14, '2025-10-15 00:49:34.491324', 2, '2025-10-15 08:37:49.340187');
INSERT INTO `purchase_orders` VALUES (15, 120, 1, 15, '2025-10-15 00:49:34.501341', 1, '2025-10-15 00:49:34.501341');
INSERT INTO `purchase_orders` VALUES (16, 70, 1, 16, '2025-10-15 00:49:34.514329', 1, '2025-10-15 00:49:34.514329');
INSERT INTO `purchase_orders` VALUES (17, 50, 1, 17, '2025-10-15 00:49:34.524361', 1, '2025-10-15 00:49:34.524361');
INSERT INTO `purchase_orders` VALUES (18, 90, 1, 18, '2025-10-15 00:49:34.532383', 2, '2025-10-16 11:37:21.369028');
INSERT INTO `purchase_orders` VALUES (19, 100, 1, 19, '2025-10-15 00:49:34.540366', 2, '2025-10-18 12:12:49.054987');
INSERT INTO `purchase_orders` VALUES (20, 40, 1, 20, '2025-10-15 00:49:34.550893', 1, '2025-10-15 00:49:34.550893');
INSERT INTO `purchase_orders` VALUES (21, 60, 1, 21, '2025-10-15 00:49:34.557877', 1, '2025-10-15 00:49:34.557877');
INSERT INTO `purchase_orders` VALUES (22, 45, 1, 22, '2025-10-15 00:49:34.568070', 1, '2025-10-15 00:49:34.568070');
INSERT INTO `purchase_orders` VALUES (23, 55, 1, 23, '2025-10-15 00:49:34.576070', 1, '2025-10-15 00:49:34.576070');
INSERT INTO `purchase_orders` VALUES (24, 85, 1, 24, '2025-10-15 00:49:34.591089', 1, '2025-10-15 00:49:34.591089');
INSERT INTO `purchase_orders` VALUES (25, 80, 1, 25, '2025-10-15 00:49:34.602072', 1, '2025-10-15 00:49:34.602072');
INSERT INTO `purchase_orders` VALUES (26, 60, 1, 26, '2025-10-15 00:49:34.609100', 1, '2025-10-15 00:49:34.609100');
INSERT INTO `purchase_orders` VALUES (27, 40, 1, 27, '2025-10-15 00:49:34.619094', 1, '2025-10-15 00:49:34.619094');
INSERT INTO `purchase_orders` VALUES (28, 50, 1, 28, '2025-10-15 00:49:34.626093', 1, '2025-10-15 00:49:34.626093');
INSERT INTO `purchase_orders` VALUES (29, 70, 1, 29, '2025-10-15 00:49:34.634092', 2, '2025-10-15 08:29:59.933444');
INSERT INTO `purchase_orders` VALUES (30, 55, 1, 30, '2025-10-15 00:49:34.641131', 1, '2025-10-15 00:49:34.641131');
INSERT INTO `purchase_orders` VALUES (31, 65, 1, 31, '2025-10-15 00:49:34.649139', 1, '2025-10-15 00:49:34.649139');
INSERT INTO `purchase_orders` VALUES (32, 30, 1, 32, '2025-10-15 00:49:34.657138', 1, '2025-10-15 00:49:34.657138');
INSERT INTO `purchase_orders` VALUES (33, 45, 1, 33, '2025-10-15 00:49:34.665715', 1, '2025-10-15 00:49:34.665715');
INSERT INTO `purchase_orders` VALUES (34, 25, 1, 34, '2025-10-15 00:49:34.672200', 2, '2025-10-15 08:30:06.118648');
INSERT INTO `purchase_orders` VALUES (35, 90, 1, 35, '2025-10-15 00:49:34.680198', 1, '2025-10-15 00:49:34.680198');
INSERT INTO `purchase_orders` VALUES (36, 100, 1, 36, '2025-10-15 00:49:34.688199', 1, '2025-10-15 00:49:34.688199');
INSERT INTO `purchase_orders` VALUES (37, 300, 1, 37, '2025-10-15 00:49:34.693664', 1, '2025-10-15 00:49:34.693664');
INSERT INTO `purchase_orders` VALUES (38, 150, 1, 38, '2025-10-15 00:49:34.702663', 1, '2025-10-15 00:49:34.702663');
INSERT INTO `purchase_orders` VALUES (39, 200, 1, 39, '2025-10-15 00:49:34.707664', 1, '2025-10-15 00:49:34.707664');
INSERT INTO `purchase_orders` VALUES (40, 120, 1, 40, '2025-10-15 00:49:34.714687', 1, '2025-10-15 00:49:34.714687');
INSERT INTO `purchase_orders` VALUES (41, 180, 1, 41, '2025-10-15 00:49:34.720550', 1, '2025-10-15 00:49:34.720550');
INSERT INTO `purchase_orders` VALUES (42, 100, 1, 42, '2025-10-15 00:49:34.725676', 2, '2025-10-15 08:31:22.254241');
INSERT INTO `purchase_orders` VALUES (43, 80, 1, 43, '2025-10-15 00:49:34.731676', 1, '2025-10-15 00:49:34.731676');
INSERT INTO `purchase_orders` VALUES (44, 150, 1, 44, '2025-10-15 00:49:34.738225', 1, '2025-10-15 00:49:34.738225');
INSERT INTO `purchase_orders` VALUES (45, 250, 1, 45, '2025-10-15 00:49:34.743849', 1, '2025-10-15 00:49:34.743849');
INSERT INTO `purchase_orders` VALUES (46, 90, 1, 46, '2025-10-15 00:49:34.749988', 2, '2025-10-15 08:26:57.322662');
INSERT INTO `purchase_orders` VALUES (47, 110, 1, 47, '2025-10-15 00:49:34.755235', 2, '2025-10-15 08:31:29.641527');
INSERT INTO `purchase_orders` VALUES (48, 160, 1, 48, '2025-10-15 00:49:34.760241', 2, '2025-10-18 12:12:56.577918');
INSERT INTO `purchase_orders` VALUES (49, 50, 1, 49, '2025-10-15 00:49:34.769578', 2, '2025-10-15 08:30:13.537640');
INSERT INTO `purchase_orders` VALUES (50, 40, 1, 50, '2025-10-15 00:49:34.775579', 1, '2025-10-15 00:49:34.775579');
INSERT INTO `purchase_orders` VALUES (51, 80, 1, 51, '2025-10-15 00:49:34.784760', 1, '2025-10-15 00:49:34.784760');
INSERT INTO `purchase_orders` VALUES (52, 70, 1, 52, '2025-10-15 00:49:34.791300', 1, '2025-10-15 00:49:34.791300');
INSERT INTO `purchase_orders` VALUES (53, 60, 1, 53, '2025-10-15 00:49:34.799301', 2, '2025-10-15 08:30:19.444826');
INSERT INTO `purchase_orders` VALUES (54, 25, 1, 54, '2025-10-15 00:49:34.806316', 1, '2025-10-15 00:49:34.806316');
INSERT INTO `purchase_orders` VALUES (55, 45, 1, 55, '2025-10-15 00:49:34.812302', 1, '2025-10-15 00:49:34.812302');
INSERT INTO `purchase_orders` VALUES (56, 55, 1, 56, '2025-10-15 00:49:34.821300', 1, '2025-10-15 00:49:34.821300');
INSERT INTO `purchase_orders` VALUES (57, 35, 1, 57, '2025-10-15 00:49:34.826300', 2, '2025-10-15 08:30:26.512228');
INSERT INTO `purchase_orders` VALUES (58, 90, 1, 58, '2025-10-15 00:49:34.835316', 1, '2025-10-15 00:49:34.835316');
INSERT INTO `purchase_orders` VALUES (59, 65, 1, 59, '2025-10-15 00:49:34.842331', 2, '2025-10-15 08:30:33.685858');
INSERT INTO `purchase_orders` VALUES (60, 50, 1, 60, '2025-10-15 00:49:34.850320', 2, '2025-10-18 12:13:02.280857');
INSERT INTO `purchase_orders` VALUES (61, 120, 1, 61, '2025-10-15 00:49:34.859304', 1, '2025-10-15 00:49:34.859304');
INSERT INTO `purchase_orders` VALUES (62, 200, 1, 62, '2025-10-15 00:49:34.867101', 1, '2025-10-15 00:49:34.867101');
INSERT INTO `purchase_orders` VALUES (63, 150, 1, 63, '2025-10-15 00:49:34.874944', 1, '2025-10-15 00:49:34.874944');
INSERT INTO `purchase_orders` VALUES (64, 80, 1, 64, '2025-10-15 00:49:34.882946', 1, '2025-10-15 00:49:34.882946');
INSERT INTO `purchase_orders` VALUES (65, 90, 1, 65, '2025-10-15 00:49:34.889976', 1, '2025-10-15 00:49:34.889976');
INSERT INTO `purchase_orders` VALUES (66, 100, 1, 66, '2025-10-15 00:49:34.898946', 2, '2025-10-18 12:13:22.791089');
INSERT INTO `purchase_orders` VALUES (67, 60, 1, 67, '2025-10-15 00:49:34.905945', 1, '2025-10-15 00:49:34.905945');
INSERT INTO `purchase_orders` VALUES (68, 70, 1, 68, '2025-10-15 00:49:34.913944', 3, '2025-10-15 08:27:10.017896');
INSERT INTO `purchase_orders` VALUES (69, 180, 1, 69, '2025-10-15 00:49:34.921961', 1, '2025-10-15 00:49:34.921961');
INSERT INTO `purchase_orders` VALUES (70, 110, 1, 70, '2025-10-15 00:49:34.934945', 1, '2025-10-15 00:49:34.934945');
INSERT INTO `purchase_orders` VALUES (71, 140, 1, 71, '2025-10-15 00:49:34.944946', 1, '2025-10-15 00:49:34.944946');
INSERT INTO `purchase_orders` VALUES (72, 95, 1, 72, '2025-10-15 00:49:34.954042', 1, '2025-10-15 00:49:34.954042');
INSERT INTO `purchase_orders` VALUES (73, 80, 1, 73, '2025-10-15 00:49:34.960069', 1, '2025-10-15 00:49:34.960069');
INSERT INTO `purchase_orders` VALUES (74, 90, 1, 74, '2025-10-15 00:49:34.969580', 1, '2025-10-15 00:49:34.969580');
INSERT INTO `purchase_orders` VALUES (75, 70, 1, 75, '2025-10-15 00:49:34.981584', 2, '2025-10-15 08:30:51.973581');
INSERT INTO `purchase_orders` VALUES (76, 60, 1, 76, '2025-10-15 00:49:34.989598', 2, '2025-10-15 08:30:41.576798');
INSERT INTO `purchase_orders` VALUES (77, 85, 1, 77, '2025-10-15 00:49:34.998596', 1, '2025-10-15 00:49:34.998596');
INSERT INTO `purchase_orders` VALUES (78, 50, 1, 78, '2025-10-15 00:49:35.005594', 1, '2025-10-15 00:49:35.005594');
INSERT INTO `purchase_orders` VALUES (79, 65, 1, 79, '2025-10-15 00:49:35.013594', 1, '2025-10-15 00:49:35.013594');
INSERT INTO `purchase_orders` VALUES (80, 40, 1, 80, '2025-10-15 00:49:35.021318', 1, '2025-10-15 00:49:35.021318');
INSERT INTO `purchase_orders` VALUES (81, 75, 1, 81, '2025-10-15 00:49:35.028318', 2, '2025-10-18 12:13:13.723953');
INSERT INTO `purchase_orders` VALUES (82, 95, 1, 82, '2025-10-15 00:49:35.038339', 1, '2025-10-15 00:49:35.038339');
INSERT INTO `purchase_orders` VALUES (83, 80, 1, 83, '2025-10-15 00:49:35.047325', 1, '2025-10-15 00:49:35.047325');
INSERT INTO `purchase_orders` VALUES (84, 100, 1, 84, '2025-10-15 00:49:35.055325', 1, '2025-10-15 00:49:35.055325');

-- ----------------------------
-- Table structure for sell_orders
-- ----------------------------
DROP TABLE IF EXISTS `sell_orders`;
CREATE TABLE `sell_orders`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_quantity` int NOT NULL,
  `order_date` datetime(6) NOT NULL,
  `status` smallint NOT NULL,
  `inventory_items_id` bigint NULL DEFAULT NULL,
  `user_id` bigint NULL DEFAULT NULL,
  `updated_at` datetime(6) NOT NULL,
  `is_deleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sell_orders_inventory_items_id_0d6307f9_fk_inventory_items_id`(`inventory_items_id` ASC) USING BTREE,
  INDEX `sell_orders_user_id_5170fe97_fk_user_info_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `sell_orders_inventory_items_id_0d6307f9_fk_inventory_items_id` FOREIGN KEY (`inventory_items_id`) REFERENCES `inventory_items` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `sell_orders_user_id_5170fe97_fk_user_info_id` FOREIGN KEY (`user_id`) REFERENCES `user_info` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sell_orders
-- ----------------------------
INSERT INTO `sell_orders` VALUES (1, 2, '2025-10-16 08:18:25.593323', 2, 1, 1, '2025-10-16 09:19:57.175673', 0);
INSERT INTO `sell_orders` VALUES (2, 2, '2025-10-16 08:18:29.477519', 2, 1, 1, '2025-10-16 10:02:47.507515', 0);
INSERT INTO `sell_orders` VALUES (3, 2, '2025-10-16 08:18:38.401058', 2, 1, 1, '2025-10-16 10:05:48.303269', 0);
INSERT INTO `sell_orders` VALUES (4, 1, '2025-10-16 08:20:49.454599', 2, 8, 1, '2025-10-16 11:34:01.678033', 0);
INSERT INTO `sell_orders` VALUES (5, 1, '2025-10-16 08:26:09.257672', 2, 3, 1, '2025-10-16 11:07:45.955064', 0);
INSERT INTO `sell_orders` VALUES (6, 5, '2025-10-16 08:27:10.785371', 1, 15, 1, '2025-10-16 08:27:10.785371', 0);
INSERT INTO `sell_orders` VALUES (7, 3, '2025-10-16 08:40:29.784280', 1, 9, 1, '2025-10-16 08:40:29.784280', 0);
INSERT INTO `sell_orders` VALUES (8, 2, '2025-10-16 09:25:09.170279', 1, 4, 1, '2025-10-16 09:25:09.170279', 0);
INSERT INTO `sell_orders` VALUES (9, 2, '2025-10-18 12:11:58.099151', 2, 14, 1, '2025-10-18 12:13:44.755433', 0);
INSERT INTO `sell_orders` VALUES (10, 10, '2025-10-18 12:12:11.382507', 2, 9, 1, '2025-10-18 13:03:48.856877', 0);

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `password` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `gender` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES (1, 'uuu', '686592bbb48ac6aab292ed07355d4ad2', 'syx', 'F', '18116348729', '18116348729@163.com');

SET FOREIGN_KEY_CHECKS = 1;
