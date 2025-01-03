#!/usr/bin/env bash

set -e

# define functions
err_report() {
    echo "ERROR: $0:$*"
    exit 8
}

trap 'err_report $LINENO' ERR

# get path
pwd="$(pwd)"

# initialize variables
[[ -f "${pwd}/.env" ]] && . "${pwd}/.env"
POSTGRES_USER=${POSTGRES_USER:-user}
POSTGRES_PASSWORD=${POSTGRES_PASSWORD:-$(random 256)}
POSTGRES_DB=${POSGRES_DB:-gocd}
PGADMIN_DEFAULT_EMAIL=${PGADMIN_DEFAULT_EMAIL}
PGADMIN_DEFAULT_PASSWORD=${PGADMIN_DEFAULT_PASSWORD:-$(random 32)}
DOMAIN_NAME=${DOMAIN_NAME}
DOMAIN_EMAIL=${DOMAIN_EMAIL}

docker compose run --rm certonly --webroot --webroot-path=/var/www/certbot -d ${DOMAIN_NAME} -d www.${DOMAIN_NAME}