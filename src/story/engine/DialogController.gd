"""
Copyright(C) 2019 You're Perfect LLC, All Rights Reserved
Licensed under the MIT license, see LICENSE file in the
project root folder for more information.
"""
extends CanvasLayer
class_name DialogController

enum Position {
	None = 0,
	Left = 1,
	Right = 2,
	Middle = 3,
}

signal next_pressed

export var message_speed = 0.05
onready var next_close = $"./Container/CloseButton"
onready var charlist = CharactersList.new().characters

var reading_text:bool = false
var target_text:String = ""
var current_choices:Array


"""
Mid-level function for presenting a single phrase of dialog. This will set the portrait,
expression, position, etc. defined by the given phrase object and will attempt to
load appropriate matching audio.
"""
func play_phrase(phrase:DialogPhrase):
	$Container/CloseButton.show()
	set_portait(phrase.position, phrase.character, phrase.expression)
	set_speaker(phrase.character)
	read_text(phrase.get_text(), phrase.get_audio())
	if phrase.choices.size() > 0:
		offer_choice(phrase.choices)


"""
Play an array of phrases and close dialog at the end. This will trigger audio
and play messages at the set speed, allowing the user to skip the messages.
Will also set player portrait and expressions
"""
func play_phrases(phrases:Array):
	for i in range(phrases.size()):
		play_phrase(phrases[i])
		yield(self,"next_pressed")
		if i == phrases.size() - 1 && phrases[i].choices.size() == 0:
			hide_workaround()


func read_text( text:String, audio:AudioStream ):
	set_text("")
	target_text = text
	reading_text = true
	for i in range(text.length()):
		if reading_text:
			set_text(get_text()+text[i])
			yield(get_tree().create_timer(message_speed),"timeout")
	reading_text = false
	#TODO audio


func offer_choice( choices:Array ):
	assert( choices.size() > 0 )
	current_choices = choices
	$Container/CloseButton.hide()
	while reading_text:
		yield(get_tree(), "idle_frame")
	for i in range(choices.size()):
		assert(choices[i] is DialogChoice)
		show_choice( i, choices[i].label )

#TODO create the labels dynamically
func show_choice( choice:int, label:String ):
	match choice:
		0:
			$Container/Option1.show()
			$Container/Option1.text = label
		1:
			$Container/Option2.show()
			$Container/Option2.text = label
		2:
			$Container/Option3.show()
			$Container/Option3.text = label

func on_next_pressed():
	if reading_text:
		set_text(target_text)
		reading_text = false
	else:
		$Container/AudioPlayer.stop()
		emit_signal("next_pressed")


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


func get_text() -> String:
	return $Container/DialogText.text


func set_text( text:String ):
	$Container/DialogText.text = text

# see https://github.com/godotengine/godot/issues/16532
func show_workaround():
	$Container.show()
func hide_workaround():
	$Container.hide()


func _on_Option_pressed(option:int):
	assert(option > 0 && option <= current_choices.size())
	$Container/Option1.hide()
	$Container/Option2.hide()
	$Container/Option3.hide()
	$Container/CloseButton.show()
	hide_workaround()
	var choice = current_choices[option-1]
	if  choice.player != null and not choice.function.empty():
		choice.player.callv(choice.function,choice.params)
	current_choices = []
