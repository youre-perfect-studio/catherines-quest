extends KinematicBody2D

export(String) var type = "enemy"

var movedir = Vector2.ZERO
export(int) var speed = 80

func movementLoop():
	var motion
	motion = movedir.normalized() * speed
	if name == "bat":
		move_and_slide(motion, Vector2.ZERO)
	elif name == "dragon":
		pass

func pickDirection():
	var distance = randi() % 4
	var x = rand_range(-500, 500)
	var y = rand_range(-300, 300)
	
	match distance:
		0:
			return Vector2.ZERO
		1:
			return Vector2(0, y)
		2:
			return Vector2(x, 0)
		3:
			return Vector2(x, y)