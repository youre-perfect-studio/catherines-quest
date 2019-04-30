extends Node2D


func _ready():
	$Area2D.connect("area_entered", self, "area_entered")
	$Area2D.connect("area_exited", self, "area_exited")
	$"../player".connect("open_menu", self, "open_menu")

func area_entered(area):
	var body = area.get_parent()
	if body.name == "player":
		body.is_close_to_sign = true
		
func area_exited(area):
	var body = area.get_parent()
	if body.name == "player":
		body.is_close_to_sign = false
	close_menu()
	

func open_menu():
		$"../UI/SaveMenu".show()
		get_tree().paused = true
		print("opening menu")
	
func close_menu():
		$"../UI/SaveMenu".close()
		get_tree().paused = false
		print("closing menu")