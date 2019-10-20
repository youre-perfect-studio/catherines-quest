extends Node2D

export(String) var teleport_to

func _ready():
	$Area2D.connect("area_entered", self, "teleport")

func teleport(area):
	if area.get_parent().get("type") == "player":
		var player = $"../../player"
		var dest = get_node(str("../",teleport_to,"/Position2D"))
		player.position.x = dest.global_position.x
		player.position.y = dest.global_position.y
