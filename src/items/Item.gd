"""
Copyright(C) 2019 You're Perfect LLC, All Rights Reserved
Licensed under the MIT license, see LICENSE file in the
project root folder for more information.
"""
extends RigidBody2D

var speed = 35
var item_name = ""

const type = "item"

onready var player = $"../player"

var inMagnet = false
var magOnScreen = false

var dropped = false

#use the cam bool plan to attempt to use collision detection to change mode and apply fixes, will also solve another issue

func _ready():
	pass
#	$hitbox.connect("area_exited", self, "onAreaExited")

func _physics_process(delta):
	if name != "magnet" && name != "bait" && magOnScreen == true:
		if inMagnet == false:
			var magPos = get_node("../magnet/pullZone").global_position
			var direction = get_node("../" + name + "/magnetic").global_position - magPos
#			set_mode(2)
			self.set_applied_force(-direction * speed * delta)
#		else:
#			set_mode(1)
#			print("trigger")

##
#	if dropped == true && global_position.distance_to(player.global_position) > 300:
#		dropped = false

#func _integrate_forces(state):
#	if get_mode() == 1:
#		set_mode(2)

#func setModeStatic():
#	set_mode(1)
#	print(get_mode())
#
#func setModeChara():
#	if name != "magnet" && name != "bait":
#		set_mode(2)
#		print(get_mode())
