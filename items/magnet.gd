extends "res://items/itemBase.gd"

func _ready():
	$pullZone.connect("area_entered", self, "on_area_entered")

func on_area_entered(area):
	print(area)
	area.get_parent().set_physics_process(false)