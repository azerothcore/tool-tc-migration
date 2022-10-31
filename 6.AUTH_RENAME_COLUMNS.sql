
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

    IF EXISTS(SELECT NULL
            FROM information_schema.columns
            WHERE table_schema = database()
            AND table_name = 'account'
            AND column_name = 'session_key_auth'
    )
    THEN
        ALTER TABLE account CHANGE session_key_auth session_key binary(40);
    END IF;
END;
//
DELIMITER ;
CALL change_column_name();
DROP PROCEDURE change_column_name;

ALTER TABLE account DROP COLUMN session_key_bnet;