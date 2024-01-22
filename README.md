# mlflow-server

All changes pushed to the `main` branch will execute a github-job to build and push a new image to [DockerHub Repo](https://hub.docker.com/repository/docker/saumyabhatt106/mlflow-server/general)

## Setup and Running locally

Run the below given command to run ml-flow server locally. Plan is to shift this to an EC2 instance eventually.

```bash
docker run -d -p 5001:5000 --name mlflow-server saumyabhatt106/mlflow-server
```

The ML-Flow UI would be available at `http://localhost:5001`

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
