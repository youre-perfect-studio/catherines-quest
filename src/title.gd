extends Node2D

func _ready():
	$Anim.play("animateText")
	
func _input(event):
	if event is InputEventKey and event.pressed:
		#print("any key was pressed")
		get_tree().change_scene("res://testStuff/testRoom.tscn")
