#!/bin/bash
set +e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

GODOT_FOLDER="${DIR}/../catherine_godot/"
GODOT=${GODOT_FOLDER}godot-headless

if [ ! -f ${GODOT} ]; then
	echo "Godot not found at ${GODOT}. Run update_headless_godot.sh first!"
	exit 1
fi

PROJECT=${DIR}/src/
BUILD=${DIR}/../catherine_build/

mkdir -p ${BUILD}

# Run Tests
${GODOT} -d -s --path ${PROJECT} ${PROJECT}/addons/gut/gut_cmdln.gd -gdir=res://test -ginclude_subdirs -gexit
TEST_RESULT=$?
if [ ${TEST_RESULT} != 0 ]; then
	echo "Default test has failed, abandoning ship"
	exit ${TEST_RESULT}
fi

# Export file
${GODOT} --export "Linux" --path ${PROJECT} ${BUILD}/catherine_quest

