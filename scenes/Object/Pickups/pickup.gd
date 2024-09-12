extends Node2D

class_name Pickup

# cho phép chỉnh sửa từ Editor và gán kiểu dữ liệu Resource
@export var resource_type : Resource
@export var item_data : ResourceItem : set = _set_item_data

@onready var area_2d : Area2D = $Area2D
# Khởi tạo biến collision_shape và lấy tham chiếu tới node CollisionShape2D trong Scene
@onready var collision_shape : CollisionShape2D = $Area2D/CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var audio_steam_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

# Biến để lưu trữ vận tốc phóng của Pickup
var launch_velocity : Vector2 = Vector2.ZERO

# Biến để lưu trữ thời gian di chuyển của Pickup
var move_duration : float = 0

# Biến để tính thời gian đã trôi qua kể từ khi bắt đầu phóng
var time_since_launch : float = 0 

# Biến launching để kiểm soát trạng thái phóng của Pickup
var launching : bool = false : 
	# Khi launching được thay đổi
	set(is_launching):
		launching = is_launching
		collision_shape.disabled = launching # Bật/Tắt va chạm tùy theo trạng thái phóng
	
func _ready():
	_update_texture()
	if Engine.is_editor_hint():
		pass
	# Kết nối tín hiệu "body_entered" với hàm _on_body_entered khi bắt đầu
	area_2d.connect("body_entered", _on_body_entered )
	pass

func _process(delta):
	 # Nếu đang trong trạng thái phóng
	if(launching):
		position += launch_velocity * delta
		# Cập nhật time_since_launch với thời gian trôi qua
		time_since_launch += delta 
		 # Kiểm tra xem thời gian đã trôi qua có đủ để kết thúc phóng hay không
		if(time_since_launch >= move_duration):
			launching = false
			
# thiết lập các thông số cho việc phóng Pickup.
func launch(velocity : Vector2, duration : float):
	 # Thiết lập vận tốc và thời gian di chuyển
	launch_velocity = velocity
	move_duration = duration
	time_since_launch = 0 
	launching = true # bắt đầu phóng
	
# hàm gọi khi đối tượng va chạm vào vùng
func _on_body_entered(b):
	if b is Player:
		if item_data:
			if PlayerManager.INVENTORY_DATA.add_item(item_data) == true:
				item_picked_up()
	pass
	
# hàm được gọi khi item được thu hoạch
func item_picked_up():
	# ngắt tín hiệu không cho hàm _on_body_entered gọi thêm nữa khi được thu hoạch
	area_2d.disconnect("body_entered",_on_body_entered)
	audio_steam_player_2d.play()
	visible = false
	# cho phép mã dừng lại khi âm thanh hoàn tất 
	await audio_steam_player_2d.finished
	queue_free()
	pass
	
# thông tin về item mà đối tượng đang giữ
func _set_item_data(value: ResourceItem):
	item_data = value
	_update_texture()
	pass
	
# cập nhật hình ảnh
func _update_texture():
	if item_data and sprite_2d:
		sprite_2d.texture = item_data.texture
	pass
