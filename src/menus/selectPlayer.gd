extends Node2D

onready var characters = CharactersList.new().get_playable_characters()

var index = 0

func _ready():
	assert(characters.size() > 0)
	$Previous.connect("pressed", self, "previous_character")
	$Next.connect("pressed", self, "next_character")
	$StartBtn.connect("pressed", self, "start_game")
	load_character()


func previous_character():
	index -= 1 
	if index < 0:
		index = characters.size()-1
	load_character()


func next_character():
	index +=1
	if index >= characters.size():
		index = 0
	load_character()


func load_character():
	var character:Character = characters[index]
	
	$Character.texture = character.expressions["default"]
	$NameLbl.text = "Name: " + character.character_name
	$Description.text = character.backstory	
	#TODO decide if we want these extra UI elements
	#TODO UI element - $Pronouns.text = character.pronouns
	#TODO UI element - $Symbol.texture = character.symbol	
	$StartBtn.disabled = not characters[index].unlocked


func start_game():
	print("starting game")
	Globals.Players.append(characters[index])
	get_tree().change_scene("res://screens/Episode1.tscn")
	#TODO spawn the player character by instancing characters[index].character_scene
	#after the user selects, instead of pre-spawning player.tscn