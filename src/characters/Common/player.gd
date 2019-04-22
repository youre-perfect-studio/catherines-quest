extends "res://engine/entity.gd"

var state = "default"

var useItem = "none"

func ready():
	var camItemUI = get_node("../cam/area/useItem")
	
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
		
	if Input.is_action_just_pressed("attack"):
		match useItem:
			"none":
				if $DamageArea.overlaps_area(get("type") == "item") == true:
					$camItemUI.texture = "res://items/" + name + ".png"
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
