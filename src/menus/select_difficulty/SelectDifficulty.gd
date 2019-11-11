extends Control

export(NodePath) var start_button_path
export(NodePath) var diffuculty_list_path

onready var start_button = get_node(start_button_path)
var difficulty_panels = []

var selected_difficulty = Globals.DiffucultyLevel.NORMAL

func _ready():
	var difficulty_list = get_node(diffuculty_list_path)
	difficulty_panels = difficulty_list.get_children()

	for panel in difficulty_panels:
		panel.connect('selected', self, 'on_difficulty_panel_selected', [panel])

	start_button.connect('pressed', self, 'start')

	for panel in difficulty_panels:
		if panel.difficulty == Globals.DiffucultyLevel.NORMAL:
			panel.currently_selected = true
			break

func on_difficulty_panel_selected(selected_panel):
	selected_difficulty = selected_panel.difficulty
	for panel in difficulty_panels:
		if panel != selected_panel:
			panel.currently_selected = false

func start():
	Globals.difficulty = selected_difficulty

	var characters = CharactersList.new().get_playable_characters()
	Globals.Players.append(characters.front().character_scene.instance())
	get_tree().change_scene('res://screens/Episode1.tscn')
	#TODO spawn the player character by instancing characters[index].character_scene
	#after the user selects, instead of pre-spawning player.tscn
