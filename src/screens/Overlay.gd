extends Sprite
##This script is referenced by overlay.tscn and 
# all inherited scenes that will function as overlay for
# areas that the player needs to pass through that needs visibility
func _ready():
	$Area.connect("area_entered",self, "area_entered")
	$Area.connect("area_exited", self, "area_exited")
	
func area_entered(area):
	if area.get_parent().name == "player":
		modulate.a = 0.5
func area_exited(area):
	if area.get_parent().name == "player":
		modulate.a = 1
