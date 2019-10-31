GODOT_VERSION=nightly
GODOT_BIN=Godot_${GODOT_VERSION}_linux_headless.64
GODOT_ZIP=${GODOT_BIN}.zip
#GODOT_URL=https://downloads.tuxfamily.org/godotengine/${GODOT_VERSION}/${GODOT_ZIP}
GODOT_URL=https://archive.hugo.pro/builds/godot/master/server/godot-linux-headless-nightly-x86_64.tar.xz
#GODOT_TEMPLATES=https://downloads.tuxfamily.org/godotengine/${GODOT_VERSION}/Godot_v${GODOT_VERSION}-stable_export_templates.tpz
GODOT_TEMPLATES=https://archive.hugo.pro/builds/godot/master/templates/godot-templates-android-html5-linux-windows-nightly.tpz
GODOT_MAC_TEMPLATES=https://archive.hugo.pro/builds/godot/master/templates/godot-templates-ios-macos-nightly.tpz

GAME_NAME="CatherinesQuest"

curl ${GODOT_URL} --output ${GODOT_ZIP}
unzip ${GODOT_ZIP}
chmod +x ${GODOT_BIN}
./${GODOT_BIN} -d -s --path ./src addons/gut/gut_cmdln.gd -gdir=res://test -ginclude_subdirs -gexit

curl ${GODOT_TEMPLATES} --output Godot_v${GODOT_VERSION}_export_templates.tpz
mkdir -p ~/.godot/templates
unzip -q -d ~/.godot/templates Godot_v${GODOT_VERSION}_export_templates.tpz
mv ~/.godot/templates/templates ~/.godot/templates/nightly

curl ${GODOT_MAC_TEMPLATES} --output Godot_v${GODOT_VERSION}_mac_export_templates.tpz
mkdir -p ~/.godot/mactemplates
unzip -q -d ~/.godot/mactemplates Godot_v${GODOT_VERSION}_mac_export_templates.tpz
mv ~/.godot/templates/mactemplates ~/.godot/templates/nightly


XDG_CACHE_HOMR=/tmp/cache
XDG_DATA_HOME=/tmp/data
XDG_CONFIG_HOME=/tmp/config
mkdir -p /tmp/cache
mkdir -p /tmp/data
mkdir -p /tmp/config

OUTPUT_FILENAME=index.html

mkdir build
./${GODOT_BIN} --export "Linux" --path ./src ~/output_file
