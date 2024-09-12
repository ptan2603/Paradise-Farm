extends StaticBody2D

@onready var rain = $rain
@onready var timer = $Timer

# khai báo biến và khởi tạo với giá trị rain.
# theo dõi trạng thái thời tiết
var current_weather = "rain"
# tín hiệu weather_changed, được phát khi thời tiết thay đổi.
signal weather_changed(new_weather)

func _ready():
	# trạng thái hiển thị mưa
	update_weather_visibility()

# được gọi khi thời gian hết 
func _on_timer_timeout():
	#nếu là none sẽ thành rain và đặt thời gian ngẫu nhiên là 10 - 30 giây
	# rồi khởi động lại
	if current_weather == "none":
		current_weather = "rain"
		$Timer.wait_time = randf_range(10, 15)
	# nếu không phải là none đặt thời gian từ 20-60 giây 
	else:
		current_weather = "none"
		$Timer.wait_time = randf_range(20, 60)
	$Timer.start()
	# cập nhật hiển thị mưa
	update_weather_visibility()
	
	# phát tín hiệu weather_changed với thời tiết hiện tại
	emit_signal("weather_changed", current_weather)

func _process(delta):
	# biến toàn cục có thuộc weather  
	Global.weather = current_weather

# Hàm cập nhật hiển thị thời tiết
func update_weather_visibility():
	$rain.visible = (current_weather == "rain") # hiển thị hoặc ẩn đối tượng rain
	$raincolor.visible = (current_weather == "rain") # hiển thị hoặc ẩn đối tượng raincolor
