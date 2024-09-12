extends Node

# khởi tạo biến có giá trị
@export var night_hour = 18
@export var day_hour = 5

# khởi tạo biến và gán chúng với các đối tượng.
@onready var day_jingle: AudioStreamPlayer = $DayJingle
@onready var night_jingle: AudioStreamPlayer = $NightJingle
@onready var day_soundscape: AudioStreamPlayer = $DaySoundscape
@onready var night_soundscape: AudioStreamPlayer = $NightSoundscape

# cập nhật âm thanh dựa trên ngày, giờ và phút 
func set_daytime(_day: int, hour: int, minute: int) -> void:
	# kiểm tra giờ hiện tại là ngày hay đêm
	if hour <= day_hour or hour >= night_hour:
		# kiểm tra xem ta có cần phát âm thanh ban đêm không
		if not night_soundscape.playing:
			night_soundscape.play()
			day_soundscape.stop()
	# nếu giờ không phải ban đêm
	else:
		# kiểm tra xem ta có cần phát âm thanh ban ngày không
		if not day_soundscape.playing:
			day_soundscape.play()
			night_soundscape.stop()
	# kiểm tra nếu hour = 5 và minute = 0 thì phát tiếng gà và nhạc ban 
	if hour == day_hour and minute == 0:
		day_jingle.play()
		day_soundscape.play()
		night_soundscape.stop()
	# kiểm tra nếu hour = 18 và minute = 0 thì phát tiếng gà và nhạc ban 
	if hour == night_hour and minute == 0:
		night_jingle.play()
		day_soundscape.stop()
		night_soundscape.play()
