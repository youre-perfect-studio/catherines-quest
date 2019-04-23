extends "res://characters/Common/NPC.gd"

onready var dialog_controller_node = $"/root/Node/DialogController"
onready var charlist = CharactersList.new()

func begin_dialog( player:Player ):
	dialog_controller_node.set_speaker("Catherine")
	dialog_controller_node.set_right_portrait(charlist.characters["Catherine"].expressions["default"])
	dialog_controller_node.set_text("Go find our beloved\nQueen Roux!")
	dialog_controller_node.show_workaround()
	if player.has_seen_a_dragon:
		pass