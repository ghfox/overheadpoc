extends Item

class_name Weapon

const type ="weapon"

var name
var curMag

var cat

var cal
var cooldown
var dam
var topoff
var muzzle

func _init(nname):
	name = nname
	baseStats()
	curMag = null

func baseStats():
	var tDict = ItemStore.w[name]
	cat = tDict["cat"]
	cal = tDict["cal"]
	cooldown = tDict["cooldown"]
	dam = tDict["dam"]
	muzzle = tDict["spd"]

func baseAmmo():
	baseStats()
	var tDict = ItemStore.b[cal][curMag.subtype]
	dam += tDict["dam"]
	muzzle += tDict["spd"]

func fire():
	if(curMag.store > 0):
		curMag.store -= 1
		return true
	return false

func addMag(mag):
	if(mag.cal == cal):
		curMag = mag
		baseAmmo()
		return true
	return false
	
func _to_string():
	if(curMag != null):
		return "%s%s%s" % [name , ":" , curMag] 
	return name
