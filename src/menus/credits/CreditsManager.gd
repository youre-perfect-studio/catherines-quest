extends Control

# Time to start auto scrolling after user has finished manually scrolling
export(float) var auto_scroll_timeout = 1.0
# First timeout
export(float) var auto_scroll_initial_timeout = 1.0
# Speed of auto scrolling. 1 equals 1 space unit per second
export(float) var auto_scroll_speed = 50.0

onready var scroll_container = get_node("ScrollContainer")

var timeout
var user_scrolling = false
var scroll_pos = 0.0

func _ready():
	timeout = auto_scroll_initial_timeout

	$BackBtn.connect("pressed", self, "on_back_button_pressed")
	scroll_container.connect("scroll_started", self, "on_scroll_started")
	scroll_container.connect("scroll_ended", self, "on_scroll_ended")
	# Due to bug https://github.com/godotengine/godot/issues/22936
	# Scroll container is not shooting any scroll events
	# Listen scroll container gui input as a workaround
	scroll_container.connect("gui_input", self, "on_scroll_container_gui_input")
	scroll_container.get_node("_v_scroll").connect("gui_input", self, "on_scroll_container_gui_input")

func on_back_button_pressed():
	get_tree().change_scene("res://menus/GameSelection.tscn")

func on_scroll_started():
	user_scrolling = true

func on_scroll_ended():
	user_scrolling = false
	timeout = auto_scroll_timeout
	scroll_pos = scroll_container.scroll_vertical

func on_scroll_container_gui_input(event):
	if event is InputEventMouseButton:
		# Mouse wheel
		if event.button_index == BUTTON_WHEEL_UP or event.button_index == BUTTON_WHEEL_DOWN:
			on_scroll_started()
			on_scroll_ended()
			return
		# Scroll bar
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				on_scroll_started()
			else:
				on_scroll_ended()
			return

	if event is InputEventScreenDrag:
		on_scroll_started()
		on_scroll_ended()
		return

func _process(delta):
	if user_scrolling:
		return

	if timeout > 0.0:
		timeout -= delta
		return

	scroll_pos += auto_scroll_speed * delta
	scroll_container.scroll_vertical = int(scroll_pos)

