extends Area2D

# khai báo biến player với cảnh người chơi 
@onready var player = preload("res://scenes/player/player.tscn")
# tham chiếu timer
@onready var timer = $Timer
#tham chiếu sprite
@onready var plant = $Sprite

# khai báo biến giai đoạn của cây
var stage = 1
# khai báo biến lưu trữ thời gian tùy chỉnh của cây
var time = 0.0
# theo dõi chỉ số của cây trong mảng Global Plot
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
	# Cập nhật giai đoạn của cây trong Global.Plot và lưu trạng thái trò chơi.
	Global.Plot[PlantNum]["Stage"] = stage
	
func _on_body_entered(body):
	# Khai báo biến has_item để kiểm tra xem người chơi có vật phẩm hay không.
	var has_item = false
	
	# Nếu giai đoạn của cây lớn hơn hoặc bằng 5 và đối tượng đi vào có tên là "player":
	if stage >= 5:
		if body.name == "player":
			# Duyệt qua mảng Global.Harvests để kiểm tra xem người chơi có vật phẩm "corn" hay không.
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
			queue_free() # Giải phóng đối tượng này khỏi bộ nhớ.
