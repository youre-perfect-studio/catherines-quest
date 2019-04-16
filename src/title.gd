extends Node2D

func _ready():
	$Anim.play("animateText")
	
	#example of getting the playable characters info
	#see characters/character.gd
	var charlist = CharactersList.new()
	var playable = charlist.get_playable_characters()
	for idx in playable:
		print(playable[idx].character_name)
	
func _input(event):
	if event is InputEventKey and event.pressed:
		#print("any key was pressed")
		get_tree().change_scene("res://menus/gameSelection.tscn")
