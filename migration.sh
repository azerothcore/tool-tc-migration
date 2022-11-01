#!/bin/bash
############################################################
# Help                                                     #
############################################################
Help()
{
   # Display Help
   echo "Restore & migrate TrinityCore DB to AzerothCore DB"
   echo
   echo "Syntax: scriptTemplate [-a|-r|-m]"
   echo "options:"
   echo "a     Restore and migrate DB"
   echo "r     REstore original TrinityCore DB"
   echo "m     Migrate TrinityCore DB to AzerothCore DB"
   echo "V     Print software version and exit."
   echo
}

Restore()
{
  /usr/bin/mysql --database="${CHARACTERS_DB}" \
  --user="${DB_USER}" \
  --password="${DB_PASS}" \
  --host="${DB_HOSTNAME}" \
  --port="${DB_PORT}" \
  -e "
  DROP DATABASE ${CHARACTERS_DB};
  CREATE DATABASE  ${CHARACTERS_DB};
  DROP DATABASE ${AUTH_DB};
  CREATE DATABASE  ${AUTH_DB};
  "

  /usr/bin/mysql --database="${CHARACTERS_DB}" --user="${DB_USER}" --password="${DB_PASS}" --host="${DB_HOSTNAME}" --port="${DB_PORT}" < "${DUMP_CHARACTERS_FILE_PATH}"
  /usr/bin/mysql --database="${AUTH_DB}" --user="${DB_USER}" --password="${DB_PASS}" --host="${DB_HOSTNAME}" --port="${DB_PORT}" < "${DUMP_AUTH_FILE_PATH}"
}

Migrate()
{
  /usr/bin/mysql --database="${CHARACTERS_DB}" --user="${DB_USER}" --password="${DB_PASS}" --host="${DB_HOSTNAME}" --port="${DB_PORT}" < ./1_CREATE_CLEANUP_TABLES.sql
  /usr/bin/mysql --database="${CHARACTERS_DB}" --user="${DB_USER}" --password="${DB_PASS}" --host="${DB_HOSTNAME}" --port="${DB_PORT}" < ./2_CREATE_MISSING_TABLES.sql
  /usr/bin/mysql --database="${CHARACTERS_DB}" --user="${DB_USER}" --password="${DB_PASS}" --host="${DB_HOSTNAME}" --port="${DB_PORT}" < ./3_ALTER_TABLES.sql
  /usr/bin/mysql --database="${CHARACTERS_DB}" --user="${DB_USER}" --password="${DB_PASS}" --host="${DB_HOSTNAME}" --port="${DB_PORT}" < ./4_CLEANUP_AND_CONVERT_SPELLS.sql
  /usr/bin/mysql --database="${CHARACTERS_DB}" --user="${DB_USER}" --password="${DB_PASS}" --host="${DB_HOSTNAME}" --port="${DB_PORT}" < ./5_FINAL_CLEANUP.sql
  /usr/bin/mysql --database="${AUTH_DB}" --user="${DB_USER}" --password="${DB_PASS}" --host="${DB_HOSTNAME}" --port="${DB_PORT}" < ./6.AUTH_RENAME_COLUMNS.sql
  /usr/bin/mysql --database="${AUTH_DB}" --user="${DB_USER}" --password="${DB_PASS}" --host="${DB_HOSTNAME}" --port="${DB_PORT}" < ./7.AUTH_CLEAN_AND_CONVERTER.sql
}

############################################################
# Main program                                             #
############################################################
# Get the options
while getopts ":hrma" option; do
   case $option in
      h) # display Help
         Help
         exit;;
      r) # Enter a name
        Restore
        exit;;
      m) # Enter a name
        Migrate
        exit;;
      a) # Enter a name
        Restore
        Migrate
        exit;;
     \?) # Invalid option
         echo "Error: Invalid option"
         exit;;
   esac
done
# migrate dbs
