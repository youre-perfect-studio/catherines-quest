"""
Copyright(C) 2019 You're Perfect LLC, All Rights Reserved
Licensed under the MIT license, see LICENSE file in the
project root folder for more information.
"""
extends Node2D

func _ready():
	$VBoxContainer/NewGameBtn.grab_focus()
	$VBoxContainer/NewGameBtn.connect("pressed", self, "new_game")
	$VBoxContainer/ContinueBtn.connect("pressed", self, "continue_game")
	$VBoxContainer/CreditsBtn.connect("pressed", self, "roll_credits")

func new_game():
	print("New game")
	get_tree().change_scene("res://menus/select_difficulty/SelectDifficulty.tscn")

func continue_game():
	print("continue")
	SaveFunctions.set_continuing()
	get_tree().change_scene("res://screens/Episode1.tscn")
	
func roll_credits():
	get_tree().change_scene("res://menus/credits/Credits.tscn")

