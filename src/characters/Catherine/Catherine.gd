extends "res://characters/Common/NPC.gd"

onready var dialog_controller_node:DialogController = $"/root/Episode1/DialogController"
onready var charlist = CharactersList.new()

func begin_dialog( player:Player ):
	dialog_controller_node.read_verbatim_text("Great job everyone!\nThis game is getting there! <3", "Catherine", 1, "default")
	dialog_controller_node.show_workaround()
	yield(dialog_controller_node.next_close,"pressed")
	dialog_controller_node.hide_workaround()
	#if player.has_seen_a_dragon:
#		pass