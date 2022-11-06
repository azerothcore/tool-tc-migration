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
   echo "r     Restore original TrinityCore DB"
   echo "m     Migrate TrinityCore DB to AzerothCore DB"
   echo "c     Migrate only Characters table from TrinityCore DB to AzerothCore DB"
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

MigrateAuth()
{
  MIGRATION_FILE=('1_CREATE_CLEANUP_TABLES' '2_CREATE_MISSING_TABLES' '3_ALTER_TABLES' '4_CLEANUP_AND_CONVERT_SPELLS' '5_FINAL_CLEANUP')
  for file_name in "${MIGRATION_FILE[@]}"
  do
    echo "Execute: $file_name"
    /usr/bin/mysql --database="${CHARACTERS_DB}" --user="${DB_USER}" --password="${DB_PASS}" --host="${DB_HOSTNAME}" --port="${DB_PORT}" < ./"${file_name}".sql
  done
}

MigrateCharacters()
{
  MIGRATION_FILE=('6.AUTH_RENAME_COLUMNS' '7.AUTH_CLEAN_AND_CONVERTER')
  for file_name in "${MIGRATION_FILE[@]}"
  do
    echo "Execute: $file_name"
    /usr/bin/mysql --database="${AUTH_DB}" --user="${DB_USER}" --password="${DB_PASS}" --host="${DB_HOSTNAME}" --port="${DB_PORT}" < ./"${file_name}".sql
  done
}

############################################################
# Main program                                             #
############################################################
# Get the options
while getopts ":hrmac" option; do
   case $option in
      h) # display Help
         Help
         exit;;
      r) # Enter a name
        Restore
        exit;;
      m) # Enter a name
        MigrateAuth
        MigrateCharacters
        exit;;
      a) # Enter a name
        Restore
        MigrateAuth
        MigrateCharacters
        exit;;
      c) # Enter a name
        Restore
        MigrateCharacters
        exit;;
     \?) # Invalid option
         Help
         exit;;
   esac
done
# migrate dbs
