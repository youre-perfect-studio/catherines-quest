extends KinematicBody2D

export(String) var type = "enemy"
export(String) var subType

var movedir = Vector2.ZERO

var chasing = false

export(int) var speed = 80

func movementLoop():
	var motion
	motion = movedir.normalized() * speed
	move_and_slide(motion, Vector2.ZERO)

func pickDirection():
	var direction = randi() % 3
	var x = round(rand_range(-1, 1))
	var y = round(rand_range(-1, 1))
	
	match direction:
		0:
			return Vector2(0, y)
		1:
			return Vector2(x, 0)
		2:
			return Vector2(x, y)