extends Control

func _ready():
	$CloseButton.connect("pressed", self, "close")
	$MainScreen.connect("pressed", self, "to_main_menu")
	$RestartButton.connect("pressed", self, "restart")
	$QuitButton.connect("pressed", self, "quit")
	self.connect("modal_closed", self, "close")
	self.connect("visibility_changed", self, "set_focus")
	
func set_focus():
	$RestartButton.grab_focus()
	
	
func close():
	get_tree().paused = false
	visible = false
	
	
func restart():
	$"../../player".restart()
	close()
	
func quit():
	get_tree().quit()
	
func to_main_menu():
	get_tree().paused = false
	get_tree().change_scene("res://title.tscn")
	
	

