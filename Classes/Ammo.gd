extends Reference

class_name Ammo

var type
var subtype =""
var amount = 0

func _init(ntype,nsubtype):
	type = ntype
	subtype = nsubtype

func _to_string():
	return "%s%s%s%d" % [type, subtype,":" , amount]
