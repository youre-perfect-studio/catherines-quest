extends Node2D

func _ready():
	$NewGameBtn.grab_focus()
	$NewGameBtn.connect("pressed", self, "new_game")
	$ContinueBtn.connect("pressed", self, "continue_game")

func new_game():
	print("New game")
	
func continue_game():
	print("continue")