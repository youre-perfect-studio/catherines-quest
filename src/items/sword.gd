"""
Copyright(C) 2019 You're Perfect LLC, All Rights Reserved
Licensed under the MIT license, see LICENSE file in the
project root folder for more information.
"""
extends Node
	
const damage = 1

var type = "item"

var max_amount = 1

func _ready():
	type = get_parent().type
	$Anim.connect("animation_finished", self, "destroy")
	$Anim.play(str("swing", get_parent().spritedir))
	if get_parent().has_method("state_swing"):
		get_parent().state = "swing"
func destroy(animation):
	if get_parent().has_method("state_swing"):
		get_parent().state = "default"
	queue_free()	
