"""
Copyright(C) 2019 You're Perfect LLC, All Rights Reserved
Licensed under the MIT license, see LICENSE file in the
project root folder for more information.
"""
extends "res://items/Item.gd"

func _ready():
	#$hitbox.connect("area_entered", self, "area_entered")
	item_name = "amulet"
#
#func area_entered(area):
#	var body = area.get_parent()
#	print(body.name)
#	if body.name == "player":
#		#print("touching player")
#		body.get_amulet()
#		queue_free()
