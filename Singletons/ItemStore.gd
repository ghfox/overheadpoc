extends Node

var res = "res://Spr/Items/"

var w = {
	"PeaShooter" : {
		"name" : "PeaShooter",
		"cat" : "pistol",
		"cal" : "9mm",
		"cooldown" : 0.6,
		"dam" : 50,
		"topoff" : false,
		"spd" : 850
	}
}

var m = {
	"9mm 10rd Mag" : {
		"cal" : "9mm",
		"cap" : 10
	}
}

func getAmmoSprite(cal,subtype):
	var sprite = "%s%s" % [res,b[cal][subtype]["sprite"]]
	return sprite

func getAmmoNormal(cal,subtype):
	var normal = "%s%s" % [res, "boxNormal.png"]
	return normal

var b = {
	"9mm" : {
		"fmj" : {
			"dam" : 1,
			"pen" : 40,
			"spd" : 50,
			"sprite" : "9mmfmjbox.png",
		}, 
		"hp" : {
			"dam" : 45,
			"pen" : 20,
			"spd" : 1
		},
		 "fluted" : {
			"dam" : 35,
			"pen" : 30,
			"spd" : 50
		}
	} 
}
