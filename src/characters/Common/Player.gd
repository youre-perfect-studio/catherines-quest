"""
Copyright(C) 2019 You're Perfect LLC, All Rights Reserved
Licensed under the MIT license, see LICENSE file in the
project root folder for more information.
"""
extends "res://engine/Entity.gd"
class_name Player

signal open_menu

###########Temporary variable#######
export var buttonPickup = false
########### To use set true in inspector ##########

var character_info:Character = null
var state = "default"
var useItemName = "none"
var useItem = null
export var base_health = 2
var respawn_point_x = 1200
var respawn_point_y = 800
var respawn_count = 0
var is_close_to_sign = false

var has_spoken_to_catherine:bool = false
var has_accepted_quest:bool = false
var has_seen_a_dragon:bool = false

onready var catherine_node = $"../Catherine"
onready var roux_node = $"../Roux"
onready var catherine_talk_area = $"../Catherine/talkZone"
onready var roux_talk_area = $"../Roux/talkZone"
onready var dialog_controller_node = $"../DialogController"

var utilities = load("res://engine/Utilities.gd")

func _ready():
	assert(catherine_node != null)
	if buttonPickup == false:
		$DamageArea.connect("area_entered", self, "onAreaEntered")
		#$DamageArea.connect("area_exited", self, "onAreaExited")
	
func _physics_process(delta):
	match state:
		"default":
			state_default()
		"swing":
			state_swing()
	
func controlLoop():
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	var up = Input.is_action_pressed("ui_up")
	var down = Input.is_action_pressed("ui_down")
	
	movedir.x = -int(left) + int(right)
	movedir.y = -int(up) + int(down)
	
	if hasAmulet == true:
		#$aura.visible = true
		#$auraPlayer.play("default")
		$aura_particles/Particles2D.emitting = true
	else:
		#$aura.visible = false
		$aura_particles/Particles2D.emitting = false
	
	if Input.is_action_just_pressed("interact"):
		if $DamageArea.overlaps_area(catherine_talk_area) && catherine_node.follow_player != true:
			talk_to_npc("Catherine")
	
	if Input.is_action_just_pressed("attack"):
		# if player close to the sign and attack pressed then open the menu
		if is_close_to_sign:
			emit_signal("open_menu")
		
	if Input.is_action_just_pressed("attack"):
		match useItemName:

			"none":
				if buttonPickup == true:
					for area in $DamageArea.get_overlapping_areas():
						if area.get_parent().get("type") == "item" && area.name == "hitbox":
							if area.get_parent().name == "sword":
								$"../cam/useItem".texture = load("res://items/img/" + area.get_parent().name + "Drop.png")
							else:
								$"../cam/useItem".texture = load("res://items/img/" + area.get_parent().name + ".png")
							$"../cam/useItem".visible = true
#							if area.get_parent().name == "magnet":
#								$"../cam".magnetPickedUp() #idea to allow dropped items to have magnetism, still going to work with it later
							if area.get_parent().name == "amulet":
								hasAmulet = true
							useItemName = area.get_parent().name
							area.get_parent().queue_free()
							print(useItemName)
						else:
							pass

			"sword":
				use_item(preload("res://items/Sword.tscn"))
				
			"bridge":
				$"../".dropItem(load("res://items/" + useItemName + ".tscn"))
				var drop = get_node("../" + useItemName)
				drop.position = get_node("../player").global_position - movedir
				useItemName = "none"
				$"../cam/useItem".visible = false
				
			"bait":
				$"../".dropItem(load("res://items/" + useItemName + ".tscn"))
				var drop = get_node("../" + useItemName)
				drop.position = get_node("../player").global_position - get_node("../player/followerSpace").position * 2
				useItemName = "none"
				$"../cam/useItem".visible = false
				
	if Input.is_action_just_pressed("drop") && useItemName != "none":
		drop_item()

func drop_item():
	if useItemName == "sword":
		$"../".dropItem(load("res://items/" + useItemName + "Drop.tscn"))
	else:
		if useItemName == "amulet":
			hasAmulet = false
		$"../".dropItem(load("res://items/" + useItemName + ".tscn"))
	var poop = get_node("../" + useItemName)
	poop.position = get_node("../player").global_position + get_node("../player/followerSpace").position
	get_node("../" + useItemName).dropped = true  
	useItemName = "none"
	$"../cam/useItem".visible = false

