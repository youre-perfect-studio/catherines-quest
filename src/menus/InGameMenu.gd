extends Control

export(NodePath) var reset_button_path
export(NodePath) var title_button_path
export(NodePath) var quit_button_path
export(NodePath) var resume_button_path

export(NodePath) var are_you_sure_dialog_path

onready var reset_button  = get_node(reset_button_path)
onready var title_button  = get_node(title_button_path)
onready var quit_button   = get_node(quit_button_path)
onready var resume_button = get_node(resume_button_path)

onready var are_you_sure_dialog = get_node(are_you_sure_dialog_path)

var confirm_action_funcref

func _ready():
	resume_button.connect('pressed', self, 'resume')
	reset_button.connect('pressed', self, 'reset')
	title_button.connect('pressed', self, 'title_screen_confirm')
	quit_button.connect('pressed', self, 'quit_confirm')

	are_you_sure_dialog.connect('confirmed', self, 'confirm_action')

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
	resume_button.grab_focus()

func resume():
	visible = false
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

