tool
extends VisualScriptCustomNode

func _get_caption():
	return "Read Line"

func _has_input_sequence_port():
	return true

func _get_output_sequence_port_count():
	return 1

func _get_input_value_port_count():
	return 3

func _get_input_value_port_name(idx):
	match idx:
		0:
			return "Character"
		1:
			return "Expression"
		2:
			return "Line ID"

func _get_input_value_port_type(idx):
	match idx:
		0:
			return TYPE_STRING
		1:
			return TYPE_STRING
		2:
			return TYPE_INT

func _get_output_value_port_count():
	return 0