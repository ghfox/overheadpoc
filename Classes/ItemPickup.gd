extends Area2D

class_name ItemPickup

var item
var spr

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
	spr = Sprite.new()
	spr.set_texture(load(item.sprite))
	spr.normal_map = load(item.normal)
	add_child(spr)
	set_name("%s%s" % ["ItemPickup-",item])
	add_to_group("Grabables", false)
	pass

func turnOnOutline():
	spr.set_material(load("res://Shaders/outline.tres"))

func turnOffOutline():
	spr.set_material(null)
