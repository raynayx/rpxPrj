#!/bin/sh

PURPLE='\033[0;35m'
NC='\033[0m' # No Color

if [ "${BASH_SOURCE-}" = "$0" ]; then
    echo -e "You must source this script:${PURPLE} \$ source $0${NC}" >&2
    exit 33
fi

DIR_NAME=$1
DIR_LOC=$(pwd)
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [ $# = 0 ]; then
    echo -e "${PURPLE}You must supply the name of the directory to be created:${NC}" >&2
else

    echo -e "${PURPLE}Creating project directory: ${DIR_NAME}.${NC}"
    mkdir ${DIR_NAME}/ 
fi    

if [ -d "${DIR_NAME}" ]
then
	cd ${SCRIPT_DIR}/
	echo -e "${PURPLE}Copying resources into: ${DIR_LOC}/${DIR_NAME}.${NC}"

	cp flash.jlink ${DIR_LOC}/${DIR_NAME}/
	cp pico_sdk_import.cmake ${DIR_LOC}/${DIR_NAME}/
	cp setup_env.sh ${DIR_LOC}/${DIR_NAME}/
	cp start_env.sh ${DIR_LOC}/${DIR_NAME}/
	cp tasks.py ${DIR_LOC}/${DIR_NAME}/
	cp CMakeLists.txt ${DIR_LOC}/${DIR_NAME}/
	cp -r .vscode ${DIR_LOC}/${DIR_NAME}/
	cd ${DIR_LOC}/
else
    echo -e "${PURPLE}Project directory: ${DIR_NAME} not found. Exitting...${NC}"
    return 0
fi    
