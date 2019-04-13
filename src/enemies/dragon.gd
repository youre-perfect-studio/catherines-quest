extends "res://testStuff/entity.gd"

#plan on making hitbox more defined once actual dragon art created, along with anything else
# Vector2 Room Size (960, 540)

onready var player = get_node("../player")
onready var bitebox =  get_node("../dragon/bitebox")

var moveTimerLength
var moveTimer = 0

func _ready():
	moveTimerLength = randi() % 800 + 100
	moveTimer = moveTimerLength
	$bitebox.connect("area_entered", self, "onAreaEntered")
	
func _physics_process(delta):
	movementLoop()
	if chasing == false:
		if moveTimer > 0:
			moveTimer -= 1
			if is_on_wall():
				movedir = -movedir
		elif moveTimer == 0:
			movedir = pickDirection()
			moveTimer = moveTimerLength
			if is_on_wall():
				movedir = -movedir
	else:
		movedir = (player.global_position - bitebox.global_position).normalized()
		
func onAreaEntered(area):
	if area.get_parent().get("type") == "player":
		if area.get_parent().get("hasAmulet") == false:
			pass
			#player.set_physics_process(false)
			#player.set_visible(false)