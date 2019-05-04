"""
Copyright(C) 2019 You're Perfect LLC, All Rights Reserved
Licensed under the MIT license, see LICENSE file in the
project root folder for more information.
"""
extends Camera2D

const screenSize = Vector2(1920,1080)#room size (still scrolls if going left one time, unsure as to why yet)
var gridPos = Vector2.ZERO

func _ready():
	$area.connect("area_entered", self, "onAreaEntered")
	$area.connect("area_exited", self, "onAreaExited")
	get_node("area/CollisionShape2D").get_shape().set_extents(screenSize)
	#above is set up for having different screen sizes, going to attempt to figure out how to access in script later

func _process(delta):
	if has_node("../player"):
		var playerGridPos = get_grid_pos(get_node("../player").global_position)
		global_position = playerGridPos * screenSize
		gridPos = playerGridPos
		
func get_grid_pos(pos):
	var x = floor(pos.x / screenSize.x)
	var y = floor(pos.y / screenSize.y) 
	return Vector2(x,y)
	
func onAreaEntered(area):
	if area.get_parent().name == "magnet":
		for area in $area.get_overlapping_areas():
			if area.get_parent().get("type") == "item":
				area.get_parent().magOnScreen = true
		
	elif area.get_parent().get("subType") == "dragon":
		area.get_parent().chasing = true
			
func onAreaExited(area):
	if area.get_parent().name == "magnet":
		for area in $area.get_overlapping_areas():
			if area.get_parent().get("type") == "item":
				area.get_parent().magOnScreen = false
		
	elif area.get("subType") == "dragon":
		area.get_parent().chasing == false
		
func magnetPickedUp():
	for area in $area.get_overlapping_areas():
		if area.get_parent().get("type") == "item":
			area.get_parent().magOnScreen == false
			
func save():
	var save_dict = {
		"filename": get_filename(),
		"parent": get_parent().get_path(),
		"pos_x": position.x,
		"pos_y": position.y
	}
	return save_dict