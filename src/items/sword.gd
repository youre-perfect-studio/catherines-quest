extends Node
	
var type = null
const damage = 1	

var max_amount = 1

func _ready():
	type = get_parent().type
	$Anim.connect("animation_finished", self, "destroy")
	$Anim.play(str("swing", get_parent().spritedir))
	if get_parent().has_method("state_swing"):
		get_parent().state = "swing"
func destroy(animation):
	if get_parent().has_method("state_swing"):
		get_parent().state = "default"
	queue_free()	
