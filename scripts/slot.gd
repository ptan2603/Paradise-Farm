extends TextureButton


var has_item = false
var itemIcon = preload("res://tilemap/Inventory_background.png")
var itemName = ""
var itemCount = 0

func _process(delta):
	if itemCount == 0:
		get_node("Item").hide()
		get_node("Count").hide()
	else:
		get_node("Count").show()
		get_node("Count").text = str(itemCount)
	
	if has_item == true:
		match itemName:
			"corn":
				itemIcon = load("res://tilemap/plants/Corn.png")
			"tomato":
				itemIcon = load("res://tilemap/plants/Tomato.png")
		get_node("Item").texture = itemIcon
		get_node("Item").show()
	else:
		get_node("Item").hide()
		

func play_flash_animation()-> void:
	$AnimationPlayer.play("flash")
