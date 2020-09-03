extends Reference

class_name Ammo

const type = "ammo"

var cal
var subtype =""
var amount = 0

func _init(ncal,nsubtype):
	cal = ncal
	subtype = nsubtype

func _to_string():
	return "%s%s%s%d" % [cal, subtype,":" , amount]
