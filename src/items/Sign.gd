extends Node2D


func _ready():
	$Area2D.connect("area_entered", self, "open_menu")
	$Area2D.connect("area_exited", self, "close_menu")
	

func open_menu(area):
	if area.get_parent().name == "player":
		$"../UI/SaveMenu".popup()
		print("opening menu")
	
func close_menu(area):
	if area.get_parent().name == "player":
		$"../UI/SaveMenu".close()