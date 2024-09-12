extends Node2D

var dragging = false
var click_radius = 40  # Size of the sprite.
var posClicked

var ButtonInfo = {
	"Name": "corn",
	"Count": 0,
}

@onready var gridContainer = get_node("GridContainer")
@onready var SlotButtons = [
	get_node("GridContainer/slot1"),
	get_node("GridContainer/slot2"),
	get_node("GridContainer/slot3"),
	get_node("GridContainer/slot4"),
	get_node("GridContainer/slot5"),
	get_node("GridContainer/slot6"),
	get_node("GridContainer/slot7"),
	get_node("GridContainer/slot8"),
	get_node("GridContainer/slot9"),
	get_node("GridContainer/slot10"),
	get_node("GridContainer/slot11"),
	get_node("GridContainer/slot12"),
	get_node("GridContainer/slot13"),
	get_node("GridContainer/slot14"),
	get_node("GridContainer/slot15"),

]
func _ready():
	self.hide()
	
func _input(event):
	if event.is_action_pressed("Inventory"):
		if self.visible == true:
			self.hide()
		else: 
			self.show()
			get_node("GridContainer").setInventory()

func _on_slot_gui_input(event, extra_arg_0):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if (event.position.length()) < click_radius:
			if not dragging and event.pressed:
				if gridContainer.get_child(extra_arg_0).has_item == true:
					dragging = true
					posClicked = gridContainer.get_child(extra_arg_0).position.x
					ButtonInfo["Name"] = gridContainer.get_child(extra_arg_0).itemName
					ButtonInfo["Count"] = gridContainer.get_child(extra_arg_0).itemCount
					gridContainer.get_child(extra_arg_0).itemCount = 0
					gridContainer.get_child(extra_arg_0).itemName = ""
					gridContainer.get_child(extra_arg_0).has_item = false
		if dragging and not event.pressed: #Stop dragging if the button is released
			dragging = false
			gridContainer.get_child(extra_arg_0).get_node("Item").position = Vector2(20,20)
			get_node("Sprite2D").hide()
			for i in SlotButtons.size():
				if (get_global_mouse_position() >= gridContainer.get_child(i).position + Vector2(120,72) && get_global_mouse_position() < gridContainer.get_child(i).position + Vector2(160,111)):
					if gridContainer.get_child(i).has_item == false:
						gridContainer.get_child(i).has_item = true
						gridContainer.get_child(i).itemName = ButtonInfo["Name"]
						gridContainer.get_child(i).itemCount = ButtonInfo["Count"]
						
	if event is InputEventMouseMotion and dragging:
		get_node("Sprite2D").show()
		get_node("Sprite2D").texture = gridContainer.get_child(extra_arg_0).get_node("Item").texture
		get_node("Sprite2D").position = get_global_mouse_position()
