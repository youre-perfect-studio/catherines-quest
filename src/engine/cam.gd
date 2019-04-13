extends Camera2D

const screenSize = Vector2(1920,1080)#room size (still scrolls if going left one time, unsure as to why yet)
var gridPos = Vector2.ZERO

func _ready():
	$area.connect("area_entered", self, "onAreaEntered")
	$area.connect("area_exited", self, "onAreaExited")
	get_node("area/CollisionShape2D").get_shape().set_extents(screenSize)
	#above is set up for having different screen sizes, going to attempt to figure out how to access in script later

func _process(delta):
	var playerGridPos = get_grid_pos(get_node("../player").global_position)
	global_position = playerGridPos * screenSize
	gridPos = playerGridPos
	print(global_position)
	
func get_grid_pos(pos):
	var x = floor(pos.x / screenSize.x)
	var y = floor(pos.y / screenSize.y) 
	return Vector2(x,y)
	
func onAreaEntered(area):
	if area.get_parent().get("type") == "item":
		area.get_parent().set_physics_process(true)
		
	elif area.get_parent().get("subType") == "dragon":
		area.get_parent().chasing = true
			
func onAreaExited(area):
	if area.get("type") == "item":
		area.get_parent().set_physics_process(false)
		
	elif area.get("subType") == "dragon":
		area.get_parent().chasing == false