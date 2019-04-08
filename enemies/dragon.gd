extends "res://testStuff/entity.gd"

#plan on making hitbox more defined once actual dragon art created, along with anything else
# Vector2 Room Size (960, 540)

var movetimer_length = randi()
var movetimer = 0

func _ready():
	pass
	
	
func _physics_process(delta):
	movementLoop()
	if movetimer > 0:
		movetimer -= 1
	if movetimer == 0 || is_on_wall():
		movetimer = movetimer_length