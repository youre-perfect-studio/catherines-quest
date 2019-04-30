extends Control


func _ready():
	
	$Save.connect("pressed", self, "save")
	$Respawn.connect("pressed", self, "set_respawn_point")
	$Close.connect("pressed", self, "close")
	$"../StatusTimer".connect("timeout", self, "reset_status_text")
	self.connect("modal_closed", self, "close")
	self.connect("visibility_changed", self, "set_focus")
	
func set_focus():
	$Save.grab_focus()
	
func save():
	print("saving")
	SaveFunctions.save_game()
	$"../Status".text = "Game has been saved"
	$"../StatusTimer".start()
	close()
	
func set_respawn_point():
	print("setting respawn point")
	close()
	$"../../player".set_restore_point()
	
	
func reset_status_text():
	$"../Status".text = ""
	
func close():
	print("closing menu")
	if get_tree() != null:
		get_tree().paused = false
	visible = false