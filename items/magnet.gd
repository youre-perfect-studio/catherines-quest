extends "res://items/itemBase.gd"

onready var cam = get_node("../cam")

func _ready():
	$anim.play("open")
	
func _process(delta):
	if cam.grid_pos == cam.get_grid_pos(global_position):
		if cam.get_items() > 0:
			for item in $cam.items:
				pass #using add_force?