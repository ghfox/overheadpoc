extends Node

var Ammo = preload("res://Classes/Ammo.gd")
var Magazine = preload("res://Classes/Magazine.gd")

var pack = {}
var pocket = [4]

#remember all built-in types are passed as value, EXCEPT arrays & dicts

func _ready():
	pack = {
		"weapons" : ["PeaShooter"],
		"mags" : [Magazine.new("9mm",10),Magazine.new("9mm",10)],
		"ammo" : [Ammo.new("9mm","fmj")]
	}
	pack["ammo"][0].amount += 30
	fillMag(pack["ammo"][0], 0)
	pass

func fillMag(ammo, magIdx):
	var mag = pack["mags"][magIdx]
	mag.store = ammo.amount
	ammo.amount -= mag.cap
	if(ammo.amount < 0):
		ammo.amount = 0
	else:
		mag.store -= ammo.amount
	pass
