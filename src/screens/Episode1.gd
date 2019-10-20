"""
Copyright(C) 2019 You're Perfect LLC, All Rights Reserved
Licensed under the MIT license, see LICENSE file in the
project root folder for more information.
"""
extends Node

func _ready():
	TranslationServer.set_locale("en_US")
	call_deferred("spawn_players")
	load_game()

func spawn_players():
	#This should only happe when running single-scene debugging
	if Globals.Players.size() == 0:
		Globals.Players.append(CharactersList.new().characters["Robin"].character_scene.instance())
	elif $player.respawn_count == 0:
		$player.show_opening_dialog()
		#Globals.MusicPlayer.fade(preload("res://music/lost_in_the_meadows_by_augmetality_cc0.ogg"),1.0,1.0)
		Globals.MusicPlayer.stop_all()
		Globals.MusicPlayer.play(preload("res://music/lost_in_the_meadows_by_augmetality_cc0.ogg"))

	#TODO when character selection works
	#for player in Globals.Players:
	#	$"/root/Episode1".add_child(player)
	
func load_game():
	if SaveFunctions.continuing == true:
		SaveFunctions.load_game()
	
func dropItem(item):
	var newItem = item.instance()
	add_child(newItem)
