extends Camera2D

const screen_size = Vector2(200, 200)
var grid_pos = Vector2.ZERO

func _ready():
	$area.connect("area_entered", self, "on_area_entered")
	$area.connect("area_exited", self, "on_area_exited")

func _process(delta):
	var player_grid_pos = get_grid_pos(get_node("../player").global_position)
	global_position = player_grid_pos * screen_size
	grid_pos = player_grid_pos
	
func get_grid_pos(pos):
	var x = floor(pos.x / screen_size.x)
	var y = floor(pos.y / screen_size.y)
	return Vector2(x,y)
	
func on_area_entered(area):
	if area.get("type") == "item":
		print(area)
		area.set_physics_process(true)
			
func on_body_exited(area):
	if area.get("type") == "item":
		area.set_physics_process(false)