extends Control

export(NodePath) var reset_button_path
export(NodePath) var title_button_path
export(NodePath) var quit_button_path
export(NodePath) var resume_button_path
export(NodePath) var restart_button_path
export(NodePath) var death_reset_button_path

export(NodePath) var are_you_sure_dialog_path

onready var reset_button  = get_node(reset_button_path)
onready var title_button  = get_node(title_button_path)
onready var quit_button   = get_node(quit_button_path)
onready var resume_button = get_node(resume_button_path)
onready var restart_button = get_node(restart_button_path)
onready var death_reset_button = get_node(death_reset_button_path)

onready var are_you_sure_dialog = get_node(are_you_sure_dialog_path)

var confirm_action_funcref

# Controls set of buttons, common ingame menu or death menu
# Resets to false after menu is closed
var death_mode = false setget set_death_mode
func set_death_mode(value):
	if death_mode == value:
		return

	death_mode = value
	reset_button.visible = !death_mode
	restart_button.visible = death_mode

	resume_button.visible = !death_mode
	death_reset_button.visible = death_mode

func _ready():
	resume_button.connect('pressed', self, 'resume')
	reset_button.connect('pressed', self, 'reset')
	title_button.connect('pressed', self, 'title_screen_confirm')
	quit_button.connect('pressed', self, 'quit_confirm')
	restart_button.connect('pressed', self, 'restart')
	death_reset_button.connect('pressed', self, 'reset')

	are_you_sure_dialog.connect('confirmed', self, 'confirm_action')

	death_mode = true
	self.death_mode = false

func _input(ev):
	if ev.is_action_pressed('ui_cancel'):
		toggle()

func toggle():
	if not visible:
		show()
	else:
		resume()

func show():
	get_tree().paused = true
	visible = true
	if death_mode:
		death_reset_button.grab_focus()
	else:
		resume_button.grab_focus()

func resume():
	visible = false
	self.death_mode = false
	get_tree().paused = false

func reset():
	resume()
	$'../../player'.restart()

func title_screen_confirm():
	are_you_sure_dialog.window_title = 'Return to Title Screen'
	are_you_sure_dialog.get_label().text = 'Are you sure you want to return to the title screen?'
	are_you_sure_dialog.get_ok().text = 'Yes'
	are_you_sure_dialog.get_cancel().text = 'No'
	are_you_sure_dialog.popup_centered()
	confirm_action_funcref = funcref(self, 'return_to_title_screen')

func return_to_title_screen():
	resume()
	get_tree().change_scene('res://TitleScreen.tscn')

func quit_confirm():
	are_you_sure_dialog.window_title = 'Quit Game'
	are_you_sure_dialog.get_label().text = 'Are you sure you want to quit?'
	are_you_sure_dialog.get_ok().text = 'Yes'
	are_you_sure_dialog.get_cancel().text = 'No'
	are_you_sure_dialog.popup_centered()
	confirm_action_funcref = funcref(self, 'quit')

func quit():
	get_tree().quit()

func confirm_action():
	confirm_action_funcref.call_func()

func restart():
	resume()
	get_tree().change_scene("res://screens/Episode1.tscn")
