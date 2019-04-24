GODOT_VERSION=3.1
GODOT_BIN=Godot_v${GODOT_VERSION}-stable_linux_headless.64
GODOT_ZIP=${GODOT_BIN}.zip
GODOT_URL=https://downloads.tuxfamily.org/godotengine/${GODOT_VERSION}/${GODOT_ZIP}
GODOT_TEMPLATES=https://downloads.tuxfamily.org/godotengine/${GODOT_VERSION}/Godot_v${GODOT_VERSION}-stable_export_templates.tpz

GAME_NAME="CatherinesQuest"

curl ${GODOT_URL} --output ${GODOT_ZIP}
unzip ${GODOT_ZIP}
chmod +x ${GODOT_BIN}
./${GODOT_BIN} -d -s --path ./src addons/gut/gut_cmdln.gd -gdir=res://test -ginclude_subdirs -gexit

curl ${GODOT_TEMPLATES} --output Godot_v${GODOT_VERSION}-stable_export_templates.tpz
mkdir -p ~/.godot/templates
unzip -q -d ~/.godot/templates Godot_v${GODOT_VERSION}-stable_export_templates.tpz
mv ~/.godot/templates/templates ~/.godot/templates/3.1.stable

XDG_CACHE_HOMR=/tmp/cache
XDG_DATA_HOME=/tmp/data
XDG_CONFIG_HOME=/tmp/config
mkdir -p /tmp/cache
mkdir -p /tmp/data
mkdir -p /tmp/config

OUTPUT_FILENAME=index.html

mkdir build
./${GODOT_BIN} --export "Linux" --path ./src ~/output_file
