extends Area2D

func _ready():
	connect("area_entered", self, "onAreaEntered")
	connect("area_exited", self, "onAreaExited")
	
func onAreaEntered(area):
	if area.name == "player":
		print("enter")
		area.get_parent().set_collision_mask_bit(0, 0)
		
func onAreaExited(area):
	if area.name == "player":
		print("exit")
		area.get_parent().set_collision_mask_bit(0, 1)