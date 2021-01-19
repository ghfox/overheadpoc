extends Control

var pocket_art = "res://Spr/Gui/gui_pocket.png"

func _ready():
	updatePocketGrid()
	pass

func updatePocketGrid():
	for p in Inventory.pocket:
		var newpocket = TextureRect.new()
		newpocket.set_texture(load(pocket_art))
		newpocket.set_stretch_mode(TextureRect.STRETCH_KEEP_ASPECT)
		newpocket.set_v_size_flags(Control.SIZE_EXPAND_FILL)
		newpocket.set_h_size_flags(Control.SIZE_EXPAND_FILL)
		get_node("PocketGrid").add_child(newpocket)
		if(p.type != Nothing.type):
			var newItem = TextureRect.new()
			newItem.set_texture(load(p.sprite))
			newItem.set_stretch_mode(TextureRect.STRETCH_KEEP_ASPECT)
			newItem.set_v_size_flags(Control.SIZE_EXPAND_FILL)
			newItem.set_h_size_flags(Control.SIZE_EXPAND_FILL)
			get_node("Inventory").add_child(newItem)
