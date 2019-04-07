extends Camera2D

const screen_size = Vector2(200, 200)
var grid_pos = Vector2.ZERO

func _ready():
	$area.connect("area_entered", self, "onAreaEntered")
	$area.connect("area_exited", self, "onAreaExited")

func _process(delta):
	var player_grid_pos = get_grid_pos(get_node("../player").global_position)
	global_position = player_grid_pos * screen_size
	grid_pos = player_grid_pos
	
func get_grid_pos(pos):
	var x = floor(pos.x / screen_size.x)
	var y = floor(pos.y / screen_size.y)
	return Vector2(x,y)
	
func onAreaEntered(area):
	if area.get_parent().get("type") == "item":
		print(name)
		area.get_parent().set_physics_process(true)
			
func onAreaExited(area):
	print("test disable")
	if area.get("type") == "item":
		area.get_parent().set_physics_process(false)