extends "res://items/itemBase.gd"

var beingEaten = false

onready var dragon = get_node("../dragon")

func _ready():
	$dragonAttract.connect("area_entered", self, "onAttractEntered")
	$hitbox.connect("area_entered", self, "onHitboxEntered")
	$Timer.connect("timeout", self, "baitEaten")
	
	
func onAttractEntered(area):
	if area.get_parent().get("subType") == "dragon":
		area.get_parent().baitChase = true
		
func onHitboxEntered(area):
	if area.name == "bitebox":
		$Timer.start(4)
	
func baitEaten():
	dragon.baitChase = false
	queue_free()