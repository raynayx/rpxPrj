#!/bin/sh

PURPLE='\033[0;35m'
NC='\033[0m' # No Color

if [ "${BASH_SOURCE-}" = "$0" ]; then
    echo -e "You must source this script:${PURPLE} \$ source $0${NC}" >&2
    exit 33
fi

if [ -d "src" ] && [ -d "lib" ]
then
    echo -e "Directory setup already. \
    Run ${PURPLE}conda activate env_name${NC} \
    to enable using ${PURPLE}invoke${NC}\
    OR You can use ${PURPLE}Invoke${NC} if it already exists in the 
    system path"
    return 0
else
    echo -e "${PURPLE}Creating src,build,test,docs and lib directories ${NC}"
    mkdir src/ build/ test/ lib docs/
    echo -e "${PURPLE}Creating initial files. ${NC}"
    touch src/main.c
    echo -e "${PURPLE}Initializing git repo. ${NC}"
    git init .
fi
