extends "res://items/itemBase.gd"

func _ready():
	$hitbox.connect("area_entered", self, "area_entered")
	
func area_entered(area):
	var body = area.get_parent()
	print(body.name)
	if body.name == "player":
		print("touching player")
		body.get_amulet()
		queue_free()