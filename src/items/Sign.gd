extends Node2D

func _ready():
	$Area2D.connect("area_entered", self, "open_menu")

func open_menu(area):
	
	print("opening menu")
