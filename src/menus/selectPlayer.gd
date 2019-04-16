extends Node2D
var characters = []
var characters_file_path = "res://Characters/characters.json"
var index = 0
#var char_name = null
#var char_texture_large = null
#var char_texture_icon = null
#var char_description = null
#var char_pronoun = null
#var char_playable = null

func _ready():
	$Previous.connect("pressed", self, "previous_character")
	$Next.connect("pressed", self, "next_character")
	$StartBtn.connect("pressed", self, "start_game")
	var json_file = File.new()
	if not json_file.file_exists(characters_file_path):
		return
		
	json_file.open(characters_file_path, File.READ)
	characters = JSON.parse(json_file.get_as_text()).result
	
	#print(characters)
	load_character()
	

func previous_character():
	index -= 1 
	print(index)
	load_character()
	

func next_character():
	index +=1
	print(index)
	load_character()
	

func load_character():	
	$Character.texture = load(characters[index].get("texture_large"))
	$NameLbl.text = "Name: " + characters[index].get("name")
	$Description.text = characters[index].get("description")
	
func start_game():
	get_tree().change_scene("res://screens/testRoom.tscn")	
