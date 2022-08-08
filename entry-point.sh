#!/bin/bash
echo "(entry-point.sh) updating app settings"

# variables
REQUIRED_ENV_VARS=("POSTGRES_NAME" "POSTGRES_USER" "POSTGRES_PASSWORD" "POSTGRES_HOST" "POSTGRES_PORT")
PG_SERVICE_CONF=~/.pg_service.conf
PG_PASS=~/.todo_app

# -- main script
for var in ${REQUIRED_ENV_VARS}; do
    if [[ -z "$(eval "echo \$$var")" ]]; then
        echo "(entry-point.sh) required env var: ${var} is not defined. exiting."
        exit 1
    fi
done

echo "(entry-point.sh) generating ${PG_SERVICE_CONF}"
cat <<EOF >>${PG_SERVICE_CONF}
[todo_app]
host=${POSTGRES_HOST}
user=${POSTGRES_USER}
dbname=${POSTGRES_NAME}
port=${POSTGRES_PORT}
EOF

echo "(entry-point.sh) generating ${PG_PASS}"
cat <<EOF >>${PG_PASS}
${POSTGRES_HOST}:${POSTGRES_PORT}:${POSTGRES_NAME}:${POSTGRES_USER}:${POSTGRES_PASSWORD}
EOF

echo "(entry-point.sh) setting file permissions: ${PG_PASS}"
chmod 600 ${PG_PASS}

echo "(entry-point.sh) waiting for db container"
./wait-for-it.sh -h ${POSTGRES_HOST} -p ${POSTGRES_PORT} -t 60

echo "(entry-point.sh) checking for .venv directory"
if [ ! -d .venv ]
then
    echo "(entry-point.sh) .venv directory does not exists. installing dependencies"
    pipenv install --deploy --dev
fi

echo "(entry-point.sh) starting web server"
pipenv run python manage.py runserver 0.0.0.0:8000