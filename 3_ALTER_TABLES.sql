ALTER TABLE `character_spell_cooldown` ADD COLUMN `needSend` TINYINT(3) UNSIGNED NOT NULL DEFAULT '1' AFTER `categoryEnd`;
ALTER TABLE `auctionhouse` CHANGE COLUMN `houseid` `auctioneerguid` INT(10) UNSIGNED NOT NULL DEFAULT '0' ;
ALTER TABLE `channels` 
ADD COLUMN `channelId` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT FIRST,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`channelId`);

TRUNCATE TABLE `character_talent`;

ALTER TABLE `character_talent` CHANGE COLUMN `talentGroup` `specMask` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' ,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`guid`, `spell`);

ALTER TABLE `characters` 
ADD COLUMN `playerBytes` INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER `money`,
ADD COLUMN `playerBytes2` INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER `playerBytes`;
UPDATE `characters` SET 
 playerBytes = (skin) | (face << 8) | (hairStyle << 16) | (hairColor << 24),
 playerBytes2 = (facialStyle) | (bankSlots << 16) | (restState << 24)
WHERE guid > 0;

ALTER TABLE `characters` DROP COLUMN `skin`;
ALTER TABLE `characters` DROP COLUMN `face`;
ALTER TABLE `characters` DROP COLUMN `hairStyle`;
ALTER TABLE `characters` DROP COLUMN `hairColor`;
ALTER TABLE `characters` DROP COLUMN `facialStyle`;
ALTER TABLE `characters` DROP COLUMN `bankSlots`;
ALTER TABLE `characters` DROP COLUMN `restState`;

ALTER TABLE `character_instance` CHANGE COLUMN `extendState` `extended` TINYINT(2) UNSIGNED NOT NULL DEFAULT '0' ;

ALTER TABLE `character_arena_stats` ADD COLUMN `maxMMR` SMALLINT(5) NOT NULL AFTER `matchMakerRating`;

TRUNCATE TABLE `corpse`;
ALTER TABLE `corpse` 
ADD COLUMN `corpseGuid` INT(10) UNSIGNED NOT NULL DEFAULT '0' FIRST,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`corpseGuid`, `guid`);

ALTER TABLE `character_aura` ADD COLUMN `itemGuid` BIGINT(20) NOT NULL AFTER `casterGuid`;

ALTER TABLE character_spell DROP COLUMN `active`;
ALTER TABLE character_spell DROP COLUMN `disabled`;
ALTER TABLE character_spell ADD `specMask` TINYINT(3) UNSIGNED NOT NULL DEFAULT 255;
