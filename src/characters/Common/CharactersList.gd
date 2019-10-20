"""
Copyright(C) 2019 You're Perfect LLC, All Rights Reserved
Licensed under the MIT license, see LICENSE file in the
project root folder for more information.
"""
extends Object
class_name CharactersList

var characters : Dictionary = {
	"Robin"		:	preload("res://characters/Robin.tres"),
	"Catherine"		:	preload("res://characters/Catherine.tres"),
	"ComingSoon"	:	preload("res://characters/ComingSoon.tres"),
	}

func get_portrait(character_name:String, expression:String = "default") -> Texture:
	assert(character_name in characters)
	assert(expression in characters[character_name].expressions)
	return characters[character_name].expressions[expression]

func get_playable_characters() -> Dictionary:
	var out = []
	for index in characters:
		if characters[index].playable_character:
			if index == "Robin":
				out.push_front(characters[index]) #make sure Robin is first
			else:
				out.append(characters[index])
	return out
