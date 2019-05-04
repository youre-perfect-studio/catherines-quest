"""
Copyright(C) 2019 You're Perfect LLC, All Rights Reserved
Licensed under the MIT license, see LICENSE file in the
project root folder for more information.
"""
extends Node2D

func _ready():
	$NewGameBtn.grab_focus()
	$NewGameBtn.connect("pressed", self, "new_game")
	$ContinueBtn.connect("pressed", self, "continue_game")

func new_game():
	print("New game")
	get_tree().change_scene("res://menus/selectPlayer.tscn")
	
func continue_game():
	print("continue")
	SaveFunctions.set_continuing()
	get_tree().change_scene("res://screens/Episode1.tscn")