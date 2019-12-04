#!/bin/bash
set +e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

GODOT_FOLDER="${DIR}/../catherine_godot/"
GODOT=${GODOT_FOLDER}godot-headless
GODOT_ZIP=${GODOT_FOLDER}godot-linux-headless-nightly-x86_64.tar.xz
GODOT_TEMPLATES=${GODOT_FOLDER}godot-templates.tpz

GODOT_URL=https://archive.hugo.pro/builds/godot/master/server/godot-linux-headless-nightly-x86_64.tar.xz
GODOT_TEMPLATES_URL=https://archive.hugo.pro/builds/godot/master/templates/godot-templates-android-html5-linux-windows-nightly.tpz

mkdir -p ${GODOT_FOLDER}

curl ${GODOT_URL} --output ${GODOT_ZIP}
tar -xovf ${GODOT_ZIP} --directory ${GODOT_FOLDER}
chmod +x ${GODOT}

curl ${GODOT_TEMPLATES_URL} --output ${GODOT_TEMPLATES}
GODOT_TEMPLATES_INSTALL=~/.local/share/godot/templates/
mkdir -p ${GODOT_TEMPLATES_INSTALL}
unzip -o -q ${GODOT_TEMPLATES} -d ${GODOT_TEMPLATES_INSTALL}

GODOT_VERSION=$(cat ${GODOT_TEMPLATES_INSTALL}/templates/version.txt)
GODOT_TEMPLATE_DIR=${GODOT_TEMPLATES_INSTALL}${GODOT_VERSION}
rm -rf ${GODOT_TEMPLATE_DIR}
mv ${GODOT_TEMPLATES_INSTALL}/templates ${GODOT_TEMPLATE_DIR}

