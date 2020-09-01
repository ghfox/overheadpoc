extends KinematicBody2D

export var SPEED = 850
export var DAM = 100
export var DIR = 360
export var LIFESPAN = 0.5
var velocity = Vector2(0,0)

func _ready():
	velocity = Vector2(cos(DIR),sin(DIR)) * SPEED
	$Timer.start(LIFESPAN)

func _process(delta):
	move_and_collide(velocity * delta)

func _on_Timer_timeout():
	get_parent().remove_child(self)