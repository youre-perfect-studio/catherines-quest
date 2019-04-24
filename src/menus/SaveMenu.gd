extends PopupMenu

func _ready():
	$Save.connect("pressed", self, "set_respawn_point")
	$Respawn.connect("pressed", self, "save")
	
func save():
	print("saving")
	
func set_respawn_point():
	print("setting respawn point")