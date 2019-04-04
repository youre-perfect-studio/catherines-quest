extends RigidBody2D

var speed = 35



onready var magnet = get_node("../magnet")

const type = "item"

var inMagnet = false

func _physics_process(delta):
	var magPos = get_node("../magnet/pullZone").global_position

	var direction = global_position - magPos
	
	var pullDirection = direction * speed * delta
	if inMagnet == false:
		self.set_applied_force(-pullDirection * speed * delta)
		if get_mode() != 0:
			set_mode(0)
		

	else:
		if get_mode() != 1:
			set_mode(1)
		#self.set_applied_force(pullDirection * speed * delta)