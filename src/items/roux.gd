extends "res://items/Item.gd"

#onready var player = $"../player/followerSpace"
#export(bool) var follow_player = false

func _ready():
	pass
	
	
func _physics_process(delta):
	pass
#	if not follow_player:
#		return
#	if global_position.distance_to(player.get_parent().global_position) > 150:
#		movementLoop()
#		spritedirLoop()
#	movedir = (player.global_position - global_position).normalized()
