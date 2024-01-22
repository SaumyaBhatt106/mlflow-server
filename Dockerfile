FROM ubuntu:latest

WORKDIR /app

  RUN chmod -R 777 . \
    && apt-get update \
    && apt-get install -y python3 python3-pip \
    && apt-get install -y python3.10-venv \
    && pip3 install virtualenv

RUN python3 -m venv venv
ENV PATH="/app/venv/bin:$PATH"

RUN pip install mlflow

EXPOSE 5000

CMD ["mlflow", "server", "--app-name", "basic-auth",]
