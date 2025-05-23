CREATE TABLE IF NOT EXISTS `banned_users` (
  `identifier` varchar(50) NOT NULL,
  `steamname` varchar(50) NOT NULL,
  `banned` int(1) DEFAULT 0,
  `bannedReason` longtext DEFAULT NULL,
  `warnings` int(11) DEFAULT 0,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;
