#Inspired by https://github.com/GDquest/godot-open-rpg/blob/master/godot/dialogue/DialogueDatabase.gd
extends Object

const CHARACTERS_DIRECTORY = "res://characters"
var characters : Dictionary

func _init():
	var dir = Directory.new()
	assert dir.dir_exists(CHARACTERS_DIRECTORY)
	if dir.open(CHARACTERS_DIRECTORY) != OK:
		print("Could not open %s" % CHARACTERS_DIRECTORY)
	dir.list_dir_begin()
	var file_name : String
	while true: 	#Godot doesn't have do-while
		file_name = dir.get_next()
		if file_name == "":
			break
		elif not file_name.ends_with(".tres"):
			continue
		characters[file_name.get_basename()] = load(CHARACTERS_DIRECTORY.plus_file(file_name))

func get_portrait(character_name:String, expression:String = "default") -> Texture:
	assert(character_name in characters)
	assert(expression in characters[character_name].expressions)
	return characters[character_name].expressions[expression]

func get_playable_characters() -> Dictionary:
	var out : Dictionary
	for index in characters:
		if characters[index].playable_character:
			out[index] = characters[index]
	return out