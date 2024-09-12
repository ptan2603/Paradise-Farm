extends StaticBody2D

@onready var label = $pricelabel
@onready var sell_button = $SellButtoncolor

# khởi tạo biến với giá trị 1, đại diện cho mặt hàng hiện tại được chọn
var item = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	$icon.play("cornseed")
	item = 1
	sell_button.connect("player_sell_method", _on_sell_button_pressed)
	

func _on_sell_button_pressed():
	sell_harvests()
	
func sell_harvests():
		var coins = Global.coins
		if item == 1:  # Assuming item 1 is corn
			$icon.play("cornseed")
			label.text = "5"
			for harvest in Global.Harvests:
				if harvest["Name"] == "corn":
					coins += harvest["Count"] * 5
					harvest["Count"] = 0  # Reset corn count
		elif item == 2:  # Assuming item 2 is tomato
			$icon.play("randomseed")
			label.text = "8"
			for harvest in Global.Harvests:
				if harvest["Name"] == "tomato":
					coins += harvest["Count"] * 8
					harvest["Count"] = 0  # Reset tomato count
		# Update global coins
		Global.coins = coins

func _on_buttonleft_pressed():
	swap_item_back()
	
func _on_buttonright_pressed():
	swap_item_forward()

func swap_item_back():
	if item == 1:
		item = 2 
	elif item == 2:
		item = 1

func swap_item_forward():
	if item == 1:
		item = 2
	elif item == 2:
		item = 1 
