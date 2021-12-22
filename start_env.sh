#!/bin/sh
if [ "${BASH_SOURCE-}" = "$0" ]; then
    echo "You must source this script: \$ source $0" >&2
    exit 33
fi
source v/bin/activate
source ~/.invoke-completion.sh
