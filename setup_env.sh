#!/bin/sh

PURPLE='\033[0;35m'
NC='\033[0m' # No Color

if [ "${BASH_SOURCE-}" = "$0" ]; then
    echo -e "You must source this script:${PURPLE} \$ source $0${NC}" >&2
    exit 33
fi

if [ -d "v" ]
then
    echo -e "Directory setup already. Run ${PURPLE}source start_env.sh${NC}"
    return 0
fi

echo -e "${PURPLE}Setting up Virtual Env${NC}"
virtualenv v
echo -e "${PURPLE}Attempting activating venv${NC}"
source v/bin/activate

echo -e "${PURPLE}Attempting Invoke installation${NC}"
pip install invoke

echo -e "${PURPLE}Checking if invoke installation was successful${NC}"
invoke -V

if [ -d "src" ]
then
    return 0
else
    echo -e "${PURPLE}Creating src,build,test,docs and lib directories ${NC}"
    mkdir src/ build/ test/ lib docs/
    echo -e "${PURPLE}Creating initial files. ${NC}"
    touch src/main.c
    echo -e "${PURPLE}Initializing git repo. ${NC}"
    git init .
fi
