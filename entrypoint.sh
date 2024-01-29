#!/bin/bash
set -e

DATASTORE_URI="postgresql://$DB_USER:$DB_PASSWORD@$DB_HOST:$DB_PORT/$DB_DATABASE"
AUTH_DATASTORE_URI="postgresql://$AUTH_DB_USER:$AUTH_DB_PASSWORD@$AUTH_DB_HOST:$AUTH_DB_PORT/$AUTH_DB_DATABASE"

# Updating in-built migration file to point to our store
BASIC_AUTH_FILE="./venv/lib/python3.10/site-packages/mlflow/server/auth/basic_auth.ini"
sed -i "s|database_uri =.*|database_uri = $AUTH_DATASTORE_URI|g" "$BASIC_AUTH_FILE"

export MLFLOW_S3_ENDPOINT_URL=$AWS_S3_URI
export MLFLOW_S3_IGNORE_TLS=true
export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY

echo -e "Logs Datastore uri:\t$DATASTORE_URI"
echo -e "Auth Datastore uri:\t$AUTH_DATASTORE_URI"
echo -e "Artifact storage:\t$AWS_S3_URI/$AWS_S3_BUCKET_NAME"

mlflow server \
    --backend-store-uri "$DATASTORE_URI" \
    --artifacts-destination s3://$AWS_S3_BUCKET_NAME \
    --app-name basic-auth \
    --serve-artifacts \
    --workers 1 \
    --host 0.0.0.0 \
    --port 5000 \
