
CREATE TABLE IF NOT EXISTS `admin_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(40) NOT NULL,
  `steamname` varchar(50) NOT NULL,
  `action` longtext NOT NULL,
  `date` varchar(50) NOT NULL,
  `timestamp` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
