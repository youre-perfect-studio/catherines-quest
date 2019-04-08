extends "res://items/itemBase.gd"

func _ready():
	$pullZone.connect("area_entered", self, "onAreaEntered")

func onAreaEntered(area):
	if area.get_parent().get("type") == "item":
		area.get_parent().inMagnet = true