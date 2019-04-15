"""
Copyright(C) 2019 You're Perfect LLC, All Rights Reserved
Licensed under the MIT license, see LICENSE file in the
project root folder for more information.
"""
tool
extends VisualScriptCustomNode

func _get_caption():
	return "Read Sequence"

func _has_input_sequence_port():
	return true

func _get_output_sequence_port_count():
	return 1

func _get_input_value_port_count():
	return 1

func _get_input_value_port_name(idx):
	match idx:
		0:
			return "Scene File"

func _get_input_value_port_type(idx):
	match idx:
		0:
			return typeof(Node)

func _get_output_value_port_count():
	return 0

func _step(inputs, outputs, start_mode, working_mem):
	assert(inputs.size() == 1)
	outputs = []
