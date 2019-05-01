extends CanvasLayer
class_name DialogController

enum Position {
	Left = 0,
	Right = 1,
	Middle = 2,
}

onready var next_close = $"./Container/CloseButton"
onready var charlist = CharactersList.new().characters
var players = []

"""
Convenience function for showing a character portrait at the given posittion. 
Used for inserting incidental dialog with no associated audio.
TODO: revert to previous expressions/portraits after text is displayed

@param text Verbatim text, not a translation key. 
@param character_name 
@param portat_position Position enum value - see https://github.com/godotengine/godot/issues/20368
@param expression eg 'default', 'surprised', etc. Used for loading different portraits.
"""
func read_verbatim_text( text:String, character_name:String, portrait_position, expression:String):
	assert(portrait_position >= 0 and portrait_position < 3)
	var ch:Character = charlist.get(character_name,null)
		
	var portrait:Texture = null
	if ch != null:
		portrait = ch.expressions.get(expression,"default")
		assert(portrait != null)
		set_speaker(ch.character_name)
	else:
		set_speaker("")
	
	match portrait_position:
		Position.Left:
			set_left_portrait(portrait)
		Position.Right:
			set_right_portrait(portrait)
		Position.Middle:
			set_middle_portrait(portrait)
			
	set_text(text)
	show_workaround()

func clear():
	set_left_portrait(null)
	set_right_portrait(null)
	set_speaker("")
	set_text("")

func set_portait( position, character:String, expression:String):
	assert(position >= 0 and position < 3)
	var portrait:Texture = null
	var ch:Character = charlist.get(character,null)
	if ch != null:
		portrait = ch.expressions.get(expression,"default")
		assert(portrait != null)
	match position:
		Position.Left:
			set_left_portrait(portrait)
		Position.Right:
			set_right_portrait(portrait)
		Position.Middle:
			set_middle_portrait(portrait)
		
	
		

func set_left_portrait( portrait:Texture ):
	$Container/LeftPortrait.texture = portrait

func set_right_portrait( portrait:Texture ):
	$Container/RightPortrait.texture = portrait

func set_middle_portrait( portrait:Texture ):
	$Container/MiddlePortrait.texture = portrait

func set_speaker( name:String ):
	$Container/Speaker.text = name

func set_text( text:String ):
	$Container/DialogText.text = text

func _on_close_button_pressed():
	pass
	#hide_workaround()

# see https://github.com/godotengine/godot/issues/16532
func show_workaround():
	$Container.show()
func hide_workaround():
	$Container.hide()