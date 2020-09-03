extends Reference

class_name Magazine

var type
var cap
var subtype =""
var store = 0

func _init(ntype,ncap):
	type = ntype
	cap = ncap

func _to_string():
	return "%s%s%d%s%d" % [type, " Mag: ", store, "/" , cap]
