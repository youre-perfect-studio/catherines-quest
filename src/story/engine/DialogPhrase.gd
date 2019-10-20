"""
Copyright(C) 2019 You're Perfect LLC, All Rights Reserved
Licensed under the MIT license, see LICENSE file in the
project root folder for more information.
"""
extends Object
class_name DialogPhrase

var grouping:String
var number:int
var character:String
var expression:String
var position:int
var choices:Array

func _init( grouping:String, number:int, character:String, expression:String, position:int ):
	self.grouping = grouping
	self.number = number
	self.character = character
	self.expression = expression
	self.position = position

func get_index_name() -> String:
	assert(number > 0)
	assert(not grouping.empty())
	return grouping+"_"+str(number)

# Returns the translated text, if there is no match for the index
# return "..."
func get_text() -> String:
	var translatedIndexName = tr(get_index_name())
	if translatedIndexName == get_index_name():
		return "..."
	return tr(get_index_name())

func get_audio() -> AudioStream:
	#TODO
	return null
