#!/usr/bin/env bash
if [[ "${BASHOPTS}" != *extdebug* ]]; then
    set -e
fi

# define functions
err_report() {
    echo "ERROR: $0:$*"
    exit 8
}

function help() {
    local source=$0
    local script="$(basename "$(test -L "${source}" && readlink "${source}" || echo "${source}")")"
    local commands=$(cat ${source} | sed -e 's/^[ \t]*//;' | sed -e '/^[ \t]*$/d' | sed -n -e 's/^"\(.*\)".*#/    \1:/p' | sed -n -e 's/: /:\n        /p')
    echo "$(cat ${source} | sed -e 's/^[ \t]*//;' | sed -e '/^[ \t]*$/d' | sed -n -e 's/^## \(.*\).*/\1/p' | script=""${script}"" commands=""${commands}"" envsubst)"
    exit 8
}

function random() {
    local set="abcdefghijklmonpqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local rand=$(cat /dev/urandom | LC_ALL=C tr -dc 'a-zA-Z0-9' | fold -w "$1" | head -n 1)
    echo $rand
}

# set error handler
if [[ "${BASHOPTS}" != *extdebug* ]]; then
    trap 'err_report $LINENO' ERR
fi

# get path
pwd="$(pwd)"

## Create directories and files
## Usage: ${script} <option>
## ${commands}
command=""

while (($#)); do
    case "$1" in
        "--install") # installs firezone
            bash <(curl -fsSL https://github.com/firezone/firezone/raw/legacy/scripts/install.sh)
            ;;
        "--help") # [optional] shows command description
            help
            ;;
        *)
            help
            ;;
    esac
    shift
done

if [[ "${command}"=="" ]]; then
    help
fi

[[ $SHLVL -gt 2 ]] || echo OK

cd "${pwd}"

