# khai báo script được kế thừa lớp Node2D
extends Node2D

# khởi tạo các giá trị ban đầu cho đối tượng.
func _ready():
	pass

# hàm sự kiện nhấn nút
func _on_button_pressed():
	# thay đổi cảnh hiện tại sang cảnh chỉ định
	get_tree().change_scene_to_file("res://world.tscn")
