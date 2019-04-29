extends PopupMenu

export var positionx = 0
export var positiony = 0

func _ready():
	$Save.connect("pressed", self, "save")
	$Respawn.connect("pressed", self, "set_respawn_point")
	$Close.connect("pressed", self, "close")
	rect_position = Vector2(positionx, positiony)
	
func save():
	print("saving")
	SaveFunctions.save_game()
	
func set_respawn_point():
	print("setting respawn point")
	$"../../player".set_restore_point()
	
func close():
	print("closing menu")
	visible = false