extends Node

var save_file_name = "slot1"
var continuing  =  false
var saving = false

func _ready():
	pass


func save_game():
	saving = true
	var save_game = File.new()
	save_game.open(str("user://",save_file_name,".save"), File.WRITE)
    # Searches for nodes that are set to the group "Persist"
	# Calls the save function for that node
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		var node_data = i.call("save");
		save_game.store_line(to_json(node_data))
	save_game.close()
	saving = false

func set_continuing():
	continuing = true
	
func load_game():
	var save_game = File.new()
	if not save_game.file_exists(str("user://",save_file_name,".save")):
		return # Error! We don't have a save to load.

    # We need to revert the game state so we're not cloning objects
    # during loading. This will vary wildly depending on the needs of a
    # project, so take care with this step.
    # For our example, we will accomplish this by deleting saveable objects.
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		i.queue_free()

    # Load the file line by line and process that dictionary to restore
    # the object it represents.
	save_game.open(str("user://",save_file_name,".save"), File.READ)
	while not save_game.eof_reached():
		var current_line = parse_json(save_game.get_line())
		print(current_line)
		if current_line != null:
	        # Firstly, we need to create the object and add it to the tree and set its position.
			var new_object = load(current_line["filename"]).instance()
			get_node(current_line["parent"]).add_child(new_object)
			new_object.position = Vector2(current_line["pos_x"], current_line["pos_y"])
			if current_line.has("scale_x"):
				new_object.set_scale(Vector2(current_line["scale_x"], current_line["scale_y"]))
	        # Now we set the remaining variables.
			for i in current_line.keys():
				if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y" or i == "scale_x" or i == "scale_y":
					continue
				new_object.set(i, current_line[i])
	save_game.close()