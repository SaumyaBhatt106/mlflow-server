#!/bin/bash
set -e

# DEFAULT_AUTH_FILE="default_auth.ini"

DATASTORE_URI="postgresql://$DB_USERNAME:$DB_PASSWORD@$DB_HOST:$DB_PORT/$DB_DATABASE"
echo "Connecting to datastore : $DATASTORE_URI"

# echo "Pointing user DB to provided URI"
# sed -i "s|database_uri =.*|database_uri = $DATASTORE_URI|g" "$DEFAULT_AUTH_FILE"
# export MLFLOW_AUTH_CONFIG_PATH=./$DEFAULT_AUTH_FILE

export MLFLOW_S3_ENDPOINT_URL=$AWS_S3_URI
export MLFLOW_S3_IGNORE_TLS=true
export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY

echo "Artifact storage at :$AWS_S3_URI/$AWS_S3_BUCKET_NAME"

mlflow server \
    --backend-store-uri "$DATASTORE_URI" \
    --artifacts-destination s3://$AWS_S3_BUCKET_NAME \
    --app-name basic-auth \
    --serve-artifacts \
    --host 0.0.0.0 \
    --port 5000 \
