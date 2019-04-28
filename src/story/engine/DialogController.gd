extends CanvasLayer

enum Position {
	Left,
	Right,
	Middle,
}

"""
Convenience function for showing a character portrait at the given posittion. 

@param text Verbatim text, not a translation key.
@param character_name null or empty will continue using the last-used character
@param expression eg 'default', 'surprised', etc. Used for loading different portraits.
	null will attempt to keep using the last-used expression. If the last-used character
	changes last-used expression will reset to 'default'
"""
func read_verbatim_text( text:String, character_name:String, portrain_position:String, expression:String):
	#TODO
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