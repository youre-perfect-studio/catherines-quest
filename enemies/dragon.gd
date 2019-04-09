extends "res://testStuff/entity.gd"

#plan on making hitbox more defined once actual dragon art created, along with anything else
# Vector2 Room Size (960, 540)

var moveTimerLength
var moveTimer = 0

func _ready():
	moveTimerLength = randi() % 100 + 100
	moveTimer = moveTimerLength
	
func _physics_process(delta):
	movementLoop()
	if moveTimer > 0:
		moveTimer -= 1
		if is_on_wall():
			movedir = -movedir
	elif moveTimer == 0:
		movedir = pickDirection()
		moveTimer = moveTimerLength
		if is_on_wall():
			movedir = -movedir