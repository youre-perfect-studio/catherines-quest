"""
Copyright(C) 2019 You're Perfect LLC, All Rights Reserved
Licensed under the MIT license, see LICENSE file in the
project root folder for more information.
"""
extends "res://engine/Entity.gd"

onready var player = $"../player/followerSpace"
export(bool) var follow_player = false

func _ready():
	pass
	
	
func _physics_process(delta):
	if not follow_player:
		return
	if global_position.distance_to(player.get_parent().global_position) > 150:
		movementLoop()
		spritedirLoop()
	movedir = (player.global_position - global_position).normalized()
