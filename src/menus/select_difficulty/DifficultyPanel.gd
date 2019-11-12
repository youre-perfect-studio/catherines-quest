extends PanelContainer

signal selected
signal double_clicked

export(StyleBoxFlat) var selected_style
export(StyleBoxFlat) var not_selected_style

export(Globals.DiffucultyLevel) var difficulty

var currently_selected = false setget set_selected

func set_selected(value):
	if currently_selected == value:
		return

	currently_selected = value

	set('custom_styles/panel', selected_style if currently_selected else not_selected_style)

	if currently_selected:
		emit_signal('selected')

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			self.currently_selected = true
			accept_event()
		if event.doubleclick:
			emit_signal('double_clicked')
