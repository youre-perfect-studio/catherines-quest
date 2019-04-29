extends PopupMenu

func _ready():
	$CloseButton.connect("pressed", self, "close")
	$RestartButton.connect("pressed", self, "restart")
	$QuitButton.connect("pressed", self, "quit")
	
func close():
	visible = false
	
func restart():
	$"../../player".restart()
	
func quit():
	pass

