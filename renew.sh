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

# main loop
./install.sh --stop
./install.sh --environment
./install.sh --certbot
./install.sh --start

