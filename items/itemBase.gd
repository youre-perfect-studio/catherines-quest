extends RigidBody2D

var speed = 35

onready var magnet = get_node("../magnet")

const type = "item"

var inMagnet = false

func _ready():
	set_physics_process(false)

func _physics_process(delta):
	if name != "magnet":
		var magPos = get_node("../magnet/pullZone").global_position
		var direction = get_node("../" + name + "/magnetic").global_position - magPos
		var pullDirection = direction
	
		if inMagnet == false:
			self.set_applied_force(-pullDirection * speed * delta)
			if sleeping == true:
				set_sleeping(false)
		
		else:
			set_sleeping(true)
	else:
		pass