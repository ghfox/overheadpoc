extends Node

var pack = {}
var pocket = [Nothing.new(),Nothing.new(),Nothing.new(),Nothing.new()]
var hand = Nothing.new()
var player
var selectedPocket = 0

var reloadCursor = -1

#remember all built-in types are passed as value, EXCEPT arrays & dicts

func _ready():
	pack = {
		Weapon.type : [Weapon.new("PeaShooter")],
		Magazine.type : [Magazine.new("9mm 10rd Mag"),Magazine.new("9mm 10rd Mag"),Magazine.new("9mm 10rd Mag")],
		Ammo.type : [Ammo.new("9mm","fmj",25)]
	}
	pack["mag"][0].fillMag(pack["ammo"][0])
	pack["mag"][2].fillMag(pack["ammo"][0])
	pack["mag"][1].fillMag(pack["ammo"][0])
	moveToPocketFromPack(pack["mag"][0],0)
	loadFromPocket(pack["weapon"][0],0)
	moveToPocketFromPack(pack["mag"][0],0)
	moveToPocketFromPack(pack["mag"][0],1)
	equip(pack["weapon"],0)
	
func nextPocket():
	selectedPocket += 1
	if(selectedPocket == pocket.size()):
		selectedPocket = 0

func equip(group, idx):
	hand = group[idx]
	group.remove(idx)
	reloadCursor = -1

func addToPack(item):
	pack[item.type].push_back(item)

func moveToPocketFromPack(item, pockIdx):
	if(pocket[pockIdx].type != "null"):
		pack[pocket[pockIdx].type].append(pocket[pockIdx])
	pocket[pockIdx] = item
	pack[item.type].remove(pack[item.type].find(item,0))

func moveToPocket(item, pockIdx):
	if(pocket[pockIdx].type != "null"):
		return false
	pocket[pockIdx] = item

func findEmptyPocket():
	var found = -1
	for p in pocket:
		found += 1
		if(p.type == Nothing.type):
			return found
	return -1


#														MAGAZINE RELATED Methods
func swapForNextMag():
	var temp = hand.curMag
	loadNextMag()
	moveToPocket(temp,reloadCursor)

func loadNextMag():
	return loadFromPocket(hand,reloadCursor)

func findNextMag():
	for i in pocket.size():
		reloadCursor += 1
		if(reloadCursor == pocket.size()):
			reloadCursor = 0
		var p = pocket[reloadCursor]
		if(p.type == "mag"):
			if(p.cal == hand.cal):
				if(p.store > 0):
					return true
	return false

func loadFromPocket(weapon, pockIdx):
	var obj = pocket[pockIdx]
	if(weapon.addMag(obj)):
		pocket[pockIdx] = Nothing.new()
		return true
	return false
