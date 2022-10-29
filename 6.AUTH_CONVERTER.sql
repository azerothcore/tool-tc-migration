ALTER TABLE `account`
		ADD COLUMN `totaltime` INT(10) UNSIGNED NOT NULL DEFAULT '0' AFTER `recruiter`;

DROP PROCEDURE IF EXISTS change_column_name;
DELIMITER //
CREATE PROCEDURE change_column_name()
BEGIN
    IF EXISTS(SELECT NULL
            FROM information_schema.columns
            WHERE table_schema = database()
            AND table_name = 'account_access'
            AND column_name = 'SecurityLevel'
    )
    THEN
        ALTER TABLE account_access CHANGE SecurityLevel gmlevel tinyint(3) unsigned;
    END IF;
    IF EXISTS(SELECT NULL
            FROM information_schema.columns
            WHERE table_schema = database()
            AND table_name = 'account_access'
            AND column_name = 'AccountID'
    )
    THEN
        ALTER TABLE account_access CHANGE AccountID id int(10) unsigned;
    END IF;
END;
//
DELIMITER ;
CALL change_column_name();
DROP PROCEDURE IF EXISTS change_column_name;