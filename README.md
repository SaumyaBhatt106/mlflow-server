# mlflow-server

All changes pushed to the `main` branch will execute a github-job to build and push a new image to [DockerHub Repo](https://hub.docker.com/repository/docker/saumyabhatt106/mlflow-server/general)

**NOTE**

1. User related data (permissions and authorizations) will no persists if the server goes down. This is a [known issue](https://github.com/mlflow/mlflow/issues/9155)
2. Make sure to connect to a postgres server and provide the related data in the [.env](./.env) file. This is where all the logging and the experiment data will persists.
3. Only the user who has created an experiment can add runs related to it. Currently, there is no provision to allow access for multiple users working on the same experiment.

## Setup and Running locally

1. Provide the required configs in the `.env` file.

```txt
# Sample .env file contents

#[db.config.properties]
DB_USERNAME=***
DB_PASSWORD=***
DB_DATABASE=mlflowdb
DB_HOST=host.docker.internal
DB_PORT=5431

AWS_S3_URI=http://192.168.4.211:9000
AWS_S3_BUCKET_NAME=bucket

AWS_ACCESS_KEY_ID=minio_user
AWS_SECRET_ACCESS_KEY=minio_password

```

2. Run the below given command to run ml-flow server locally.

```bash
docker run -d -p 5001:5000 --name mlflow-server --env-file .env saumyabhatt106/mlflow-server
```

The ML-Flow UI would be available at `http://localhost:5001`

### Note

One can locally setup the postgres and the S3 storage (using MinIO) using docker. Run the below commands to set it up:

```bash
docker compose -f ./create.compose.yml up -d
```

## Authorisation and Authentication

1. When accessing the server, one would first encounter a log-in prompt.
2. For new users, contact the admin to create an account for yourself before logging in.
3. The admin will create a username and password for yourself. This combo will be used for:
    1. Logging in to the ML-flow UI
    2. Tagging your experiments and runs.
  
## Tagging Experiments and Runs

* Tag your experiments otherwise anyone could delete/modify it from the UI.*
* Admin has the privileges to access/modify any experiments and runs. Rest all can only view other’s experiments and runs.*

```python
os.environ['MLFLOW_TRACKING_USERNAME'] = "saumi"
os.environ['MLFLOW_TRACKING_PASSWORD'] = "1234"

mlflow.create_experiment('2W_ahmedabad')
mlflow.set_tracking_uri('http://localhost:5000')
```
