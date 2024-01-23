#!/bin/bash
set -e

DEFAULT_AUTH_FILE="default_auth.ini"
DB_CONFIGS=".env"

if [ -f "$DB_CONFIGS" ]; then
    source "$DB_CONFIGS"

    DATASTORE_URI="postgresql://$DB_USERNAME:$DB_PASSWORD@$DB_HOST:$DB_PORT/$DB_DATABASE"
    echo "Connecting to datastore : $DATASTORE_URI"

    # echo "Pointing user DB to provided URI"
    # sed -i "s|database_uri =.*|database_uri = $DATASTORE_URI|g" "$DEFAULT_AUTH_FILE"
    # export MLFLOW_AUTH_CONFIG_PATH=./$DEFAULT_AUTH_FILE

    mlflow server \
    --backend-store-uri "$DATASTORE_URI" \
    --app-name basic-auth \
    --host 0.0.0.0 \
    --port 5000

else
    echo "Error : $DB_CONFIGS not found"
fi
