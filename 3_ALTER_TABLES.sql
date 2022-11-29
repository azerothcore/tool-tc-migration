-- character_spell_cooldown / pet_spell_cooldown AC commit: bd956b5a5750014bd4168dd82df3438dcc5df43f
ALTER TABLE `character_spell_cooldown` ADD COLUMN `category` MEDIUMINT UNSIGNED DEFAULT 0 NOT NULL AFTER `spell`;
ALTER TABLE `pet_spell_cooldown` ADD COLUMN `category` MEDIUMINT UNSIGNED DEFAULT 0 NOT NULL AFTER `spell`;

ALTER TABLE `character_spell_cooldown` ADD COLUMN `needSend` tinyint(3) unsigned DEFAULT 1 NOT NULL AFTER `time`;

ALTER TABLE `character_spell_cooldown` DROP COLUMN `categoryEnd`;
ALTER TABLE `character_spell_cooldown` DROP COLUMN `categoryId`;
ALTER TABLE `pet_spell_cooldown` DROP COLUMN `categoryEnd`;
ALTER TABLE `pet_spell_cooldown` DROP COLUMN `categoryId`;

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
ALTER TABLE `characters` ADD COLUMN `creation_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `grantableLevels`;

-- character_homebind AC commit: 2e6f6e26da8f01cd67bbb56e0e7aa961ffd5f51f
ALTER TABLE `character_homebind` ADD COLUMN `posO` FLOAT NOT NULL DEFAULT '0' AFTER `posZ`;

-- log_money AC commit: 2fec54c4429a03b406b30bbce29c5b376ad04e31
ALTER TABLE `log_money` ADD COLUMN `type` TINYINT NOT NULL COMMENT '1=COD,2=AH,3=GB DEPOSIT,4=GB WITHDRAW,5=MAIL,6=TRADE' AFTER `date`;

--
ALTER TABLE auctionhouse DROP COLUMN `Flags`;

--
ALTER TABLE pet_aura DROP COLUMN `critChance`;
ALTER TABLE pet_aura DROP COLUMN `applyResilience`;

--
ALTER TABLE character_aura DROP COLUMN `critChance`;
ALTER TABLE character_aura DROP COLUMN `applyResilience`;

--
ALTER TABLE channels DROP COLUMN `bannedList`;

--
ALTER TABLE corpse DROP COLUMN `corpseGuid`;
