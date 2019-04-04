extends KinematicBody2D

var movedir = Vector2.ZERO
var speed = 80

#warning-ignore:unused_argument
func _process(delta):
	controlLoop()
	movementLoop()
	
func controlLoop():
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	var up = Input.is_action_pressed("ui_up")
	var down = Input.is_action_pressed("ui_down")
	
	movedir.x = -int(left) + int(right)
	movedir.y = -int(up) + int(down)
	
func movementLoop():
	var motion
	motion = movedir.normalized() * speed
	move_and_slide(motion, Vector2.ZERO)