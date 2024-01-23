FROM ubuntu:latest

WORKDIR /app

RUN chmod -R 777 . \
    && apt-get update \
    && apt-get install -y python3 python3-pip \
    && apt-get install -y python3.10-venv \
    && apt-get install -y libpq-dev \
    && pip3 install virtualenv

RUN python3 -m venv venv
ENV PATH="/app/venv/bin:$PATH"

RUN pip install mlflow psycopg2 boto3

COPY entrypoint.sh /app/entrypoint.sh
COPY .env /app/.env
COPY default_auth.ini /app/default_auth.ini
RUN chmod +x /app/entrypoint.sh

EXPOSE 5000

ENTRYPOINT [ "/app/entrypoint.sh" ]
