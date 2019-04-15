"""
Copyright(C) 2019 You're Perfect LLC, All Rights Reserved
Licensed under the MIT license, see LICENSE file in the
project root folder for more information.
"""

extends Resource
class_name Character

export(String) var character_name
export(bool) var playable_character
export(bool) var unlocked
export(PackedScene) var character_scene
export(String) var pronouns
export(Texture) var symbol
export(String,MULTILINE) var backstory
export(Dictionary) var expressions
