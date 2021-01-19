extends Control

var pocketArt = "res://Spr/Gui/gui_pocket.png"
var pocketMargin = 65
var pocketWidth = 60
var pocketSelWidth = 74
var oldSelIdx = 0

func _ready():
	updatePocketGrid()
	updateSelectedPocket()
	pass

func updatePocketGrid():
	var margin = 0
	for p in Inventory.pocket:
		makePocketPart(pocketArt,"PocketGrid",margin)
		if(p.type != Nothing.type):
			makePocketPart(p.sprite, "Inventory", margin)
		margin += pocketMargin

func sizeItem(bound, item):
	var rect = item.get_rect()
	var maxside = max(rect.size.x,rect.size.y)
	var scale = bound/maxside
	item.set_stretch_mode(TextureRect.STRETCH_KEEP_ASPECT)
	item.set_scale(Vector2(scale,scale))

func makePocketPart(texture,destNode, x):
	var newItem = TextureRect.new()
	newItem.set_texture(load(texture))
	newItem.set_margin(MARGIN_LEFT,x)
	sizeItem(pocketWidth,newItem)
	get_node(destNode).add_child(newItem)

func updateSelectedPocket():
	var n = get_node("PocketGrid")
	sizeItem(pocketWidth,n.get_child(oldSelIdx))
	sizeItem(pocketSelWidth,n.get_child(Inventory.selectedPocket))
	n = get_node("Inventory")
	if(Inventory.pocket[oldSelIdx].type != Nothing.type):
		sizeItem(pocketWidth,n.get_child(oldSelIdx))
	if(Inventory.pocket[Inventory.selectedPocket].type != Nothing.type):
		sizeItem(pocketSelWidth,n.get_child(Inventory.selectedPocket))
	oldSelIdx = Inventory.selectedPocket