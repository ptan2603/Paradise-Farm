extends Control
class_name DaynightUI

# khởi tạo biến và gán chúng với các đối tượng.
@onready var day_label_background: Label = %DayLabelBgr
@onready var day_label: Label = %DayLabel 
@onready var time_label_background: Label = %TimeLabelBgr
@onready var time_label: Label = %TimeLabel
@onready var arrow: TextureRect = %Arrow

# nhận ba tham số day, hour, minute
func set_daytime(day: int, hour: int, minute: int) -> void:
	# cập nhật văn bản ngày để hiển thị ngày hiện tại.
	day_label.text = "Day " + str(day + 1)
	day_label_background.text = day_label.text
	
	# cập nhật văn bản của nhãn thời gian để hiển thị giờ và phút hiện tại.
	time_label.text = _amfm_hour(hour) + ":" + _minute(minute) + " " + _am_pm(hour)
	time_label_background.text = time_label.text
	
	# chỉnh mũi tên 
	# nếu giờ hiện tại nhỏ hơn hoặc bằng 12  mũi tên quay -90 đến 90 độ
	if hour <= 12:
		# thuộc tính  rotation_degrees được sử dụng để quay arrow(đối tượng) chỉ ra thời gian hiện tại
		arrow.rotation_degrees = _remap_rangef(hour, 0, 12, -90, 90)
	else:
		arrow.rotation_degrees = _remap_rangef(hour, 13, 23, 90, -90)

# chuyển đổi kiểu dữ liệu chuỗi(String)
# chuyển đổi giờ từ định dạng 24 giờ sang 12 giờ(AM/PM)
func _amfm_hour(hour:int) -> String:
	# nếu hour = 0 trả về 12 AM
	if hour == 0:
		return str(12)
	# hour > 12 thì trừ đi 12 và trả về dạng PM
	if hour > 12:
		return str(hour - 12)
	return str(hour)

# định dạng số phút 
func _minute(minute:int) -> String:
	# nếu nhỏ hơn 10 thêm số 0 ở trước
	if minute < 10:
		return "0" + str(minute)
	return str(minute)


func _am_pm(hour:int) -> String:
	if hour < 12:
		return "am"
	else:
		return "pm"

# hàm _remap_rangef biến đổi tuyến tính giữa giá trị đầu vào và đầu ra cho trước 
func _remap_rangef(input:float, minInput:float, maxInput:float, minOutput:float, maxOutput:float):
	return float(input - minInput) / float(maxInput - minInput) * float(maxOutput - minOutput) + minOutput
