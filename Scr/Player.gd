extends KinematicBody2D

var move = Vector2(0,0)
var playerBullet = preload("res://Scn/PlayerBullet.tscn")

var attackCooldown
var attackDamage
var attackMuzzle

var focusAbilityPressed = false

func _ready():
	equipPistol("PeaShooter")

func _process(_delta):
	rotation = Controller.getCursorAngle(get_global_position(),get_global_mouse_position())
	move = Controller.getMove() * (StatStore.MAX_SPEED)
	move_and_slide(move)
	if(focusAbilityPressed):
		Engine.time_scale = 0.5
	else:
		Engine.time_scale = 1
	if(Input.get_action_strength(Controller.actionAttack) > 0.5):
		attack()

func attack():
	if($Shottimer.time_left == 0):
		$Shottimer.start(attackCooldown)
		var newBullet = playerBullet.instance()
		newBullet.position = position + (Vector2(cos(rotation),sin(rotation)) * 32 )
		newBullet.DIR = rotation
		newBullet.DAM = attackDamage
		newBullet.SPEED = attackMuzzle
		get_parent().add_child_below_node(self,newBullet)

func _input(_event):
	focusAbilityPressed = (Input.get_action_strength(Controller.actionFocusAbility) > 0.5)

func equipPistol(pistol):
	var p = WeaponStore.p[pistol]
	attackCooldown = p["cooldown"] - (StatStore.SK_PISTOL/10.0)
	attackDamage = p["damage"]
	attackMuzzle = p["muzzle"]
	pass
