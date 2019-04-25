extends "res://engine/entity.gd"
class_name Player

var state = "default"
var useItem = "none"

var has_spoken_to_catherine:bool = false
var has_accepted_quest:bool = false
var has_seen_a_dragon:bool = false
onready var catherine_node = $"/root/Node/Catherine"
onready var catherine_talk_area = $"/root/Node/Catherine/talkZone"

func ready():
	assert(catherine_node != null)
	var camItemUI = get_node("../cam/useItem")
#	$DamageArea.connect("area_entered", self, "onAreaEntered")
#	$DamageArea.connect("area_exited", self, "onAreaExited")
	
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
		if $DamageArea.overlaps_area(catherine_talk_area):
			talk_to_npc("Catherine")
	
	if Input.is_action_just_pressed("attack"):
		print("triggered")
		match useItem:
			"none":
				for area in $DamageArea.get_overlapping_areas():
					if area.get_parent().get("type") == "item" && area.name == "hitbox":
						get_node("../cam/useItem").texture = load("res://items/" + area.get_parent().name + ".png")
					else:
						pass
			"sword":
				use_item(preload("res://items/sword.tscn"))
		
	
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

func get_amulet():
	hasAmulet = true 
	
func talk_to_npc( npc_name:String ):
	match npc_name:
		"Catherine":
			catherine_node.begin_dialog(self)
		"Roux":
			pass