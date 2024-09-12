extends Node2D

const SlotClass = preload("res://scenes/Slot1.gd")
@onready var inventory_slots = $GridContainer
var holding_item = null


func _process(delta):
	if Input.is_action_pressed("click"):
		for inv_slot in inventory_slots.get_children():
			if inv_slot.get_global_rect().has_point(get_global_mouse_position()):
				handle_slot_click(inv_slot)

func handle_slot_click(slot: SlotClass):
	if holding_item != null:
		if !slot.item:
			slot.putIntoSlot(holding_item)
			holding_item = null
		else:
			var temp_item = slot.item
			slot.pickFromSlot()
			temp_item.global_position = get_global_mouse_position()
			slot.putIntoSlot(holding_item)
			holding_item = temp_item
	elif slot.item:
		holding_item = slot.item
		slot.pickFromSlot()
		holding_item.global_position = get_global_mouse_position()

func _input(event):
	if holding_item:
		holding_item.global_position = get_global_mouse_position()
