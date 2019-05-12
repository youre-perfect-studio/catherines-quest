extends Node2D

func _ready():
	$Area2D.connect("area_entered", self, "activate_barrier")
	$Area2D.connect("area_exited", self, "deactivate_barrier")

func activate_barrier(area):
	print("area entered")
	if area.get_parent().get("type") == "player":
		print("player found")
		$CPUParticles2D.emitting = true

func deactivate_barrier(area):
	if area.get_parent().get("type") == "player":
		$CPUParticles2D.emitting = false