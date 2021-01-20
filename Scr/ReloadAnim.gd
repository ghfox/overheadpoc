extends Node2D

var segs = 16.0
var pointsArcOuter = PoolVector2Array()
var pointsArcInner = []
var time = 2.5
var complete = 0
var incolor = Color.yellow
var swap = true
var skipTo = 0.66

#couples hard with player

func _ready():
	$Timer.start(time)
	var center = Vector2(0,0)
	for i in range(segs+1):
		var angle_point = deg2rad(i * 360 / (segs) - 90)
		pointsArcOuter.insert(i, center + Vector2(cos(angle_point), sin(angle_point)) * 50)
		pointsArcOuter.insert(i+1, center + Vector2(cos(angle_point), sin(angle_point)) * 60)
		pointsArcInner.insert(i, center + Vector2(cos(angle_point), sin(angle_point)) * 53)
		pointsArcInner.insert(i+1, center + Vector2(cos(angle_point), sin(angle_point)) * 57)

func _draw():
	drawCoord(Color.red, pointsArcOuter)
	if(complete >= 1):
		drawCoord(incolor, PoolVector2Array(
			pointsArcInner.slice(0,complete)+pointsArcInner.slice(
				pointsArcInner.size()-complete-1,pointsArcInner.size()-1
				)
		))

func drawCoord(color, segpointsarr):
	var colors = PoolColorArray([color])
	draw_polygon(segpointsarr, colors)

func _process(_delta):
	position = Inventory.player.position
	complete = int(((time - $Timer.time_left) / time) * segs)
	if(segs != complete):
		if(complete > segs/2):
			incolor = Color.black
		update()
	else:
		reload()

func reload():
	if(swap):
		Inventory.swapForNextMag()
	else:
		Inventory.loadNextMag()
	Inventory.player.reloading = false
	Inventory.player.HUD.updatePocketGrid()
	call_deferred("free")

func skip():
	if($Timer.time_left/time > skipTo):
		$Timer.start((1.0-skipTo) * time)
		swap = false
