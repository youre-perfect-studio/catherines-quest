extends Node

func _ready():
	TranslationServer.set_locale("en_US")
	call_deferred("spawn_players")

func spawn_players():
	#assert(Globals.Players.size()>0)
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