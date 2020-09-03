extends KinematicBody2D

var SPEED = 850
var DAM = 100
var DIR = 360
var LIFESPAN = 0.5
var velocity = Vector2(0,0)

func _ready():
	rotation = DIR
	velocity = Vector2(cos(DIR),sin(DIR)) * SPEED
	$Timer.start(LIFESPAN)
	if(randi() % 2 == 1):
		AudioManager.play(AudioManager.gunshot1)
	else:
		AudioManager.play(AudioManager.gunshot2)
func _physics_process(delta):
	move_and_collide(velocity * delta)

func _on_Timer_timeout():
	get_parent().remove_child(self)
