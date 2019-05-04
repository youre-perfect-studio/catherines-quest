extends Object
class_name DialogPhrase

var grouping:String
var number:int
var character:String
var expression:String
var position:int

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

func get_text() -> String:
	return tr(get_index_name())

func get_audio() -> AudioStream:
	#TODO
	return null
