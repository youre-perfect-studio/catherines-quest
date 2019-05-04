"""
Copyright(C) 2019 You're Perfect LLC, All Rights Reserved
Licensed under the MIT license, see LICENSE file in the
project root folder for more information.
"""
extends RigidBody2D

var speed = 35

const type = "item"

var inMagnet = false

var magOnScreen = false

func _physics_process(delta):
	rotation_degrees = 0
	if name != "magnet" && name != "bait" && magOnScreen == true:
		if inMagnet == false:
			var magPos = get_node("../magnet/pullZone").global_position
			var direction = get_node("../" + name + "/magnetic").global_position - magPos
			set_mode(0)
			self.set_applied_force(-direction * speed * delta)
			if sleeping == true:
				set_sleeping(false)

		else:
			self.set_applied_force(Vector2.ZERO)
			set_mode(1)
			
	else:
		set_mode(1)
		