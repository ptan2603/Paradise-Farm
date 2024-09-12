extends Node2D
class_name Pickup_tomato

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
		"Seed": "tomato",
		"Time": timer.time_left,
		"Stage": stage,
		"Harvested": false,
	}]
	 
	_update_texture()
	if Engine.is_editor_hint():
		pass
	area_2d.body_entered.connect(_on_body_entered)
	pass
	
func _process(delta):
# Cập nhật thời gian còn lại của cây trong Global.Plot.
	Global.Plot[PlantNum]["Time"] = timer.time_left
	# Sử dụng cấu trúc match để gán giá trị khung hình (frame) của sprite plant dựa trên giai đoạn (stage).
	match stage:
		1: 
			plant.frame = stage + 6
		2: 
			plant.frame = stage + 6
		3: 
			plant.frame = stage + 6
		4: 
			plant.frame = stage + 6
		5: 
			plant.frame = stage + 6
		6:
			plant.frame = 11

# Hàm này được gọi khi timer hết thời gian.
func _on_timer_timeout():
	# nhỏ hơn hoặc bằng 5, tăng stage lên 1.
	if stage <= 5:
		stage += 1
	# Cập nhật giai đoạn của cây trong Global.Plot.
	Global.Plot[PlantNum]["Stage"] = stage
	
func _on_body_entered(b):
	if stage >= 5:
		if b is Player:
			if item_data:
				if PlayerManager.INVENTORY_DATA.add_item(item_data) == true:
					item_picked_up()
	pass
	
func item_picked_up():
	var has_item = false
	area_2d.body_entered.disconnect(_on_body_entered)
	audio_steam_player_2d.play()
	visible = false
	await audio_steam_player_2d.finished
	for i in Global.Harvests.size():
		if "tomato" in Global.Harvests[i]["Name"]:
			has_item = true
			# Nếu người chơi đã có "tomato", tăng số lượng "tomato" lên 1.
	if has_item:
		for i in Global.Harvests.size():
			if "tomato" == Global.Harvests[i]["Name"]:
				Global.Harvests[i]["Count"] += 1
	# Nếu người chơi chưa có "tomato", thêm một đối tượng "tomato" vào Global.Harvests.
	else:
		Global.Harvests += [{
			"Name": "tomato",
			"Count": 1,
			"Consumable": true,
		}]
	Global.Plot[PlantNum]["Harvested"] = true # Đánh dấu cây đã được thu hoạch trong Global.Plot.
	get_parent().has_seed = false # Đặt has_seed của đối tượng cha bằng false.
	queue_free()
	pass
	
func _set_item_data(value: ResourceItem):
	item_data = value
	_update_texture()
	pass

func _update_texture():
	if item_data and plant:
		plant.texture = plant.texture
	pass
