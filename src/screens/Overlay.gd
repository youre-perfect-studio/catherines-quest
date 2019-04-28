extends Node2D
##This script is referenced by overlay.tscn and 
# all inherited scenes that will function as overlay for
# areas that the player needs to pass through that needs visibility
func _ready():
	$Area.connect("area_entered",self, "area_entered")
	$Area.connect("area_exited", self, "area_exited")
	
func area_entered(area):
	if area.get_parent().name == "player":
		$Anim.play("fadeOut")
		#$Tween.interpolate_property($Sprite, "modulate", 
	    #  Color(1, 1, 1, 1), Color(1, 1, 1, 0), 2.0, 
	    #  Tween.TRANS_LINEAR, Tween.EASE_IN)
func area_exited(area):
	if area.get_parent().name == "player":
		$Anim.play("fadeIn")
