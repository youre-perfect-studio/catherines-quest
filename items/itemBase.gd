extends RigidBody2D

var speed = 35

const type = "item"

var inMagnet = false

func _ready():
	set_physics_process(false)

func _physics_process(delta):
	rotation_degrees = 0
	if name != "magnet":
		var magPos = get_node("../magnet/pullZone").global_position
		var direction = get_node("../" + name + "/magnetic").global_position - magPos
		if inMagnet == false:
			self.set_applied_force(-direction * speed * delta)
			if sleeping == true:
				set_sleeping(false)

		else:
			self.set_applied_force(Vector2.ZERO)
			set_sleeping(true)
			set_sleeping(false)
	else:
		pass
	