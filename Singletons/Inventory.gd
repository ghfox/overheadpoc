extends Node

var Ammo = preload("res://Classes/Ammo.gd")
var Magazine = preload("res://Classes/Magazine.gd")
var Weapon = preload("res://Classes/Weapon.gd")
var Nothing = preload("res://Classes/Nothing.gd")

var pack = {}
var pocket = [Nothing.new(),Nothing.new(),Nothing.new(),Nothing.new()]
var hand = Nothing.new()

#remember all built-in types are passed as value, EXCEPT arrays & dicts

func _ready():
	pack = {
		"weapon" : [Weapon.new("PeaShooter")],
		"mag" : [Magazine.new("9mm",10),Magazine.new("9mm",10)],
		"ammo" : [Ammo.new("9mm","fmj")]
	}
	pack["ammo"][0].amount += 15
	pack["mag"][0].fillMag(pack["ammo"][0])
	pack["mag"][1].fillMag(pack["ammo"][0])
	moveToPocket(pack["mag"][0],0)
	loadFromPocket(pack["weapon"][0],0)
	equip(pack["weapon"],0)
	

func equip(group, idx):
	hand = group[0]
	group.remove(idx)

func loadFromPocket(weapon, pockIdx):
	var obj = pocket[pockIdx]
	if(weapon.addMag(obj)):
		pocket[pockIdx] = Nothing.new()

func moveToPocket(item, pockIdx):
	if(pocket[pockIdx].type != "null"):
		pack[pocket[pockIdx].type].append(pocket[pockIdx])
	pocket[pockIdx] = item
	pack[item.type].remove(pack[item.type].find(item,0))

