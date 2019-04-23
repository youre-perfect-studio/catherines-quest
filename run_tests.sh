GODOT_VERSION=3.1.1
GODOT_BIN=Godot_v${GODOT_VERSION}-rc1_linux_headless.64
GODOT_ZIP=${GODOT_BIN}.zip
GODOT_URL=https://downloads.tuxfamily.org/godotengine/${GODOT_VERSION}/rc1/${GODOT_ZIP}

curl ${GODOT_URL} --output ${GODOT_ZIP}
unzip ${GODOT_ZIP}
chmod +x ${GODOT_BIN}
./${GODOT_BIN} -d -s --path ./src addons/gut/gut_cmdln.gd -gdir=res://test -ginclude_subdirs -gexit