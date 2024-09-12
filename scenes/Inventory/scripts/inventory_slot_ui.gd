extends Button
class_name InventorySlotUI

var slot_data: SlotData: set = set_slot_data

@onready var texture_rect: TextureRect = $TextureRect
@onready var label: Label = $Label

func _ready():
	texture_rect.texture = null
	label.text = ""

# Called every frame. 'delta' is the elapsed time since the previous frame.
func set_slot_data(value : SlotData):
	slot_data = value
	if slot_data == null:
		return
	texture_rect.texture = slot_data.item_data.texture
	label.text = str(slot_data.quantity)
