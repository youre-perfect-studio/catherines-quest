extends "res://testStuff/entity.gd"

var state = "default"

func _physics_process(delta):
	match state:
		"default":
			state_default()
		"swing":
			state_swing()
	
func controlLoop():
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	var up = Input.is_action_pressed("ui_up")
	var down = Input.is_action_pressed("ui_down")
	
	movedir.x = -int(left) + int(right)
	movedir.y = -int(up) + int(down)
	
func state_default():
	controlLoop()
	movementLoop()
	spritedirLoop()
	if movedir != Vector2.ZERO:
		anim_switch("walk")

func state_swing():
	anim_switch("attack")
	movementLoop()
	movedir = Vector2.ZERO
	damageLoop()
	 
