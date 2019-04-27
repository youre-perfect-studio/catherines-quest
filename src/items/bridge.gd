extends "res://items/itemBase.gd"

func _ready():
	$walkway.connect("area_entered", self, "onAreaEntered")
	$walkway.connect("area_exited", self, "onAreaExited")
	print(type)

func onAreaEntered(area):
	if area.name == "player":
		area.get_parent().set_collision_mask_bit(0,0)

func onAreaExited(area):
	if area.name == "player":
		area.get_parent().set_collision_mask_bit(0,1)