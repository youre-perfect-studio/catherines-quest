extends "res://engine/entity.gd"

onready var player = get_node("../player/followerSpace")
export(bool) var follow_player = true

func _ready():
	pass
	
	
func _physics_process(delta):
	if not follow_player:
		return
	if global_position.distance_to(player.get_parent().global_position) > 150:
		movementLoop()
		spritedirLoop()
	movedir = (player.global_position - global_position).normalized()