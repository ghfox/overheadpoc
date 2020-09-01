extends KinematicBody2D

var move = Vector2(0,0)
var playerBullet = preload("res://Scn/PlayerBullet.tscn")

var focusAbilityPressed = false

#func _ready():

func _process(_delta):
	rotation = Controller.getCursorAngle(get_global_position(),get_global_mouse_position())
	move = Controller.getMove() * (250)
	move_and_slide(move)
	if(focusAbilityPressed):
		Engine.time_scale = 0.5
	else:
		Engine.time_scale = 1
	if(Input.get_action_strength(Controller.actionAttack) > 0.5):
		attack()

func attack():
	if($Shottimer.time_left == 0):
		$Shottimer.start(0.5)
		var newBullet = playerBullet.instance()
		newBullet.position = position + (Vector2(cos(rotation),sin(rotation)) * 32 )
		newBullet.DIR = rotation
		get_parent().add_child_below_node(self,newBullet)

func _input(event):
	focusAbilityPressed = (Input.get_action_strength(Controller.actionFocusAbility) > 0.5)
