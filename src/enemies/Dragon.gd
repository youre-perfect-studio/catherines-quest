"""
Copyright(C) 2019 You're Perfect LLC, All Rights Reserved
Licensed under the MIT license, see LICENSE file in the
project root folder for more information.
"""
extends "res://engine/Entity.gd"

#plan on making hitbox more defined once actual dragon art created, along with anything else
# Vector2 Room Size (960, 540)

onready var player = get_node("../player")
onready var bitebox =  get_node("../" + self.name +"/bitebox/CollisionShape2D")
onready var cam = get_node("../cam")

var moveTimerLength
var moveTimer = 0
var baitChase = false
var eating = false

func _ready():
	moveTimerLength = randi() % 800 + 100
	moveTimer = moveTimerLength
	subType = "dragon"
	speed = 200
	anim_switch("walk")
	
func _physics_process(delta):
	damageLoop()
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
	elif baitChase == true && eating == false:
		movedir = (get_node("../bait").global_position - bitebox.global_position).normalized()

	elif chasing == true && baitChase == false && eating == false:
			movedir = (player.global_position - bitebox.global_position).normalized()
	else:
		pass
	movementLoop()
	spritedirLoop()
	anim_switch("walk")
		
