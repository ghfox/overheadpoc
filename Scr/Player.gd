extends KinematicBody2D

var move = Vector2(0,0)
var playerBullet = preload("res://Scn/PlayerBullet.tscn")
var reloadAnim = preload("res://Scn/ReloadAnim.tscn")

var focusAbilityPressed = false

func _ready():
	Inventory.player = self
	print(Inventory.pack)
	print(Inventory.pocket)
	print(Inventory.hand)

func _process(_delta):
	rotation = Controller.getCursorAngle(get_global_position(),get_global_mouse_position())
	move = Controller.getMove() * (StatStore.MAX_SPEED)
	move_and_slide(move)
	if(Input.get_action_strength(Controller.actionAttack) > 0.5):
		attack()

func attack():
	if($Shottimer.time_left == 0):
		var hand = Inventory.hand
		if(hand.type == "weapon"):
			if(hand.cat == "pistol"):
				$Shottimer.start(hand.cooldown)
				var newBullet = playerBullet.instance()
				newBullet.position = position + (Vector2(cos(rotation),sin(rotation)) * 32 )
				newBullet.DIR = rotation
				newBullet.DAM = hand.dam
				newBullet.SPEED = hand.muzzle
				get_parent().add_child_below_node(self,newBullet)

func _input(_event):
	if(Input.is_action_just_pressed(Controller.actionFocusAbility)):
		focusActive()
	elif(Input.is_action_just_released(Controller.actionFocusAbility)):
		focusInactive()
	elif(Input.is_action_just_pressed(Controller.actionReload)):
		reload()

func reload():
	print("reload")
	var reload = reloadAnim.instance()
	get_parent().get_node("LayerUnMod").add_child(reload)

func focusActive():
	Engine.time_scale = 0.5
	AudioManager.repitch()

func focusInactive():
	Engine.time_scale = 1.0
	AudioManager.repitch()
