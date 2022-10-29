# restore dbs
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

# migrate dbs
/usr/bin/mysql --database="${CHARACTERS_DB}" --user="${DB_USER}" --password="${DB_PASS}" --host="${DB_HOSTNAME}" --port="${DB_PORT}" < ./1_CREATE_CLEANUP_TABLES.sql
/usr/bin/mysql --database="${CHARACTERS_DB}" --user="${DB_USER}" --password="${DB_PASS}" --host="${DB_HOSTNAME}" --port="${DB_PORT}" < ./2_CREATE_MISSING_TABLES.sql
/usr/bin/mysql --database="${CHARACTERS_DB}" --user="${DB_USER}" --password="${DB_PASS}" --host="${DB_HOSTNAME}" --port="${DB_PORT}" < ./3_ALTER_TABLES.sql
/usr/bin/mysql --database="${CHARACTERS_DB}" --user="${DB_USER}" --password="${DB_PASS}" --host="${DB_HOSTNAME}" --port="${DB_PORT}" < ./4_CLEANUP_AND_CONVERT_SPELLS.sql
/usr/bin/mysql --database="${CHARACTERS_DB}" --user="${DB_USER}" --password="${DB_PASS}" --host="${DB_HOSTNAME}" --port="${DB_PORT}" < ./5_FINAL_CLEANUP.sql
/usr/bin/mysql --database="${AUTH_DB}" --user="${DB_USER}" --password="${DB_PASS}" --host="${DB_HOSTNAME}" --port="${DB_PORT}" < ./6.AUTH_CONVERTER.sql
