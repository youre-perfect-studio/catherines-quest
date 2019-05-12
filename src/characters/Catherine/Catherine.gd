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

	if not roux_node.follow_player:
		dialog_controller_node.read_verbatim_text("Please find our missing queen!", "Catherine", 1, "default")
		dialog_controller_node.show_workaround()
		yield(dialog_controller_node.next_close,"pressed")
		dialog_controller_node.hide_workaround()
		#Globals.MusicPlayer.fade(preload("res://music/A_Darkness_Opus_by_Alexandr_Zhelanov_ccby4.ogg"),1.0,1.0)
		Globals.MusicPlayer.stop_all()
		Globals.MusicPlayer.play(preload("res://music/A_Darkness_Opus_by_Alexandr_Zhelanov_ccby4.ogg"))
	else:
		dialog_controller_node.read_verbatim_text("Great job everyone\nThis game is getting there!\nThanks for your love and support <3", "Catherine", 1, "default")
		dialog_controller_node.show_workaround()
		yield(dialog_controller_node.next_close,"pressed")
		dialog_controller_node.hide_workaround()
		