SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for delivery_tracking
-- ----------------------------
DROP TABLE IF EXISTS `delivery_tracking`;
CREATE TABLE `delivery_tracking`  (
  `order_id` int(0) NOT NULL COMMENT '订单编号',
  `receiver_phone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收件人电话',
  `disp_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '配送员编号',
  `estimated_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '预计到达时间',
  `is_delivered` int(0) NOT NULL DEFAULT 0 COMMENT '是否签收：0=未签收,1=已签收',
  PRIMARY KEY (`order_id`) USING BTREE,
  INDEX `disp_id`(`disp_id`) USING BTREE,
  CONSTRAINT `fk_disp_id` FOREIGN KEY (`disp_id`) REFERENCES `dispatcher` (`dispatcher_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_order_id` FOREIGN KEY (`order_id`) REFERENCES `logistics_order` (`order_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of delivery_tracking
-- ----------------------------
INSERT INTO `delivery_tracking` VALUES (1, '18120431901', '000002', '9天', 0);
INSERT INTO `delivery_tracking` VALUES (2, '18120431901', '000001', '2天', 1);
INSERT INTO `delivery_tracking` VALUES (4, '18120431901', '000010', '3天', 0);
INSERT INTO `delivery_tracking` VALUES (14, '18120431901', '000003', '10天', 0);
INSERT INTO `delivery_tracking` VALUES (19, '18120431901', '000003', '9天', 0);
INSERT INTO `delivery_tracking` VALUES (20, '18120431901', '000006', '2天', 0);

-- ----------------------------
-- Table structure for dispatcher
-- ----------------------------
DROP TABLE IF EXISTS `dispatcher`;
CREATE TABLE `dispatcher`  (
  `dispatcher_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `dispatcher_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `dispatcher_phone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`dispatcher_id`) USING BTREE,
  UNIQUE INDEX `dispatcher_id`(`dispatcher_id`) USING BTREE,
  INDEX `dispatcher_name`(`dispatcher_name`) USING BTREE,
  INDEX `dispatcher_phone`(`dispatcher_phone`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dispatcher
-- ----------------------------
INSERT INTO `dispatcher` VALUES ('000001', '云迹', '13365789765');
INSERT INTO `dispatcher` VALUES ('000002', '跃跃', '15878977898');
INSERT INTO `dispatcher` VALUES ('000003', '维萩', '13526777887');
INSERT INTO `dispatcher` VALUES ('000004', '褐果', '15965578765');
INSERT INTO `dispatcher` VALUES ('000006', '豆苗', '15965578765');
INSERT INTO `dispatcher` VALUES ('000007', '伊桑', '15965578765');
INSERT INTO `dispatcher` VALUES ('000010', '布丁', '15976231548');

-- ----------------------------
-- Table structure for logistics_order
-- ----------------------------
DROP TABLE IF EXISTS `logistics_order`;
CREATE TABLE `logistics_order`  (
  `order_id` int(0) NOT NULL AUTO_INCREMENT,
  `from_warehouse` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '发货仓库',
  `freight` int(0) NOT NULL COMMENT '运费',
  `transport_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '运输方式',
  `receiver_phone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收件人电话',
  `receiver_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收件人姓名',
  `receiver_address` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '收件地址',
  `checked` int(0) NULL DEFAULT 0 COMMENT '订单状态：0=待接单,1=配送中,2=已签收',
  `create_time` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建时间',
  `size` int(0) NOT NULL COMMENT '订单大小',
  PRIMARY KEY (`order_id`) USING BTREE,
  UNIQUE INDEX `order_id`(`order_id`) USING BTREE,
  INDEX `from_warehouse`(`from_warehouse`) USING BTREE,
  INDEX `transport_type`(`transport_type`) USING BTREE,
  INDEX `receiver_phone`(`receiver_phone`) USING BTREE,
  INDEX `checked`(`checked`) USING BTREE,
  INDEX `idx_warehouse_transport`(`from_warehouse`, `transport_type`) USING BTREE,
  CONSTRAINT `fk_from_warehouse` FOREIGN KEY (`from_warehouse`) REFERENCES `warehouse` (`warehouse_name`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logistics_order
-- ----------------------------
INSERT INTO `logistics_order` VALUES (1, '北京仓库', 200, '空运', '18120431901', '张三', '北京市朝阳区', 1, '2023-10-01 10:00:00', 50);
INSERT INTO `logistics_order` VALUES (2, '上海仓库', 150, '陆运', '18120431901', 'uu', '上海市浦东新区', 2, '2023-10-02 14:30:00', 80);
INSERT INTO `logistics_order` VALUES (4, '上海仓库', 60, '空运', '18120431901', 'uu', '14区', 1, '2025-05-20 13:01:01', 60);
INSERT INTO `logistics_order` VALUES (14, '上海仓库', 800, '空运', '18120431901', '渡桥', '桂林电子科技大学', 1, '2025-05-20 21:08:09', 44);
INSERT INTO `logistics_order` VALUES (15, '北京仓库', 580, '海运', '18120431901', '卢丽', '北京', 0, '2025-05-20 21:43:37', 60);
INSERT INTO `logistics_order` VALUES (19, '北京仓库', 64000, '空运', '18120431901', '洋洋', '北京大学', 1, '2025-05-20 22:35:15', 30);
INSERT INTO `logistics_order` VALUES (20, '武汉仓库', 7200, '空运', '18120431901', '里', '江汉路', 1, '2025-05-20 22:37:48', 20);
INSERT INTO `logistics_order` VALUES (21, '上海仓库', 49500, '海运', '18120431901', '零零', '张家界', 0, '2025-05-21 00:56:08', 99);
INSERT INTO `logistics_order` VALUES (22, '上海仓库', 10000, '海运', '18120431901', '1717', '17教', 0, '2025-05-21 16:02:05', 20);

-- ----------------------------
-- Table structure for transport_type_stat
-- ----------------------------
DROP TABLE IF EXISTS `transport_type_stat`;
CREATE TABLE `transport_type_stat`  (
  `transport_type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '运输方式',
  `order_count` int(0) NOT NULL COMMENT '订单数量',
  `fright` int(0) NOT NULL COMMENT '运费',
  PRIMARY KEY (`transport_type`) USING BTREE,
  UNIQUE INDEX `transport_type`(`transport_type`) USING BTREE,
  INDEX `order_count`(`order_count`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of transport_type_stat
-- ----------------------------
INSERT INTO `transport_type_stat` VALUES ('海运', 3, 500);
INSERT INTO `transport_type_stat` VALUES ('空运', 5, 800);
INSERT INTO `transport_type_stat` VALUES ('陆运', 3, 630);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `telephone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `role` int(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE COMMENT '主键索引，选UNIQUE',
  INDEX `username`(`username`) USING BTREE,
  INDEX `password`(`password`) USING BTREE,
  INDEX `telephone`(`telephone`) USING BTREE,
  INDEX `role`(`role`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (2, 'koga', '000000', '18120431901', 0);
INSERT INTO `user` VALUES (3, 'uuu', '123456', '15877151960', 1);

-- ----------------------------
-- Table structure for user_msg
-- ----------------------------
DROP TABLE IF EXISTS `user_msg`;
CREATE TABLE `user_msg`  (
  `id` int(0) UNSIGNED NULL DEFAULT NULL,
  `real_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sex` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `age` int(0) NOT NULL,
  `mail` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `phone` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  INDEX `userid`(`id`) USING BTREE,
  INDEX `real_name`(`real_name`) USING BTREE,
  INDEX `sex`(`sex`) USING BTREE,
  INDEX `age`(`age`) USING BTREE,
  INDEX `mail`(`mail`) USING BTREE,
  INDEX `phone`(`phone`) USING BTREE,
  INDEX `user_name`(`user_name`) USING BTREE,
  CONSTRAINT `userid` FOREIGN KEY (`id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_msg
-- ----------------------------
INSERT INTO `user_msg` VALUES (2, '刘大', '女', 19, '320836@qq.com', '18120431901', 'koga');
INSERT INTO `user_msg` VALUES (3, '路威威', '女', 20, '787898@qq.com', '1587151960', 'uuu');

-- ----------------------------
-- Table structure for warehouse
-- ----------------------------
DROP TABLE IF EXISTS `warehouse`;
CREATE TABLE `warehouse`  (
  `warehouse_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '仓库名称',
  `storage_capacity` int(0) NOT NULL COMMENT '仓库容量（单位：立方米）',
  `throughput` int(0) NOT NULL COMMENT '月吞吐量',
  PRIMARY KEY (`warehouse_name`) USING BTREE,
  UNIQUE INDEX `warehouse_name`(`warehouse_name`) USING BTREE,
  INDEX `storage_capacity`(`storage_capacity`) USING BTREE,
  INDEX `throughput`(`throughput`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of warehouse
-- ----------------------------
INSERT INTO `warehouse` VALUES ('上海仓库', 6000, 900);
INSERT INTO `warehouse` VALUES ('北京仓库', 5000, 300);
INSERT INTO `warehouse` VALUES ('武汉仓库', 9200, 600);

-- ----------------------------
-- View structure for active_deliveries
-- ----------------------------
DROP VIEW IF EXISTS `active_deliveries`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `active_deliveries` AS select `lo`.`order_id` AS `order_id`,`lo`.`from_warehouse` AS `warehouse`,`dt`.`disp_id` AS `disp_id`,`dt`.`estimated_time` AS `estimated_time` from (`logistics_order` `lo` join `delivery_tracking` `dt` on((`lo`.`order_id` = `dt`.`order_id`))) where (`lo`.`checked` = 1);

-- ----------------------------
-- View structure for completed_deliveries
-- ----------------------------
DROP VIEW IF EXISTS `completed_deliveries`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `completed_deliveries` AS select `lo`.`order_id` AS `order_id`,`lo`.`from_warehouse` AS `warehouse`,`dt`.`disp_id` AS `disp_id`,`dt`.`estimated_time` AS `estimated_time`,`d`.`dispatcher_phone` AS `dispatcher_phone` from ((`logistics_order` `lo` join `delivery_tracking` `dt` on((`lo`.`order_id` = `dt`.`order_id`))) join `dispatcher` `d` on((`dt`.`disp_id` = `d`.`dispatcher_id`))) where (`lo`.`checked` = 2);

-- ----------------------------
-- Triggers structure for table delivery_tracking
-- ----------------------------
DROP TRIGGER IF EXISTS `delivery_tracking_insert`;
delimiter ;;
CREATE TRIGGER `delivery_tracking_insert` AFTER INSERT ON `delivery_tracking` FOR EACH ROW BEGIN
  
  UPDATE logistics_order 
  SET checked = 1 
  WHERE order_id = NEW.order_id;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table logistics_order
-- ----------------------------
DROP TRIGGER IF EXISTS `order_insert`;
delimiter ;;
CREATE TRIGGER `order_insert` AFTER INSERT ON `logistics_order` FOR EACH ROW BEGIN
  
  UPDATE transport_type_stat 
  SET order_count = order_count + 1 
  WHERE transport_type = NEW.transport_type;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table logistics_order
-- ----------------------------
DROP TRIGGER IF EXISTS `update_warehouse_capacity`;
delimiter ;;
CREATE TRIGGER `update_warehouse_capacity` AFTER INSERT ON `logistics_order` FOR EACH ROW BEGIN
  
  UPDATE warehouse 
  SET storage_capacity = storage_capacity - NEW.size 
  WHERE warehouse_name = NEW.from_warehouse;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
