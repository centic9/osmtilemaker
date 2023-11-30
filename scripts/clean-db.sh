#!/bin/bash

# Settings
set -e # Be sure we fail on error and output debugging information
trap 'echo "$0: error on line $LINENO"' ERR
set -x # Print commands and their arguments as they are executed

# Config reading
here="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. $here/../conf/config

echo
echo ------------------------------------------------------
echo Drop PGSQL user and database with extensions
echo

psql -v ON_ERROR_STOP=1 -U "$POSTGRES_USER" <<-EOSQL
    DROP DATABASE IF EXISTS $DBPG_DATABASE_NAME;
    DROP USER IF EXISTS $DBPG_USER_OSMTILEMAKER_USERNAME;
EOSQL
