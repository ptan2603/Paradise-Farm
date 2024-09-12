extends Resource
class_name SlotData

@export var item_data : ResourceItem
@export var quantity : int = 0 : set = set_quantity

func set_quantity(value : int):
	quantity = value
	if quantity <1:
		emit_changed()
