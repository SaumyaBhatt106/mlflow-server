# Use the official Ubuntu image
FROM ubuntu:latest

# Set the working directory
WORKDIR /app

# Update the package lists and install necessary packages
RUN apt-get update \
    && apt-get install -y python3 python3-pip \
    && pip3 install mlflow

# Expose the container port
EXPOSE 5000

# Run MLflow UI when the container starts
CMD ["mlflow", "ui", "-h", "0.0.0.0", "-p", "5000"]
