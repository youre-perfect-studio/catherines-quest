extends Node

func _ready():
	TranslationServer.set_locale("en_US")
	call_deferred("spawn_players")
	load_game()

func spawn_players():
	#This should only happe when running single-scene debugging
	if Globals.Players.size() == 0:
		Globals.Players.append(CharactersList.new().characters["Robin"].character_scene.instance())
	#TODO when character selection works
	#for player in Globals.Players:
	#	$"/root/Episode1".add_child(player)
	$player.show_opening_dialog()
	
func save():
	var save_dict = {
		"filename": get_filename(),
		"parent": get_parent(),
	}
	return save_dict
	
func dropItem(item):
	var newItem = item.instance()
	add_child(newItem)