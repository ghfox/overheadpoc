extends Area2D

class_name ItemPickup

var item

func _init(newItem):
	item = newItem
	rotation = (randi() % 60) / 10.0
	pass

func _ready():
	var collider = CollisionShape2D.new()
	var circ = CircleShape2D.new()
	circ.set_radius(item.radius)
	collider.set_shape(circ)
	add_child(collider)
	var spr = Sprite.new()
	spr.set_texture(load(item.sprite))
	spr.normal_map = load("res://Spr/Items/boxNormal.png")
	add_child(spr)
	pass
