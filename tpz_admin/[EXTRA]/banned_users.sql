CREATE TABLE IF NOT EXISTS `banned_users` (
  `identifier` varchar(50) NOT NULL,
  `steamname` varchar(50) DEFAULT NULL,
  `banned` int(1) DEFAULT 0,
  `bannedReason` longtext DEFAULT NULL,
  `warnings` int(11) DEFAULT 0,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
