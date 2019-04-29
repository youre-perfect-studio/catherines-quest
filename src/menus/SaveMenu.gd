extends PopupMenu

export var positionx = 0
export var positiony = 0

func _ready():
	$Save.connect("pressed", self, "save")
	$Respawn.connect("pressed", self, "set_respawn_point")
	$Close.connect("pressed", self, "close")
	$"../StatusTimer".connect("timeout", self, "reset_status_text")
	rect_position = Vector2(positionx, positiony)
	
func save():
	print("saving")
	SaveFunctions.save_game()
	$"../Status".text = "Game has been saved"
	$"../StatusTimer".start()
	close()
	
func set_respawn_point():
	print("setting respawn point")
	$"../../player".set_restore_point()
	
func reset_status_text():
	$"../Status".text = ""
	
func close():
	print("closing menu")
	visible = false