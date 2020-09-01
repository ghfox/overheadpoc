extends KinematicBody2D

var move = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	rotation = Controller.getCursorAngle(get_global_position(),get_global_mouse_position())
	move = Controller.getMove() * 320
	move_and_slide(move)
	if(Controller.focusAbilityPressed):
		Engine.time_scale = 0.5
	else:
		Engine.time_scale = 1
	pass
	
