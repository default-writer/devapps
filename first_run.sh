#!/bin/bash

set -e

# initialize variables
[[ -f "${pwd}/.env" ]] && . "${pwd}/.env"
POSTGRES_USER=${POSTGRES_USER:-user}
POSTGRES_PASSWORD=${POSTGRES_PASSWORD:-$(random 256)}
POSTGRES_DB=${POSGRES_DB:-gocd}
PGADMIN_DEFAULT_EMAIL=${PGADMIN_DEFAULT_EMAIL}
PGADMIN_DEFAULT_PASSWORD=${PGADMIN_DEFAULT_PASSWORD:-$(random 32)}
DOMAIN_NAME=${DOMAIN_NAME}
DOMAIN_EMAIL=${DOMAIN_EMAIL}

docker-compose run --rm certonly --webroot --webroot-path=/var/www/certbot -d ${DOMAIN_NAME} -d www.${DOMAIN_NAME}