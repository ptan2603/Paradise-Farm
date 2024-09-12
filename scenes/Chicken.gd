extends CharacterBody2D

# khai báo biến
var eating = false
var walking = false 

# xác định hướng di chuyển theo trục x và y
var xdir = 1  # 1 == right -1 == left
var ydir = 1 # 1 == down -1 == up

# tốc độ di chuyển
var speed = 50.0

# lưu trữ hướng di chuyển
var motion = Vector2()

# xác định di chuyển chính
var moving_vertical_hortizontal = 1 # 1 = x  2 = y

func _ready():
	# Đặt trạng thái của nhân vật là đang đi bộ.
	walking = true 
	randomize()

func _physics_process(delta):
	# nếu không đi bộ
	if walking == false:
		# số ngẫu nhiên
		var x = randf_range(1,2)
		if x > 1.5:
			moving_vertical_hortizontal = 1
		else: 
			moving_vertical_hortizontal = 2 
	# nếu đi bộ 
	if walking == true:
		$AnimatedSprite2D.play("walking")
		# nếu hướng đi ngang 
		if moving_vertical_hortizontal == 1:
			if xdir == -1:
				# lật đối tượng
				$AnimatedSprite2D.flip_h = true
			if xdir == 1:
				# không lật 
				$AnimatedSprite2D.flip_h = false 
			motion.x = speed * xdir 
			motion.y = 0
		elif moving_vertical_hortizontal == 2:
			motion.y = speed * ydir 
			motion.x = 0
	# nếu đang ăn 
	if eating == true:
		$AnimatedSprite2D.play("eating")
		motion.x = 0
		motion.y = 0
	
	velocity = motion * speed * delta
	move_and_slide()

# được gọi khi changestatertimer kết thúc thời gian đếm ngược.
func _on_changestatertimer_timeout():
	var waittime = 1
	# nếu đang đi bộ 
	if walking == true:
		eating = true
		walking = false
		# tgian ngẫu nhiên từ 1 - 5s
		waittime = randf_range(1,5)
	# nếu đang ăn
	elif eating == true:
		walking = true 
		eating = false
		# tgian ngẫu nhiên từ 1 - 5s
		waittime = randf_range(2,6)
	$changestatertimer.wait_time = waittime
	$changestatertimer.start()

# gọi khi walkingtimer kết thúc thời gian đếm ngược.
func _on_walkingtimer_timeout():
	var x = randf_range(1,2)
	var y = randf_range(1,2)
	var waittime =randf_range(1,4)
	
	if x > 1.5:
		xdir = 1 #right
	else:
		xdir = -1 #left
	if y >1.5:
		ydir = 1 
	else: 
		ydir = -1 
	$walkingtimer.wait_time = waittime
	$walkingtimer.start()
