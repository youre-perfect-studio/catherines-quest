extends "res://characters/Common/NPC.gd"

const resource_file = "res://characters/Catherine.tres"
onready var dialog_controller_node = $"/root/Node/DialogController"

func begin_dialog( player:Player ):
	dialog_controller_node.show_workaround()
	if player.has_seen_a_dragon:
		pass