"""
Copyright(C) 2019 You're Perfect LLC, All Rights Reserved
Licensed under the MIT license, see LICENSE file in the
project root folder for more information.
"""
extends Node
var Players = []
var MusicPlayer:AudioStreamPlayer

func _ready():
	MusicPlayer = AudioStreamPlayer.new()
	$"/root".call_deferred("add_child",MusicPlayer)
