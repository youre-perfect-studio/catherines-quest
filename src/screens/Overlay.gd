"""
Copyright(C) 2019 You're Perfect LLC, All Rights Reserved
Licensed under the MIT license, see LICENSE file in the
project root folder for more information.
"""
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
func area_exited(area):
	if area.get_parent().name == "player":
		$Anim.play("fadeIn")
