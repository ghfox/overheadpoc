extends Node

#Movement vars
var move = Vector2(0,0)
var joyMove = Vector2(0,0)
#Cursor vars
var cursorAngle = 0
var joyCursor = Vector2(0,0)
var mouseHasMoved = false
#state vars
var focusAbilityPressed = false

#Movement keybinds
var pressUp
var pressDown
var pressLeft
var pressRight
#state keybinds
var pressFocusAbility

#joy configs
var joyPort
var joyMoveDz
var joyCursorDz
#Movement joybinds
var joyMoveV
var joyMoveH
#Cursor joybinds
var joyCursorV
var joyCursorH
#state joybinds
var joyFocusAbility

func _ready():
	#we should check for a config file here.
	default()
	pass

#set default
func default():
	#Movement keybinds
	pressUp = KEY_W
	pressDown = KEY_S
	pressLeft = KEY_A
	pressRight = KEY_D
	#state keybinds
	pressFocusAbility = KEY_SHIFT
	#joy configs
	joyPort = 0      #these should be moved elsewhere
	joyMoveDz = 0.1
	joyCursorDz = 0.1
	#Movement joybinds
	joyMoveV = 1
	joyMoveH = 0
	#Cursor joybinds
	joyCursorV = 3
	joyCursorH = 2
	#state joybinds
	joyFocusAbility = 4
	
#Player called funcs

func getMove():
	joyMove.x = Input.get_joy_axis(joyPort,joyMoveH)
	joyMove.y = Input.get_joy_axis(joyPort,joyMoveV)
	move = Vector2(0,0)
	if(Input.is_key_pressed(pressUp)):
		move.y = -1.0
	elif(Input.is_key_pressed(pressDown)):
		move.y = 1.0
	if(Input.is_key_pressed(pressLeft)):
		move.x = -1.0
	elif(Input.is_key_pressed(pressRight)):
		move.x = 1.0
	if((abs(joyMove.x) + abs(joyMove.y)) > joyMoveDz):
		return joyMove
	return move.normalized()

#pass object position and viewport mouse coords
#returns relative angle of mouse or stick dependingf on mouseHasMoved flag
func getCursorAngle(position, mouse):
	joyCursor.x = Input.get_joy_axis(joyPort,joyCursorH)
	joyCursor.y = Input.get_joy_axis(joyPort,joyCursorV)
	if((abs(joyCursor.x) + abs(joyCursor.y)) > joyCursorDz):
		cursorAngle = joyCursor.angle()
		mouseHasMoved = false
	else:
		if(mouseHasMoved):
			cursorAngle = mouse.angle_to_point(position)
	return cursorAngle

#Event driven funcs
#note mouse move flag

func _input(event):
	if(!mouseHasMoved):
		mouseHasMoved = event is InputEventMouseMotion
	focusAbilityPressed = (Input.is_key_pressed(pressFocusAbility) || Input.is_joy_button_pressed(joyPort,joyFocusAbility))
