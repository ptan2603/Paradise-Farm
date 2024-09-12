extends Node2D
class_name Pickup_corn

# biến thiết lập từ trình chỉnh sửa của Godot.
@export var item_data : ResourceItem : set = _set_item_data

# tham chiếu timer
@onready var timer = $Timer
#tham chiếu sprite
@onready var plant = $Sprite
@onready var area_2d: Area2D = $Area2D
@onready var audio_steam_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

# khai báo biến giai đoạn của cây
var stage = 1

# khai báo biến lưu trữ thời gian tùy chỉnh của cây
var time = 0.0
# lưu chỉ số của cây
var PlantNum = -1

func _ready():
	# Nếu time khác 0, đặt thời gian chờ của timer bằng giá trị của time.
	if time != 0:
		timer.wait_time = time
	# Nếu PlantNum bằng -1, gán nó bằng kích thước của mảng Global.Plot.
	if PlantNum == -1:
		PlantNum = Global.Plot.size()
	# Thêm một đối tượng vào Plot với các thuộc tính như sau.
	Global.Plot += [{
		"Seed": "corn",
		"Time": timer.time_left,
		"Stage": stage,
		"Harvested": false,
	}]
	 
	# cập nhật hình ảnh của cây dựa trên dữ liệu item
	_update_texture()
	
	# Nếu đang chạy trong trình chỉnh sửa, không thực hiện thêm hành động nào.
	if Engine.is_editor_hint():
		pass
	# Kết nối tín hiệu body_entered với hàm _on_body_entered
	area_2d.body_entered.connect(_on_body_entered)
	pass

# cập nhật trạng thái của cây
func _process(delta):
# Cập nhật thời gian còn lại của cây trong Global.Plot.
	Global.Plot[PlantNum]["Time"] = timer.time_left
	# Sử dụng cấu trúc match để gán giá trị khung hình (frame) của sprite plant dựa trên giai đoạn (stage).
	match stage:
		1: 
			plant.frame = stage
		2: 
			plant.frame = stage
		3: 
			plant.frame = stage
		4: 
			plant.frame = stage
		5: 
			plant.frame = stage
		6:
			plant.frame = 5

# Hàm này được gọi khi timer hết thời gian.
func _on_timer_timeout():
	# nhỏ hơn hoặc bằng 5, tăng stage lên 1.
	if stage <= 5:
		stage += 1
	# Cập nhật giai đoạn của cây trong Global.Plot.
	Global.Plot[PlantNum]["Stage"] = stage

# hàm gọi khi đối tượng va chạm vào vùng cây
func _on_body_entered(b):
	if stage >= 5:
		# nếu đối tượng va chạm là player
		if b is Player:
			# nếu có dữ liệu item, thêm item vào kho của người chơi.
			if item_data:
				if PlayerManager.INVENTORY_DATA.add_item(item_data) == true:
					# gọi hàm 
					item_picked_up()
	pass
# hàm được gọi khi item được thu hoạch
func item_picked_up():
	# kiểm tra item đã có trong danh sách Global.harvests chưa 
	var has_item = false
	
	# ngắt tín hiệu không cho hàm _on_body_entered gọi thêm nữa khi được thu hoạch
	area_2d.body_entered.disconnect(_on_body_entered)
	# phát âm thanh thu hoạch
	audio_steam_player_2d.play()
	# ẩn item
	visible = false
	
	# cho phép mã dừng lại khi âm thanh hoàn tất 
	await audio_steam_player_2d.finished
	
	for i in Global.Harvests.size():
		if "corn" in Global.Harvests[i]["Name"]:
			has_item = true
			# Nếu người chơi đã có "corn", tăng số lượng "corn" lên 1.
	if has_item:
		for i in Global.Harvests.size():
			if "corn" == Global.Harvests[i]["Name"]:
				Global.Harvests[i]["Count"] += 1
	# Nếu người chơi chưa có "corn", thêm một đối tượng "corn" vào Global.Harvests.
	else:
		Global.Harvests += [{
			"Name": "corn",
			"Count": 1,
			"Consumable": true,
		}]
	Global.Plot[PlantNum]["Harvested"] = true # Đánh dấu cây đã được thu hoạch trong Global.Plot.
	get_parent().has_seed = false # Đặt has_seed của đối tượng cha bằng false.
	queue_free() # xóa đối tượng 
	pass

# thông tin về item mà đối tượng đang giữ
func _set_item_data(value: ResourceItem):
	item_data = value
	# cập nhật hình ảnh
	_update_texture()
	pass

# cập nhật hình ảnh
func _update_texture():
	# kiểm tra xem có tồn tại và không null
	if item_data and plant:
		plant.texture = plant.texture
	pass
