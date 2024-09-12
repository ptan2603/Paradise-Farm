extends GridContainer

@onready var SlotButtons = [
	get_node("slot1"),
	get_node("slot2"),
	get_node("slot3"),
	get_node("slot4"),
	get_node("slot5"),
	get_node("slot6"),
	get_node("slot7"),
	get_node("slot8"),
	get_node("slot9"),
	get_node("slot10"),
	get_node("slot11"),
	get_node("slot12"),
	get_node("slot13"),
	get_node("slot14"),
	get_node("slot15"),
]

func setInventory():
	for i in Global.Harvests.size():
		if SlotButtons.size() >= Global.Harvests.size():
			if "corn" in Global.Harvests[i]["Name"]:
				SlotButtons[i].has_item = true
				SlotButtons[i].itemIcon = load("res://tilemap/Corn.png")
				SlotButtons[i].itemName = Global.Harvests[i]["Name"]
				SlotButtons[i].itemCount = Global.Harvests[i]["Count"]
			if "tomato" in Global.Harvests[i]["Name"]:
				SlotButtons[i].has_item = true
				SlotButtons[i].itemIcon = load("res://tilemap/Tomato.png")
				SlotButtons[i].itemName = Global.Harvests[i]["Name"]
				SlotButtons[i].itemCount = Global.Harvests[i]["Count"]
