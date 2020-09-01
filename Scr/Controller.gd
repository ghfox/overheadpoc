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
var actionFocusAbility = "focus_ability"
var attackPressed = false
var actionAttack = "attack"

#Movement keybinds
var pressUp
var pressDown
var pressLeft
var pressRight

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

func _ready():
	InputMap.add_action(actionFocusAbility)
	InputMap.add_action(actionAttack)
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
	
	#state action binds
	InputMap.action_erase_events(actionFocusAbility)
	InputMap.action_add_event(actionFocusAbility,create_key_event(KEY_SHIFT))
	InputMap.action_add_event(actionFocusAbility,create_joy_event(4))
	InputMap.action_erase_events(actionAttack)
	InputMap.action_add_event(actionAttack,create_mouse_event(BUTTON_LEFT))
	InputMap.action_add_event(actionAttack,create_axis_event(7))

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
	focusAbilityPressed = Input.get_action_strength(actionFocusAbility) > 0.5
	attackPressed = Input.get_action_strength(actionAttack) > 0.5

#helpers

func create_key_event(key):
	var ev = InputEventKey.new()
	ev.scancode = key
	return ev

func create_mouse_event(button):
	var ev = InputEventMouseButton.new()
	ev.button_index = button
	return ev

func create_joy_event(button):
	var ev = InputEventJoypadButton.new()
	ev.button_index = button
	ev.device = joyPort
	return ev

func create_axis_event(axis):
	var ev = InputEventJoypadMotion.new()
	ev.axis = axis
	ev.device = joyPort
	return ev
