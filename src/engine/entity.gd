"""
Copyright(C) 2019 You're Perfect LLC, All Rights Reserved
Licensed under the MIT license, see LICENSE file in the
project root folder for more information.
"""
extends KinematicBody2D

export(String) var type = "enemy"
export(String) var subType
var is_alive = true
var chasing = false
export var hasAmulet = false

var damage = 1
export var health = 1
var hitstun = 0

var movedir = Vector2.ZERO

var spritedir = "left"

export(int) var speed = 80

func movementLoop():
	var motion
	motion = movedir.normalized() * speed
	move_and_slide(motion, Vector2.ZERO)

func pickDirection():
	var direction = randi() % 3
	var x = round(rand_range(-1, 1))
	var y = round(rand_range(-1, 1))
	
	match direction:
		0:
			return Vector2(0, y)
		1:
			return Vector2(x, 0)
		2:
			return Vector2(x, y)
			
func spritedirLoop():
	if movedir.x < 0: spritedir = "left"
	elif movedir.x > 0: spritedir = "right"
	elif movedir.y > 0: spritedir = "down"
	elif movedir.y < 0: spritedir = "up"
	elif spritedir.empty(): spritedir = "down"


func anim_switch(action):
	$Anim.play(action+spritedir)   
	
func damageLoop():
	if hitstun > 0:
		hitstun -= 1
		
	if self.name == "player":
		for area in $DamageArea.get_overlapping_areas():
			var body = area.get_parent()
			if hasAmulet == false && hitstun == 0 && body.get("damage") != null && body.get("type") != "player" && visible == true:
				if area.name=="bitebox":
					health -= body.get("damage")
					#print("lost " + str(body.get("damage")) + "health")
					hitstun = 10
	if self.type == "enemy":
		for area in get_node("../" + self.name + "/hitbox").get_overlapping_areas():
			var body = area.get_parent()
			if hitstun == 0 && body.get("damage") != null && body.get("type") == "weapon":
				health -= body.get("damage")
				
	if health <= 0:
		if type == "player":
			if is_alive:
				get_tree().paused = true
				$"../UI/RestartMenu".show()
				is_alive = false
		else:
			queue_free()
			
		if visible == true: #this was done for player to prevent crashing, anything else can be queue_free()
			visible = false
	else:
		visible = true
		is_alive = true
		#$Anim.play("death")


func use_item(item):
	var newItem = item.instance()
	newItem.add_to_group(str(newItem.get_name(), self))
	add_child(newItem)
	if get_tree().get_nodes_in_group(str(newItem.get_name(), self)).size() > newItem.max_amount:
		newItem.queue_free()
