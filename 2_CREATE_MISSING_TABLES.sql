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

CREATE TABLE `gm_surveys` (
  `surveyId` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `guid` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `mainSurvey` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `overallComment` LONGTEXT NOT NULL,
  `createTime` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `maxMMR` SMALLINT(5) NOT NULL,
  PRIMARY KEY (`surveyId`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 COMMENT='Player System';

CREATE TABLE `gm_tickets` (
  `ticketId` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `guid` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'Global Unique Identifier of ticket creator',
  `name` VARCHAR(12) NOT NULL COMMENT 'Name of ticket creator',
  `message` TEXT NOT NULL,
  `createTime` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `mapId` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '0',
  `posX` FLOAT NOT NULL DEFAULT '0',
  `posY` FLOAT NOT NULL DEFAULT '0',
  `posZ` FLOAT NOT NULL DEFAULT '0',
  `lastModifiedTime` INT(10) UNSIGNED NOT NULL DEFAULT '0',
  `closedBy` INT(10) NOT NULL DEFAULT '0',
  `assignedTo` INT(10) UNSIGNED NOT NULL DEFAULT '0' COMMENT 'GUID of admin to whom ticket is assigned',
  `comment` TEXT NOT NULL,
  `response` TEXT NOT NULL,
  `completed` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `escalated` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `viewed` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  `haveTicket` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`ticketId`)
) ENGINE=INNODB DEFAULT CHARSET=utf8 COMMENT='Player System';

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

---
--- character_settings
---
create table character_settings
(
	guid int(10) unsigned not null,
	source varchar(40) not null,
	data text null,
	primary key (guid, source)
)
 ENGINE=INNODB DEFAULT CHARSET=utf8 comment 'Player Settings';

---
--- game_event_condition_save
---
create table if not exists game_event_condition_save
(
	eventEntry tinyint(3) unsigned not null,
	condition_id int(10) unsigned default 0 not null,
	done float default 0 null,
	primary key (eventEntry, condition_id)
);


---
--- creature_respawn
---
create table creature_respawn
(
	guid int(10) unsigned default 0 not null comment 'Global Unique Identifier',
	respawnTime int(10) unsigned default 0 not null,
	mapId smallint(5) unsigned default 0 not null,
	instanceId int(10) unsigned default 0 not null comment 'Instance Identifier',
	primary key (guid, instanceId)
)
 ENGINE=INNODB DEFAULT CHARSET=utf8 comment 'Grid Loading System';

create index idx_instance
	on creature_respawn (instanceId);

---
--- gameobject_respawn
---
create table gameobject_respawn
(
	guid int(10) unsigned default 0 not null comment 'Global Unique Identifier',
	respawnTime int(10) unsigned default 0 not null,
	mapId smallint(5) unsigned default 0 not null,
	instanceId int(10) unsigned default 0 not null comment 'Instance Identifier',
	primary key (guid, instanceId)
)
 ENGINE=INNODB DEFAULT CHARSET=utf8 comment 'Grid Loading System';

create index idx_instance
	on gameobject_respawn (instanceId);

---
--- instance_saved_go_state_data
---
create table instance_saved_go_state_data
(
	id int(10) unsigned not null comment 'instance.id',
	guid int(10) unsigned not null comment 'gameobject.guid',
	state tinyint(3) unsigned default 0 null comment 'gameobject.state',
	primary key (id, guid)
);

