extends RigidBody2D

var speed = 35

const type = "item"

func _physics_process(delta):

	var magPos = get_node("../magnet/pullZone").global_position

	var pullDirection = global_position - magPos
	
	self.add_central_force(-pullDirection / speed * delta)