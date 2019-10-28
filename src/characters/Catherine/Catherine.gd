"""
Copyright(C) 2019 You're Perfect LLC, All Rights Reserved
Licensed under the MIT license, see LICENSE file in the
project root folder for more information.
"""
extends "res://characters/Common/NPC.gd"

onready var dialog_controller_node:DialogController = $"../DialogController"
onready var roux_node = $"../NPC"
onready var charlist = CharactersList.new()

func begin_dialog( player:Player ):	

	if not follow_player:
		#Globals.MusicPlayer.fade(preload("res://music/A_Darkness_Opus_by_Alexandr_Zhelanov_ccby4.ogg"),1.0,1.0)
		Globals.MusicPlayer.stop_all()
		Globals.MusicPlayer.play(preload("res://music/A_Darkness_Opus_by_Alexandr_Zhelanov_ccby4.ogg"))
		give_quest(player)
	else:
		dialog_controller_node.read_verbatim_text("Great job everyone\nThis game is getting there!\nThanks for your love and support <3", "Catherine", 1, "default")
		dialog_controller_node.show_workaround()
		yield(dialog_controller_node.next_close,"pressed")
		dialog_controller_node.hide_workaround()

func give_quest( player:Player ):
	var dialog:Array = DialogSequencer.generate_sequence("GET_QUEST", 1, 2, "Catherine", "default", dialog_controller_node.Position.Right)
	dialog += DialogSequencer.generate_sequence("GET_QUEST", 3, 6, "Robin", "default", dialog_controller_node.Position.Left)
	dialog += DialogSequencer.generate_sequence("GET_QUEST", 7, 7, "Catherine", "default", dialog_controller_node.Position.Right)
	dialog += DialogSequencer.generate_sequence("GET_QUEST", 8, 8, "Robin", "default", dialog_controller_node.Position.Left)
	dialog += DialogSequencer.generate_sequence("GET_QUEST", 9, 14, "Catherine", "default", dialog_controller_node.Position.Right)
	dialog += DialogSequencer.generate_sequence("GET_QUEST", 15, 16, "Robin", "default", dialog_controller_node.Position.Left)
	dialog += DialogSequencer.generate_sequence("GET_QUEST", 17, 17, "Catherine", "default", dialog_controller_node.Position.Right)
	dialog += DialogSequencer.generate_sequence("GET_QUEST", 18, 18, "Robin", "default", dialog_controller_node.Position.Left)
	dialog += DialogSequencer.generate_sequence("GET_QUEST", 19, 19, "Catherine", "default", dialog_controller_node.Position.Right)
	dialog += DialogSequencer.generate_sequence("GET_QUEST", 20, 20, "Robin", "default", dialog_controller_node.Position.Left)
	dialog += DialogSequencer.generate_sequence("GET_QUEST", 21, 22, "Catherine", "default", dialog_controller_node.Position.Right)
	
	var choices:Array = []
	var choice1 = DialogChoice.new()
	choice1.label = tr("GET_QUEST_23")	
	var choice2 = DialogChoice.new()
	choice2.label = tr("GET_QUEST_24")
	var choice3 = DialogChoice.new()
	choice3.label = tr("GET_QUEST_25")
	choices.append(choice1)
	choices.append(choice2)
	choices.append(choice3)
	dialog[dialog.size()-1].choices = choices
		
			
	dialog_controller_node.clear()
	dialog_controller_node.show_workaround()
	dialog_controller_node.next_close.text = tr("Next")
	dialog_controller_node.play_phrases(dialog)
