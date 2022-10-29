#!/bin/bash
############################################################
# Help                                                     #
############################################################
Help()
{
   # Display Help
   echo "Add description of the script functions here."
   echo
   echo "Syntax: scriptTemplate [-g|h|v|V]"
   echo "options:"
   echo "g     Print the GPL license notification."
   echo "h     Print this Help."
   echo "v     Verbose mode."
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
  /usr/bin/mysql --database="${AUTH_DB}" --user="${DB_USER}" --password="${DB_PASS}" --host="${DB_HOSTNAME}" --port="${DB_PORT}" < ./7.AUTH_CONVERTER.sql
}

############################################################
############################################################
# Main program                                             #
############################################################
############################################################
############################################################
# Process the input options. Add options as needed.        #
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


echo "hello world!"

# migrate dbs
