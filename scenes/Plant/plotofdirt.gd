extends Area2D

var pumpkin = preload("res://scenes/Plant/seed.tscn")

var corn1 = preload("res://scenes/Object/Pickups/pickup_corn.tscn")
# nạp trước tệp cảnh (scene) của cây cà chua (tomato) và gán nó vào biến hằng số tomato
var tomato = preload("res://scenes/Object/Pickups/pickup_tomato.tscn")
# Khai báo một biến has_seed để theo dõi xem vị trí này đã có hạt giống được trồng hay chưa
var has_seed = false

# bất cứ khi nào có sự kiện đầu vào (như nhấp chuột), hàm _on_input_event sẽ được gọi.
func _on_input_event(viewport, event, shape_idx):
	# nếu chưa có hạt giống
	if !has_seed:
		# sự kiện nhấp chuột
		if event.is_action_pressed("click"):
			match Global.selected:
				4:
					var plant1 = corn1.instantiate()
					self.add_child(plant1)
					has_seed = true
				5:
					var plant1 = tomato.instantiate()
					self.add_child(plant1)
					has_seed = true


