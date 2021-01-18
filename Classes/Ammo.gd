extends Item

class_name Ammo

const type = "ammo"

var cal
var subtype =""
var amount = 0

func _init(ncal,nsubtype, namount):
	cal = ncal
	subtype = nsubtype
	amount = namount
	sprite = ItemStore.getAmmoSprite(cal,subtype)
	normal = ItemStore.getAmmoNormal(cal,subtype)

func _to_string():
	return "%s%s%s%d" % [cal, subtype,":" , amount]
