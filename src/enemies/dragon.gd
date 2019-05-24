"""
Copyright(C) 2019 You're Perfect LLC, All Rights Reserved
Licensed under the MIT license, see LICENSE file in the
project root folder for more information.
"""
extends "res://engine/entity.gd"

#plan on making hitbox more defined once actual dragon art created, along with anything else
# Vector2 Room Size (960, 540)

onready var player = get_node("../player")
onready var bitebox =  get_node("../dragon/bitebox")
onready var cam = get_node("../cam")

var moveTimerLength
var moveTimer = 0
var baitChase = false

func _ready():
	moveTimerLength = randi() % 800 + 100
	moveTimer = moveTimerLength
	$bitebox.connect("area_entered", self, "onAreaEntered")
	anim_switch("walk")
	
func _physics_process(delta):
	damageLoop()
	movementLoop()
	if chasing == false && baitChase == false:
		if moveTimer > 0:
			moveTimer -= 1
			if is_on_wall():
				movedir = -movedir
		elif moveTimer == 0:
			movedir = pickDirection()
			moveTimer = moveTimerLength
			if is_on_wall():
				movedir = -movedir
	elif baitChase == true:
		movedir = (get_node("../bait/dragonAttract").global_position - bitebox.global_position).normalized()
	elif chasing == true && baitChase == false:
			movedir = (player.global_position - bitebox.global_position).normalized()
	else:
		pass
	anim_switch("walk")
		
		#unless there is a specific plan for below, it's useless now with DamageLoop() in place
func onAreaEntered(area):
	pass
	#if area.get_parent().get("type") == "player":
		#if area.get_parent().get("hasAmulet") == false:
			#player.set_physics_process(false)
			#player.set_visible(false)