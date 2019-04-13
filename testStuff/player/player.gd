extends "res://testStuff/entity.gd"

var state = "default"

func ready():
	pass
	
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
	
	if hasAmulet == true:
		$aura.visible = true
		$auraPlayer.play("default")
	else:
		$aura.visible = false
	
func state_default():
	controlLoop()
	movementLoop()
	spritedirLoop()
	if movedir != Vector2.ZERO:
		anim_switch("walk")
	damageLoop()

func state_swing():
	anim_switch("attack")
	movementLoop()
	movedir = Vector2.ZERO
	damageLoop()

func get_amulet():
	hasAmulet = true 
