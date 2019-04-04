extends "res://items/itemBase.gd"

func _ready():
	$pullZone.connect("area_entered", self, "on_area_entered")

func on_area_entered(area):
	print("first trigger")
	if area.get_parent().get("type") == "item":
		print("trigger")
		area.get_parent().set_mode(1)
	#get_node("../" + area.get_parent().name + "/bridge.gd")