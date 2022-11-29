# tool-tc-migration

**[EXPERIMENTAL]**

Some tools to migrate the `characters` and `auth` database from TrinityCore to AzerothCore.

**IMPORTANT**: backup your database **before** using this tool.

We cannot guarantee that the operation succeeds without side effects.

## Instructions
In order to take benefit of the scripts we highly recomand to use Unix systems to execute 
the following script (Linux / Mac / Linux subsystem on windows etc)

### Secure your server data
In order to avoid damaging your production server it's highly recomanded to save your data locally,
and work on your data locally.

### Using migration script on unix systems

Create an env file like  following:

**env.sh**
```bash
# TrinityCore Characters DBs separated by colon symbol (:)
export CHARACTERS_DBS="characters:characters_test"

# TrinityCore Auth DB
export AUTH_DB=auth

# DB user / password
export DB_USER=trinity
export DB_PASS=trinity

# Hostname
export DB_HOSTNAME=arthas
export DB_PORT=3306

# Location of your dump files (sql) for characters DBs separated by colon symbol (:) you should use absolute path
export DUMP_CHARACTERS_FILES_PATH="/home/johndoe/dumps/characters_mysql_22_10_29_00_30.sql:/home/johndoe/dumps/characters_test_mysql_22_10_29_00_30.sql"

# Location of your dump file for auth DB
export DUMP_AUTH_FILE_PATH=~/dumps/auth_mysql_22_10_29_00_30.sql
```

Use it as source and execute the migration:
```bash
source env.sh
./migration.sh -a
```

You have several option for the migration:
- `-a`: restore and migrate
- `-r`: restore only
- `-m`: migrate only

### Restore on windows
On Windows the restore have to be done manually after that, you have to execute the migration scripts
on each DB manually.

File 1_xxx.sql to 5_xxx.sql needs to be executed **in numeral order** on characters DBs. 
6.xxx and 7.xxx have to be executed on auth DB. 

### Check data integrity
To check the data integrity I highly recomand to create an AzerothCore server with his own dbs:

Ex in my case:
- `characters`: DB for TrinityCore characters data to migrate
- `auth`: DB for TrinityCore auth data to migrate
- `acore_characters`: Clean AzerothCore characters table
- `acore_auth`: Clean AzerothCore auth table

The following queries will help you to compare the DBs of a same kind:

#### Check what is missing in your migrated `auth` db
```sql
-- AUTH => columns and table IN AzerothCore and missing in TrinityCore
SELECT col_az.TABLE_NAME, col_az.COLUMN_NAME, col_tc.TABLE_NAME, col_tc.COLUMN_NAME
FROM information_schema.columns col_az
LEFT JOIN information_schema.columns col_tc on col_az.TABLE_NAME = col_tc.TABLE_NAME and col_az.COLUMN_NAME = col_tc.COLUMN_NAME
WHERE col_az.table_schema = 'acore_auth'
AND col_az.table_name = 'auth' AND col_tc.COLUMN_NAME is null;
```
If this query returns results it means that some table or columns are missing in your auth table. You can
use `git log -S [my table name]` to find when this table have been created / modified.

#### Check what you should remove in your migrated `auth` db
```sql
-- AUTH => columns and table IN TrinityCore not in AzerothCore
select col_tc.TABLE_NAME, col_tc.COLUMN_NAME FROM information_schema.columns col_tc
LEFT JOIN information_schema.columns col_az on
    col_az.TABLE_NAME = col_tc.TABLE_NAME and
    col_az.COLUMN_NAME = col_tc.COLUMN_NAME and
    col_az.TABLE_SCHEMA = 'acore_auth'
WHERE col_tc.TABLE_SCHEMA = 'auth' and col_az.COLUMN_NAME is null;
```
The columns / table returned in this query have to be removed in your migrated db.

#### Check what is missing in your migrated `characters` db

```sql
-- AUTH => columns and table IN AzerothCore and missing in TrinityCore
SELECT col_az.TABLE_NAME, col_az.COLUMN_NAME, col_tc.TABLE_NAME, col_tc.COLUMN_NAME
FROM information_schema.columns col_az
LEFT JOIN information_schema.columns col_tc on col_az.TABLE_NAME = col_tc.TABLE_NAME and col_az.COLUMN_NAME = col_tc.COLUMN_NAME
WHERE col_az.table_schema = 'acore_characters'
AND col_az.table_name = 'characters' AND col_tc.COLUMN_NAME is null;
```

#### Check what you should remove in your migrated `characters` db
```sql
-- AUTH => columns and table IN TrinityCore not in AzerothCore
select col_tc.TABLE_NAME, col_tc.COLUMN_NAME FROM information_schema.columns col_tc
LEFT JOIN information_schema.columns col_az on
    col_az.TABLE_NAME = col_tc.TABLE_NAME and
    col_az.COLUMN_NAME = col_tc.COLUMN_NAME and
    col_az.TABLE_SCHEMA = 'acore_characters'
WHERE col_tc.TABLE_SCHEMA = 'characters' and col_az.COLUMN_NAME is null;
```
The columns / table returned in this query have to be removed in your migrated db.
**The current script dosn't remove migration tables those which starts with `__`**

**I hope that everything goes well, good fortune my friend.**


## OLD Instructions

http://www.azerothcore.org/wiki/TrinityCore-to-AzerothCore-characters-migration
