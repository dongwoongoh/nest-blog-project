#!/bin/zsh

echo "Enter database name:"
read DB_NAME

echo "Enter database user name:"
read DB_USER

echo "Enter database user password:"
read DB_PASS

INIT_SQL="/tmp/init.sql"

if [ ! -f "$INIT_SQL" ]; then
    echo "Creating init.sql..."
    echo "CREATE DATABASE $DB_NAME;" >$INIT_SQL
    echo "GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_USER;" >>$INIT_SQL
else
    echo "init.sql already exists."
fi

if [[ "$(docker images -q postgres 2>/dev/null)" == "" ]]; then
    echo "Postgres image not found. Pulling from Docker Hub..."
    docker pull postgres:14.10-alpine3.18
else
    echo "Postgres image found."
fi

docker run -d \
    -e POSTGRES_USER=$DB_USER \
    -e POSTGRES_PASSWORD=$DB_PASS \
    -v $INIT_SQL:/docker-entrypoint-initdb.d/init.sql \
    --name $DB_NAME \
    postgres:14.10-alpine3.18
