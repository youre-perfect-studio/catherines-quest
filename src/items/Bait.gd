"""
Copyright(C) 2019 You're Perfect LLC, All Rights Reserved
Licensed under the MIT license, see LICENSE file in the
project root folder for more information.
"""
extends "res://items/Item.gd"

var beingEaten = false
var dragon

#onready var dragon = get_node("../dragon")

func _ready():
	item_name = "bait"
	$dragonAttract.connect("area_entered", self, "onAttractEntered")
	$dragonAttract.connect("area_exited", self, "onAttractExited")
	$hitbox.connect("area_entered", self, "onHitboxEntered")
	$Timer.connect("timeout", self, "baitEaten")
	
	
func onAttractEntered(area):
	if area.get_parent().get("subType") == "dragon":
		area.get_parent().baitChase = true
		
func onAttractExited(area):
		if area.get_parent().get("subType") == "dragon":
			area.get_parent().baitChase = false

func onHitboxEntered(area):
	if area.name == "bitebox":
		dragon = area.get_parent()
		dragon.eating = true
		$Timer.start(4)

func baitEaten():
	if dragon != null:
		dragon.eating = false
		dragon.baitChase = false
		queue_free()
