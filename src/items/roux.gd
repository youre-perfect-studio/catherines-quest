extends "res://items/Item.gd"

#onready var player = $"../player/followerSpace"
#export(bool) var follow_player = false

onready var dialog_controller_node:DialogController = $"../DialogController"
export(bool) var follow_player = false

func _ready():
	pass
	
func begin_dialog( player:Player ):	
	print("TODO!!: Roux dialogue")

