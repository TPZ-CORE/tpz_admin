CREATE TABLE IF NOT EXISTS `banned_users` (
  `identifier` varchar(50) NOT NULL,
  `steamname` varchar(50) DEFAULT NULL,
  `banned` int(1) DEFAULT 0,
  `bannedReason` longtext CHARACTER SET utf16 COLLATE utf16_unicode_ci DEFAULT 'N/A',
  `warnings` int(11) DEFAULT 0,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;
