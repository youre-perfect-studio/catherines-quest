extends KinematicBody2D

var movedir = Vector2.ZERO
export(int) var speed = 80

func movementLoop():
	var motion
	motion = movedir.normalized() * speed
	move_and_slide(motion, Vector2.ZERO)