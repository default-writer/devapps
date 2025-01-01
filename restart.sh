#!/usr/bin/env bash
if [[ "${BASHOPTS}" != *extdebug* ]]; then
    set -e
fi

# define functions
err_report() {
    echo "ERROR: $0:$*"
    exit 8
}

# set error handler
if [[ "${BASHOPTS}" != *extdebug* ]]; then
    trap 'err_report $LINENO' ERR
fi

function random() {
    local set="abcdefghijklmonpqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local rand=$(cat /dev/urandom | LC_ALL=C tr -dc 'a-zA-Z0-9' | fold -w "$1" | head -n 1)
    echo $rand
}

# initialize variables
[[ -f "${pwd}/.env" ]] && . "${pwd}/.env"
POSTGRES_USER=${POSTGRES_USER:-user}
POSTGRES_PASSWORD=${POSTGRES_PASSWORD:-$(random 256)}
POSTGRES_DB=${POSGRES_DB:-gocd}
PGADMIN_DEFAULT_EMAIL=${PGADMIN_DEFAULT_EMAIL}
PGADMIN_DEFAULT_PASSWORD=${PGADMIN_DEFAULT_PASSWORD:-$(random 32)}
DOMAIN_NAME=${DOMAIN_NAME}
DOMAIN_EMAIL=${DOMAIN_EMAIL}

# main loop
./install.sh --stop
./install.sh --cleanup
./install.sh --environment
./install.sh --restore
./install.sh
./install.sh --start

