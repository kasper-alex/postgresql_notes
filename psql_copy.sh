#!/bin/bash

FROM_DB_USER="db_user"
FROM_DB_NAME="from_db_name"
FROM_DB_HOST="10.20.30.40"
FROM_DB_PORT="5432"
FROM_SQL="copy(select * from TABLE_NAME) to stdout with (format csv, delimiter ';')"

TO_DB_USER="db_user"
TO_DB_NAME="to_db_name"
TO_DB_HOST="40.30.20.10"
TO_DB_PORT="5432"

TO_SQL="copy TABLE_NAME from stdin with (format csv, delimiter ';')"

psql -U "${FROM_DB_USER}" -d "${FROM_DB_NAME}" -h "${FROM_DB_HOST}" -p "${FROM_DB_PORT}" -c "${FROM_SQL}" | psql -U "${TO_DB_USER}" -d "${TO_DB_NAME}" -h "${TO_DB_HOST}" -p "${TO_DB_PORT}" -c "${TO_SQL}"