extends CanvasLayer

func _ready():
	pass

func set_left_portrait( portrait:Texture ):
	$Container/LeftPortrait.texture = portrait

func set_right_portrait( portrait:Texture ):
	$Container/RightPortrait.texture = portrait

func set_speaker( name:String ):
	$Container/Speaker.text = name

func set_text( text:String ):
	$Container/DialogText.text = text

func _on_close_button_pressed():
	hide_workaround()

# see https://github.com/godotengine/godot/issues/16532
func show_workaround():
	$Container.show()
func hide_workaround():
	$Container.hide()