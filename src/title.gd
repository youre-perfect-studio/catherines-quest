extends Node2D

func _ready():
	$Anim.play("animateText")
	$Button.connect("pressed", self, "start_game")
	
func _input(event):
	if event is InputEventKey and event.pressed :
		#print("any key was pressed")
		start_game()
		


func start_game():
	get_tree().change_scene("res://menus/gameSelection.tscn")