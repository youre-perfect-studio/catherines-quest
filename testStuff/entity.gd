extends KinematicBody2D

export(String) var type = "enemy"
export(String) var subType

var chasing = false
var damage = 1
var hasAmulet = false
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
	match movedir:
		Vector2(-1,0):
			spritedir = "left"
		Vector2(1,0):
			spritedir = "right"
		Vector2(0,-1):
			spritedir = "up"
		Vector2(0,1):
			spritedir = "down"

func anim_switch(action):
	$Anim.play(action+spritedir)   
	
func damageLoop():
	if hitstun > 0:
		hitstun -= 1
	for area in $DamageArea.get_overlapping_areas():
		var body = area.get_parent()
		if hasAmulet == false && hitstun == 0 && body.get("damage") != null && body.get("type") != type && visible == true && area.name=="bitebox":
			health -= body.get("damage")
			print("lost " + str(body.get("damage")) + "health")
			hitstun = 10
	if health <= 0:
		if visible == true:
			print("dead") 
		visible = false
		#$Anim.play("death")