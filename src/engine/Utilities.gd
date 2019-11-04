"""
Copyright(C) 2019 You're Perfect LLC, All Rights Reserved
Licensed under the MIT license, see LICENSE file in the
project root folder for more information.
"""

"""
Utilities serves as a set of general purpose custom functions that
serves the needs of You're Perfect LLC.
"""

extends Node

static func get_node_from_root(source_node, destination_node_name):
	print("list of children for node: " + source_node.name)
	for child_node in source_node.get_children():
		if child_node.get_child_count() > 0:
			get_node_from_root(child_node, destination_node_name)
		print(child_node.name)
		if child_node.name == destination_node_name:
			return child_node
	return null

static func resize_texture(sprite_texture):
	var goal_size = 152
	var width = sprite_texture.get_size().x
	var height = sprite_texture.get_size().y
	var ratio_x = 1
	var ratio_y = 1
	
	# width is larger or equal to height of image, then set ratio to width
	if width >= height:
		ratio_x = goal_size / width
		ratio_y = goal_size / width
	# otherwise, set ratio to height of image
	else:
		ratio_x = goal_size / height
		ratio_y = goal_size / height

	return Vector2(ratio_x, ratio_y)
