"""
Copyright(C) 2019 You're Perfect LLC, All Rights Reserved
Licensed under the MIT license, see LICENSE file in the
project root folder for more information.
"""
extends Node2D

func _ready():
	#Globals.MusicPlayer.fade(preload("res://music/life_in_corrupted_binary_by_haeldb_cc0.ogg"),0.0,1.0)
	Globals.MusicPlayer.play(preload("res://music/life_in_corrupted_binary_by_haeldb_cc0.ogg"))

	$Anim.play("animateText")
	$Button.connect("pressed", self, "start_game")
	
func _input(event):
	if event is InputEventKey and event.pressed :
		#print("any key was pressed")
		start_game()
		


func start_game():
	get_tree().change_scene("res://menus/gameSelection.tscn")
