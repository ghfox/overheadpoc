extends Item

class_name Magazine

const type = "mag"

var cal
var cap
var subtype =""
var store = 0

func _init(ncal,ncap):
	cal = ncal
	cap = ncap

func fillMag(ammo):
	subtype = ammo.subtype
	store = ammo.amount
	ammo.amount -= cap
	if(ammo.amount < 0):
		ammo.amount = 0
	else:
		store -= ammo.amount

func _to_string():
	return "%s%s%d%s%s%d" % [cal, " Mag: ", store, subtype, "/", cap]
