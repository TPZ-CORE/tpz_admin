
CREATE TABLE IF NOT EXISTS `admin_tickets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(40) NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `steamname` varchar(50) NOT NULL,
  `fullname` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `message` longtext NOT NULL,
  `exclamation` int(11) DEFAULT 0,
  `date` varchar(50) NOT NULL,
  `timestamp` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
