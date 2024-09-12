extends Panel

var default_tex = preload("res://tilemap/inventory/Inventory_Slot.png")
var empty_tex = preload("res://tilemap/inventory/item_slot.png")

var defaut_style: StyleBoxTexture = null
var empty_style: StyleBoxTexture = null

var ItemClass
var item = null

func _ready():
	defaut_style = StyleBoxTexture.new()
	empty_style = StyleBoxTexture.new()
	
	defaut_style.texture = default_tex
	empty_style.texture = empty_tex
	
	if randi() % 2 == 0:
		item = ItemClass.instantiate()
		add_child(item)
	refresh_style()
		
func refresh_style():
	if item == null:
		set("custom_styles/panel", empty_style)
	else:
		set("custom_styles/panel", defaut_style)

func pickFromSlot():
	remove_child(item)
	var inventoryNode = find_parent("inventory_2")
	if inventoryNode != null:
		inventoryNode.add_child(item)
	item = null
	refresh_style()

func putIntoSlot(new_item):
	item = new_item
	item.position = Vector2(0, 0)
	var inventoryNode = find_parent("inventory_2")
	if inventoryNode != null:
		inventoryNode.remove_child(item)
	add_child(item)
	refresh_style()
