extends "res://testStuff/entity.gd"

#plan on making hitbox more defined once actual dragon art created, along with anything else
# Vector2 Room Size (960, 540)

onready var player = get_node("../player")
onready var bitebox =  get_node("../dragon/bitebox")
onready var dragonAttract = get_node("../bait/dragonAttract")
onready var cam = get_node("../cam")

var moveTimerLength
var moveTimer = 0
var baitChase = false

func _ready():
	moveTimerLength = randi() % 800 + 100
	moveTimer = moveTimerLength
	$bitebox.connect("area_entered", self, "onAreaEntered")
	
func _physics_process(delta):
	movementLoop()
	if chasing == false:
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
		movedir = (dragonAttract.global_position - bitebox.global_position).normalized()
	else:
			movedir = (player.global_position - bitebox.global_position).normalized()
		
		
		#unless there is a specific plan for below, it's useless now with DamageLoop() in place
func onAreaEntered(area):
	if area.get_parent().get("type") == "player":
		if area.get_parent().get("hasAmulet") == false:
			pass
			#player.set_physics_process(false)
			#player.set_visible(false)