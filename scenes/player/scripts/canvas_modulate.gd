extends CanvasModulate
# quản lý thời gian, cập nhật và hiển thị
const MINUTES_PER_DAY = 1440 # số phút trong 1 ngày 
const MINUTES_PER_HOUR = 60 # số phút trong 1 giờ 

# thời gian trong trò chơi tương ứng với một phút trong tg thực 
const INGAME_TO_REAL_MINUTE_DURATION = (2 * PI) / MINUTES_PER_DAY

signal time_tick(day:int, hour:int, minute:int) # thông báo về sự thay đổi thời gian với ngày, giờ, phút

@export var gradient_texture : GradientTexture1D # biến sử dụng để áp dụng hiệu ứng gradient
@export var INGAME_SPEED = 5 # Tốc độ của thời gian trong trò chơi.
@export var INITIAL_HOUR = 6 :  # Giờ khởi đầu của trò chơi.
	set(INITIAL_HOUR): # phương thức tùy chỉnh cho biến INITIAL_HOUR
		# cập nhật giá trị của biến time dựa trên INITIAL_HOUR
		time = INGAME_TO_REAL_MINUTE_DURATION * MINUTES_PER_HOUR * INITIAL_HOUR

# time có giá trị khởi tạo là 0
var time:float= 0.0

# Biến lưu trữ phút đã trôi qua trong lần tính toán trước đó
# past_minute có giá trị khởi tạo = -1
var past_minute:int= -1


func _ready() -> void:
	#tính toán giá trị thời gian dựa trên INITIAL_HOUR khi đối tượng được tạo ra.
	time = INGAME_TO_REAL_MINUTE_DURATION * MINUTES_PER_HOUR * INITIAL_HOUR
	
# gọi khung hình
func _process(delta: float)  -> void:
	# cập nhật biến time 
	#delta là thời gian đã trôi qua từ khung hình trước đó(tính bằng giây)
	time += delta * INGAME_TO_REAL_MINUTE_DURATION * INGAME_SPEED
	
	# tính value dựa trên time
	# dùng sin để tạo ra biến đổi chu kỳ của thời gian
	var value = (sin(time - PI / 2.0) + 1.0) / 2.0
	# nếu gradient_texture được gán.
	if gradient_texture:
	# Dòng này thiết lập màu sắc của đối tượng dựa trên giá trị value đã tính toán.
	# sample(value) được sử dụng để lấy một màu từ gradient tại vị trí value 
		self.color = gradient_texture.gradient.sample(value)
	else:
		print("Gradient texture is not assigned!")
	# cập nhật thời gian trong trò chơi thành các giá trị ngày, giờ và phút mới.
	_recalculate_time()
	
# tính toán và cập nhật các giá trị ngày, giờ, phút.
func _recalculate_time() -> void:
	# tính toán tổng số phút đã trôi qua từ khi bắt đầu, dựa trên giá trị của biến time.
	var total_minutes = int(time / INGAME_TO_REAL_MINUTE_DURATION)
	
	# tính toán số ngày đã trôi qua dựa trên tổng số phút và số phút trong một ngày.
	var day = int(total_minutes / MINUTES_PER_DAY)
	
	# tính toán số phút hiện tại trong ngày dựa trên tổng số phút đã trôi qua và số phút trong một ngày.
	var current_day_minutes = total_minutes % MINUTES_PER_DAY
	
	# tính toán giờ và phút hiện tại trong ngày dựa trên số phút hiện tại trong ngày 
	var hour = int(current_day_minutes / MINUTES_PER_HOUR) # phần nguyên 
	var minute = int(current_day_minutes % MINUTES_PER_HOUR) # phần dư
	
	# kiểm tra phút hiện tại có khác phút đã trôi không.
	if past_minute != minute:
		# nếu khác, cập nhật lại biến past thành giá trị 
		past_minute = minute
		# gửi time_tick với các tham số day, hour, minute về sự thay đổi thời gian cho các đối tượng
		time_tick.emit(day, hour, minute)
