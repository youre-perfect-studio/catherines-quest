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
	$Character.texture = characters[index].expressions["default"]
	$NameLbl.text = "Name: " + characters[index].character_name
	$Description.text = characters[index].backstory
	$StartBtn.disabled = not characters[index].unlocked


func start_game():
	get_tree().change_scene("res://screens/testRoom.tscn")	
