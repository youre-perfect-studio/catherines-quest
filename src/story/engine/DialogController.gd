extends CanvasLayer

func _ready():
	pass


func _on_close_button_pressed():
	hide_workaround()

# see https://github.com/godotengine/godot/issues/16532
func show_workaround():
	self.scale = Vector2.ONE
func hide_workaround():
	self.scale = Vector2.ZERO