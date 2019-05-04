"""
Copyright(C) 2019 You're Perfect LLC, All Rights Reserved
Licensed under the MIT license, see LICENSE file in the
project root folder for more information.
"""
extends "res://items/itemBase.gd"

func _ready():
	$pullZone.connect("area_entered", self, "onAreaEntered")
	$pullZone.connect("area_exited", self, "onAreaExited")

func onAreaEntered(area):
	if area.get_parent().get("type") == "item":
		area.get_parent().inMagnet = true
		
func onAreaExited(area):
	if area.get_parent().get("type") == "item":
		area.get_parent().inMagnet = false