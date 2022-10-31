-- character_spell_cooldown
ALTER TABLE `character_spell_cooldown` ADD COLUMN `needSend` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1' AFTER `categoryEnd`;

-- channels
ALTER TABLE `channels` 
ADD COLUMN `channelId` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT FIRST,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`channelId`);

-- character_talent
TRUNCATE TABLE `character_talent`;
ALTER TABLE `character_talent` CHANGE COLUMN `talentGroup` `specMask` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' ,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`guid`, `spell`);

-- character_instance
ALTER TABLE `character_instance` CHANGE COLUMN `extendState` `extended` TINYINT(2) UNSIGNED NOT NULL DEFAULT '0' ;

-- character_arena_stats
ALTER TABLE `character_arena_stats` ADD COLUMN `maxMMR` SMALLINT(5) NOT NULL AFTER `matchMakerRating`;

-- corpse
TRUNCATE TABLE `corpse`;
ALTER TABLE `corpse` 
ADD COLUMN `corpseGuid` INT(10) UNSIGNED NOT NULL DEFAULT '0' FIRST,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`corpseGuid`, `guid`);

-- character_spell
ALTER TABLE character_spell DROP COLUMN `active`;
ALTER TABLE character_spell DROP COLUMN `disabled`;
ALTER TABLE character_spell ADD `specMask` TINYINT(3) UNSIGNED NOT NULL DEFAULT 255;

-- characters
ALTER TABLE characters ADD `order` tinyint(4) NULL AFTER grantableLevels;