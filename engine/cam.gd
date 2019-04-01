extends Camera2D

const screen_size = Vector2(160, 128)
var grid_pos = Vector2.ZERO

func _ready():
	$area.connect("body_entered", self, "on_body_entered")
	$area.connect("body_exited", self, "on_body_exited")

func _process(delta):
	var player_grid_pos = get_grid_pos(get_node("../player").global_position)
	global_position = player_grid_pos * screen_size
	grid_pos = player_grid_pos
	
func get_grid_pos(pos):
	var x = floor(pos.x / screen_size.x)
	var y = floor(pos.y / screen_size.y)
	return Vector2(x,y)
	
func get_items():
	var items = []
	for body in $area.get_overlapping_bodies():
		if body.get("type") == "item" && items.find(body) == -1:
			items.append(body)
	return items.size()
	
func on_body_entered(body):
	if body.get("type") == "item":
		body.set_physics_process(true)
		
func on_body_exited(body):
	if body.get("type") == "item":
		body.set_physics_process(false)