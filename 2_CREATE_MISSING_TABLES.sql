CREATE TABLE `character_brew_of_the_month` (
  `guid` INT(10) UNSIGNED NOT NULL,
  `lastEventId` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `log_arena_fights` (
  `fight_id` INT(10) UNSIGNED NOT NULL,
  `time` DATETIME NOT NULL,
  `type` TINYINT(3) UNSIGNED NOT NULL,
  `duration` INT(10) UNSIGNED NOT NULL,
  `winner` INT(10) UNSIGNED NOT NULL,
  `loser` INT(10) UNSIGNED NOT NULL,
  `winner_tr` SMALLINT(5) UNSIGNED NOT NULL,
  `winner_mmr` SMALLINT(5) UNSIGNED NOT NULL,
  `winner_tr_change` SMALLINT(6) NOT NULL,
  `loser_tr` SMALLINT(5) UNSIGNED NOT NULL,
  `loser_mmr` SMALLINT(5) UNSIGNED NOT NULL,
  `loser_tr_change` SMALLINT(6) NOT NULL,
  `currOnline` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`fight_id`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;

CREATE TABLE `log_arena_memberstats` (
  `fight_id` INT(10) UNSIGNED NOT NULL,
  `member_id` TINYINT(3) UNSIGNED NOT NULL,
  `name` CHAR(20) NOT NULL,
  `guid` INT(10) UNSIGNED NOT NULL,
  `team` INT(10) UNSIGNED NOT NULL,
  `account` INT(10) UNSIGNED NOT NULL,
  `ip` CHAR(15) NOT NULL,
  `damage` INT(10) UNSIGNED NOT NULL,
  `heal` INT(10) UNSIGNED NOT NULL,
  `kblows` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`fight_id`,`member_id`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;

CREATE TABLE `log_encounter` (
  `time` DATETIME NOT NULL,
  `map` SMALLINT(5) UNSIGNED NOT NULL,
  `difficulty` TINYINT(3) UNSIGNED NOT NULL,
  `creditType` TINYINT(3) UNSIGNED NOT NULL,
  `creditEntry` INT(10) UNSIGNED NOT NULL,
  `playersInfo` TEXT NOT NULL
) ENGINE=MYISAM DEFAULT CHARSET=utf8;

CREATE TABLE `log_money` (
  `sender_acc` INT(11) UNSIGNED NOT NULL,
  `sender_guid` INT(11) UNSIGNED NOT NULL,
  `sender_name` CHAR(32) CHARACTER SET utf8 NOT NULL,
  `sender_ip` CHAR(32) CHARACTER SET utf8 NOT NULL,
  `receiver_acc` INT(11) UNSIGNED NOT NULL,
  `receiver_name` CHAR(32) CHARACTER SET utf8 NOT NULL,
  `money` BIGINT(20) UNSIGNED NOT NULL,
  `topic` CHAR(255) CHARACTER SET utf8 NOT NULL,
  `date` DATETIME NOT NULL
) ENGINE=MYISAM DEFAULT CHARSET=latin1;

CREATE TABLE `gm_subsurveys` (
  `surveyId` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `subsurveyId` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `rank` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `comment` TEXT NOT NULL,
  PRIMARY KEY (`surveyId`,`subsurveyId`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 COMMENT='Player System';

--
-- gm_surveys AC commit: e0d36be56ec2b7c7c88c7b86b81512106cef535e
--
DROP TABLE IF EXISTS `gm_survey`;
CREATE TABLE IF NOT EXISTS `gm_survey` (
  `surveyId` int unsigned NOT NULL AUTO_INCREMENT,
  `guid` int unsigned NOT NULL DEFAULT '0',
  `mainSurvey` int unsigned NOT NULL DEFAULT '0',
  `comment` longtext NOT NULL,
  `createTime` int unsigned NOT NULL DEFAULT '0',
  `maxMMR` smallint NOT NULL,
  PRIMARY KEY (`surveyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Player System';

CREATE TABLE `item_loot_storage` (
  `containerGUID` INT(10) UNSIGNED NOT NULL,
  `itemid` INT(10) UNSIGNED NOT NULL,
  `count` INT(10) UNSIGNED NOT NULL,
  `item_index` int(10) unsigned default 0 not null,
  `randomPropertyId` INT(10) NOT NULL,
  `randomSuffix` INT(10) UNSIGNED NOT NULL,
  `follow_loot_rules` tinyint(3) unsigned not null,
  `freeforall` tinyint(3) unsigned not null,
  `is_blocked` tinyint(3) unsigned not null,
  `is_counted` tinyint(3) unsigned not null,
  `is_underthreshold` tinyint(3) unsigned not null,
  `needs_quest` tinyint(3) unsigned not null,
  `conditionLootId` int(11) default 0 not null
) ENGINE=INNODB DEFAULT CHARSET=utf8;

CREATE TABLE `character_entry_point` (
  `guid` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `joinX` FLOAT NOT NULL DEFAULT '0',
  `joinY` FLOAT NOT NULL DEFAULT '0',
  `joinZ` FLOAT NOT NULL DEFAULT '0',
  `joinO` FLOAT NOT NULL DEFAULT '0',
  `joinMapId` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Map Identifier',
  `taxiPath0` INT(10) UNSIGNED DEFAULT 0 NOT NULL,
  `taxiPath1` INT(10) UNSIGNED DEFAULT 0 NOT NULL,
  `mountSpell` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`guid`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 COMMENT='Player System';


CREATE TABLE `channels_bans` (
  `channelId` INT(10) UNSIGNED NOT NULL,
  `playerGUID` INT(10) UNSIGNED NOT NULL,
  `banTime` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`channelId`,`playerGUID`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;



--
-- Table structure for table `channels_rights`
--

DROP TABLE IF EXISTS `channels_rights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `channels_rights` (
  `name` VARCHAR(128) NOT NULL,
  `flags` INT(10) UNSIGNED NOT NULL,
  `speakdelay` INT(10) UNSIGNED NOT NULL,
  `joinmessage` VARCHAR(255) NOT NULL DEFAULT '',
  `delaymessage` VARCHAR(255) NOT NULL DEFAULT '',
  `moderators` TEXT,
  PRIMARY KEY (`name`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `channels_rights`
--


LOCK TABLES `channels_rights` WRITE;
/*!40000 ALTER TABLE `channels_rights` DISABLE KEYS */;
/*!40000 ALTER TABLE `channels_rights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- character_settings AC commit: d4963f3b83c8a327904addb129d5fd5a15b30d25
--
DROP TABLE IF EXISTS `character_settings`;
CREATE TABLE `character_settings` (
  `guid` INT UNSIGNED NOT NULL,
  `source` VARCHAR(40) NOT NULL,
  `data` TEXT NULL,
  PRIMARY KEY (`guid`, `source`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8mb4 COMMENT='Player Settings';
-- TODO Why ENGINE is MYISAM and not InnoDB like the others ?

--
-- game_event_condition_save AC commit: fc05c82f659692b4c79c85aec1548f6aa0c1d537
--
DROP TABLE IF EXISTS `game_event_condition_save`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game_event_condition_save`
(
  `eventEntry` tinyint(3) unsigned NOT NULL,
  `condition_id` int(10) unsigned NOT NULL DEFAULT '0',
  `done` float DEFAULT '0',
  PRIMARY KEY (`eventEntry`,`condition_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- creature_respawn AC commit: fc05c82f659692b4c79c85aec1548f6aa0c1d537
--
DROP TABLE IF EXISTS `creature_respawn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `creature_respawn`
(
  `guid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `respawnTime` int(10) unsigned NOT NULL DEFAULT '0',
  `mapId` smallint(10) unsigned NOT NULL DEFAULT '0',
  `instanceId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Instance Identifier',
  PRIMARY KEY (`guid`,`instanceId`),
  KEY `idx_instance` (`instanceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Grid Loading System';

--
-- gameobject_respawn AC commit: fc05c82f659692b4c79c85aec1548f6aa0c1d537
--
DROP TABLE IF EXISTS `gameobject_respawn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gameobject_respawn`
(
  `guid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier',
  `respawnTime` int(10) unsigned NOT NULL DEFAULT '0',
  `mapId` smallint(10) unsigned NOT NULL DEFAULT '0',
  `instanceId` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Instance Identifier',
  PRIMARY KEY (`guid`,`instanceId`),
  KEY `idx_instance` (`instanceId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Grid Loading System';

--
-- instance_saved_go_state_data AC commit: a6a2ca8ef76716f5b58b4ed2ae53d0bde424775b
--
DROP TABLE IF EXISTS `instance_saved_go_state_data`;
CREATE TABLE IF NOT EXISTS `instance_saved_go_state_data` (
  `id` INT UNSIGNED NOT NULL COMMENT 'instance.id',
  `guid` INT UNSIGNED NOT NULL COMMENT 'gameobject.guid',
  `state` TINYINT UNSIGNED DEFAULT '0' COMMENT 'gameobject.state',
  PRIMARY KEY (`id`, `guid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- mail_server_character AC commit: 7ecd73867419c807c9869ebeb73c7ca4e39cd1c8
--
DROP TABLE IF EXISTS `mail_server_character`;
CREATE TABLE IF NOT EXISTS `mail_server_character` (
  `guid` INT UNSIGNED NOT NULL,
  `mailId` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`guid`, `mailId`)
) ENGINE=INNODB DEFAULT CHARSET=UTF8MB4;

--
-- mail_server_template AC commit: 7ecd73867419c807c9869ebeb73c7ca4e39cd1c8
--
DROP TABLE IF EXISTS `mail_server_template`;
CREATE TABLE IF NOT EXISTS `mail_server_template` (
  `id` INT unsigned NOT NULL AUTO_INCREMENT,
  `reqLevel` TINYINT unsigned NOT NULL DEFAULT 0,
  `reqPlayTime` INT unsigned NOT NULL DEFAULT 0,
  `moneyA` INT unsigned NOT NULL DEFAULT 0,
  `moneyH` INT unsigned NOT NULL DEFAULT 0,
  `itemA` INT unsigned NOT NULL DEFAULT 0,
  `itemCountA` INT unsigned NOT NULL DEFAULT 0,
  `itemH` INT unsigned NOT NULL DEFAULT 0,
  `itemCountH` INT unsigned NOT NULL DEFAULT 0,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `active` TINYINT unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- recovery_item AC commit: 333dab2e8515e6d8ee3b721c042f5576fde9be2d
--
CREATE TABLE IF NOT EXISTS `recovery_item` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Guid` int(11) unsigned NOT NULL DEFAULT 0,
  `ItemEntry` mediumint(8) unsigned NOT NULL DEFAULT 0,
  `Count` int(11) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`),
  KEY `idx_guid` (`Guid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
