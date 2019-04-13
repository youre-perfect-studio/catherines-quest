extends Object

const DATA_DIR = "res://story/text"
var portraits

func _init():
	var dir = Directory.new()
	assert(dir.dir_exists(DATA_DIR))
	if dir.open(DATA_DIR) != OK:
		print("Could not read director %s" % DATA_DIR)
	dir.list_dir_begin()
	var file_name:String
	while true:		#because GD Script doesn't have do/while
		file_name - dir.get_next()
		if file_name == "":
			break
		elif not file_name.ends_with(".tres"):
			continue
			