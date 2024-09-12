extends CharacterBody2D

class_name  Player # đặt tên cho lớp là player để dễ truy cập

# khởi tạo biến và gán chúng với các đối tượng.
@onready var animation = $AnimationTree
@onready var canvas_layer = $UI
#GlobalCanvasModulate
@onready var canvas_modulate = GlobalCanvasModulate
@onready var ui = $UI/DaynightUI
@onready var sound_machine = $SoundMachine
@onready var coins = $UI/coinstext

# tạo biến direction để lưu di chuyển của người chơi và khởi tạo với giá trị vector 0
var direction : Vector2 = Vector2.ZERO

# tạo biến house lưu trữ thông tin về ngôi nhà và sử dụng set_house thiết lập giá trị cho biến 
var house = null: set = set_house

# khởi tạo tốc độ di chuyển là 100.0 kiểu float
const speed : float = 100.0

# phương thức thiết lập giá trị cho biết house 
func set_house(new_house):
	house = new_house
	
	#nếu khác null
	if new_house != null:
		#phát hoạt cảnh KeyProm và hiển thị Key
		$KeyProm.play("KeyProm")
		$Key.show()
	# nếu không ẩn key và dừng KeyProm
	else:
		$Key.hide()
		$KeyProm.stop()
	
# hàm được gọi khi đã được tạo và sẵn sàng.
func _ready():
	# thiết lập đối tượng player trong PlayerManager tham chiếu đến Player hiện tại.
	# cho phép các phần khác của trò chơi truy cập và tương tác với Player thông qua PlayerManager.player.
	PlayerManager.player = self
	
	# thiết lập giá trị ban đầu house = null
	set_house(null)
	
	# kích hoạt animation
	animation.active = true
	
	# đặt true để hiển thị đối tượng canvas_layer
	canvas_layer.visible = true
	
	# Kết nối tín hiệu time_tick( mỗi giây) với phương thức set_daytime trong ui.
	canvas_modulate.time_tick.connect(ui.set_daytime)
	
	#Kết nối tín hiệu time_tick với phương thức set_daytime trong sound_machine.
	canvas_modulate.time_tick.connect(sound_machine.set_daytime)

# phương thức gọi mỗi frame. cập nhật các tham số hoạt cảnh.
func _process(delta):
	update_animation_parameters()

# hàm xử lý các sự kiện đầu vào 
func _unhandled_input(event):
	#nếu người chơi nhấn Interact và house không null, vị trí của người chơi sẽ được lưu và vào nhà. 
	if event is InputEventKey and event.is_action_pressed("Interact") and house != null:
		# lưu vị trí hiện tại
		Global.player_pos = global_position
		# gọi phương thức enter trong house.
		house.enter()

# hàm dùng để bán đồ
func player_sell_method():
	pass

# hàm dùng để mua đồ
func player_shop_method():
	pass

# phương thức gọi frame vật lí
func _physics_process(delta):
	# nó cập nhật số lượng tiền hiển thị
	coins.text = ("=" + str(Global.coins))
	
	# lấy hướng di chuyển 
	direction = Input.get_vector("left","right","up","down").normalized()
	
	# cập nhật chuyển dộng
	if direction:
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()
	
# phương thức cập nhật các tham số hoạt cảnh dựa trên trạng thái người chơi
func update_animation_parameters():
	# Nếu người chơi không di chuyển, đặt trạng thái 'idle' thành true 
	# và 'is_moving' thành false.
	if(velocity == Vector2.ZERO):
		animation["parameters/conditions/idle"] = true
		animation["parameters/conditions/is_moving"] = false
	else:
	# Nếu người chơi đang di chuyển, đặt trạng thái 'idle' thành false 
	# và 'is_moving' thành true.
		animation["parameters/conditions/idle"] = false
		animation["parameters/conditions/is_moving"] = true
# Nếu người chơi vừa nhấn nút 'Spawn', đặt trạng thái 'swing' thành true.
	if(Input.is_action_just_pressed("Spawn")):
		animation["parameters/conditions/swing"] = true
	else:
		animation["parameters/conditions/swing"] = false
# Nếu direction không phải là Vector2.ZERO (có hướng di chuyển), 
# cập nhật blend_position của các hoạt cảnh 'idle', 'swing', và 'walk' dựa trên direction.
	if(direction != Vector2.ZERO):
		animation["parameters/idle/blend_position"] = direction
		animation["parameters/swing/blend_position"] = direction
		animation["parameters/walk/blend_position"] = direction
