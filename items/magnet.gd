extends "res://items/itemBase.gd"

func _ready():
	$pullZone.connect("area_entered", self, "onAreaEntered")
	$pullZone.connect("area_exited", self, "onAreaExited")

func onAreaEntered(area):
	if area.get_parent().get("type") == "item":
		area.get_parent().inMagnet = true
		
func onAreaExited(area):
	if area.get_parent().get("type") == "item":
		area.get_parent().inMagnet = false