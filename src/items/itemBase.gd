"""
Copyright(C) 2019 You're Perfect LLC, All Rights Reserved
Licensed under the MIT license, see LICENSE file in the
project root folder for more information.
"""
extends RigidBody2D

var speed = 35

const type = "item"

onready var player = $"../player"

var inMagnet = false
var magOnScreen = false

var dropped = false

func _ready():
	pass
#	$hitbox.connect("area_exited", self, "onAreaExited")

func _physics_process(delta):
	if name != "magnet" && name != "bait" && magOnScreen == true:
		if inMagnet == false:
			var magPos = get_node("../magnet/pullZone").global_position
			var direction = get_node("../" + name + "/magnetic").global_position - magPos
			set_mode(2)
			self.set_applied_force(-direction * speed * delta)

		else:
			self.set_applied_force(Vector2.ZERO)
			set_mode(1)
			
	else:
		set_mode(1)
		
	if dropped == true && global_position.distance_to(player.global_position) > 300:
		dropped = false
#func onAreaExited(area):
#	if area.get_parent().name != "cam" && area.get_parent().type == "player":
#		self.dropped = false