func state_default():
	controlLoop()
	movementLoop()
	spritedirLoop()
	$followerSpace/fsMover.play(spritedir)
	if movedir != Vector2.ZERO:
		anim_switch("walk")
	else:
		anim_switch("idle")
	damageLoop()

func state_swing():
	anim_switch("attack")
	movementLoop()
	movedir = Vector2.ZERO
	damageLoop()
	
func restart():
	health = base_health
	position = Vector2(respawn_point_x, respawn_point_y)
	respawn_count += 1

#func get_amulet():
#	hasAmulet = true 
	
func talk_to_npc( npc_name:String ):
	match npc_name:
		"Catherine":
			catherine_node.begin_dialog(self)
		"Roux":
			roux_node.begin_dialog(self)

func show_opening_dialog(sequence:int = 0):
	var openingDialog:Array
	match sequence:
		0:
			#Currently assuming Robin as character
			openingDialog = DialogSequencer.generate_sequence("ROBIN_INTRO", 1, 3, "Robin", "default", dialog_controller_node.Position.Left)
			
			var choices:Array = []
			var choice1 = DialogChoice.new()
			choice1.label = tr("ROBIN_INTRO_5")	
			choice1.player = self
			choice1.function = "show_opening_dialog"
			choice1.params = [1]
			var choice2 = DialogChoice.new()
			choice2.label = tr("ROBIN_INTRO_9")
			choice2.player = self
			choice2.function = "show_opening_dialog"
			choice2.params = [2]
			choices.append(choice1)
			choices.append(choice2)
			openingDialog[openingDialog.size()-1].choices = choices
		1:
			openingDialog = DialogSequencer.generate_sequence("ROBIN_INTRO", 6, 8, "Robin", "annoyed", dialog_controller_node.Position.Left)
			openingDialog += DialogSequencer.generate_sequence("ROBIN_INTRO", 13, 19, "Robin", "default", dialog_controller_node.Position.Left)
		2:
			openingDialog = DialogSequencer.generate_sequence("ROBIN_INTRO", 10, 19, "Robin", "default", dialog_controller_node.Position.Left)
		
	dialog_controller_node.clear()
	dialog_controller_node.show_workaround()
	dialog_controller_node.next_close.text = tr("Next")
	dialog_controller_node.play_phrases(openingDialog)

	
func set_restore_point():
	respawn_point_x = position.x
	respawn_point_y = position.y
	
func save():
	var save_dict = {
		"filename": get_filename(),
		"parent": get_parent().get_path(),
		"pos_x": position.x,
		"pos_y": position.y,
		"health": health,
		"damage": damage,
		"spritedir": spritedir,
		"respawn_point_x": respawn_point_x,
		"respawn_point_y": respawn_point_y,
		"respawn_count": respawn_count,
		"hasAmulet": hasAmulet,
		"has_accepted_quest": has_accepted_quest,
		"has_seen_a_dragon": has_seen_a_dragon,
		"has_spoken_to_catherine": has_spoken_to_catherine,
		"speed": speed,
		"scale_x": get_scale().x,
		"scale_y": get_scale().y,
		"type": type
	}
	return save_dict
	
# handles when player collides with an area object
func onAreaEntered(area):
	# handles if object is an item type
	if area.name == "hitbox" and area.get_parent().get("type") == "item":
		# if player is holding an item, then drop it
		if useItemName != "none":
			drop_item()

		# if player is not holding an item, then process acquiring it
		useItem = area.get_parent()
		useItemName = useItem.name
		acquire_item(useItem)
	# if not an item, then pass and handle elsewhere
	else:
		pass

func acquire_item(item):
	# update sprite on camera useItem
	var item_sprite_texture = item.get_node("Sprite").texture
	$"../cam/useItem".texture = item_sprite_texture

	# resize texture
	var texture_scale = utilities.resize_texture(item_sprite_texture)
	$"../cam/useItem".scale = texture_scale
	
	# have useItem appear
	$"../cam/useItem".visible = true
	
	# update logic after acquiring item
	var lower_case_item_name = item.name.to_lower()
	match lower_case_item_name:
		"amulet":
			hasAmulet = true
		"magnet":
			$"../cam".magnetPickedUp()
	
	# remove item from scene
	item.queue_free()
