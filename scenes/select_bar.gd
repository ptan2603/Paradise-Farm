extends Control

class_name SelectBar

# onready khai báo một biến sẽ được khởi tạo sau khi tất cả các nút đã được thêm vào cảnh.
# gán player là nút đầu tiên thuộc nhóm player trong cảnh.
@onready var player : Player = get_tree().get_first_node_in_group("player") 
@onready var Itembutton : Button = $GridContainer/ItemButton

# tạo biến hand_equip để lưu trữ một instance trong lớp HandEquip
var hand_equip : HandEquip

# khai báo một biến grid_container được ánh xạ tới GridContainer với tên cụ thể là $GridContainer
@onready var grid_container : GridContainer = $GridContainer

signal item_button_pressed(global_position)
# kiểm tra xem player có tồn tại không?

func _ready():
	# nếu có nó sẽ tìm kiếm một node con có tên "HandEquip" trong player và gán nó cho hand_equip.
	if(player):
		hand_equip = player.find_child("HandEquip")
		var first_button = true
		for button in grid_container.get_children():
			if(button is ItemButton):
				button.hand_equip = hand_equip
				button.connect("pressed", _on_item_button_pressed)
				if first_button:
					button.grab_focus()
					first_button = false

func _on_item_button_pressed():
	
	emit_signal("item_button_pressed", hand_equip.global_position)
	print("Global.selected:", Global.selected)
