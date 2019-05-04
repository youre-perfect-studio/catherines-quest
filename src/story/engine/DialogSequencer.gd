extends Object
class_name DialogSequencer

static func generate_sequence(grouping:String, start:int, end:int, character:String, expression:String, position:int) -> Array:
	assert(start>0)
	assert(end>=start)
	assert(not grouping.empty())
	var openingDialog = []
	for i in range(start,end+1):
		openingDialog.append(DialogPhrase.new(grouping, i, character, expression, position))
	return openingDialog