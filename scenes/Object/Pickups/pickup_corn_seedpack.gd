extends Node2D
class_name Pickup_seedpack

# Dòng này xuất biến item_data thuộc kiểu ResourceItem ra inspector, 
# cho phép chỉnh sửa nó trong editor. 
# Từ khóa set chỉ định một hàm setter _set_item_data được gọi bất cứ khi nào biến này được gán giá trị.
@export var item_data : ResourceItem : set = _set_item_data

# Những dòng này sử dụng từ khóa @onready để khởi tạo các biến với các node trong scene. 
# Cú pháp $NodeName tìm các node con có tên Area2D, Sprite2D, và AudioStreamPlayer2D tương ứng.
@onready var area_2d: Area2D = $Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var audio_steam_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

# _ready() được gọi khi node lần đầu tiên vào cây scene.
func _ready():
	# _update_texture() cập nhật texture của sprite dựa trên item_data.
	_update_texture()
	# if Engine.is_editor_hint() kiểm tra xem mã có đang chạy trong editor hay không. 
	# Nếu đúng, nó không làm gì do câu lệnh pass.
	if Engine.is_editor_hint():
		pass
	# area_2d.body_entered.connect(_on_body_entered) kết nối signal body_entered của area_2d 
	# với hàm _on_body_entered, để hàm này sẽ được gọi khi một body khác vào Area2D
	area_2d.body_entered.connect(_on_body_entered)
	pass
# _on_body_entered(b) được gọi khi một body khác vào Area2D.
func _on_body_entered(b):
	# if b is Player: kiểm tra xem body b có phải là instance của lớp Player.
	if b is Player:
		# if item_data: kiểm tra xem item_data không null.
		if item_data:
			# if PlayerManager.INVENTORY_DATA.add_item(item_data) == true: cố gắng thêm item_data vào 
			# inventory của người chơi. Nếu thành công, nó gọi item_picked_up().
			if PlayerManager.INVENTORY_DATA.add_item(item_data) == true:
				item_picked_up()
	pass
# xử lý sự kiện khi item được người chơi nhặt.
func item_picked_up():
# area_2d.body_entered.disconnect(_on_body_entered) ngắt kết nối signal để ngăn hàm này được gọi lại.
	area_2d.body_entered.disconnect(_on_body_entered)
# audio_steam_player_2d.play() phát âm thanh nhặt item.
	audio_steam_player_2d.play()
# visible = false làm cho node không hiển thị.
	visible = false
# await audio_steam_player_2d.finished chờ âm thanh phát xong.
	await audio_steam_player_2d.finished
# queue_free() loại bỏ node khỏi scene.
	queue_free()
	pass
	
# _set_item_data(value: ResourceItem) là hàm setter cho item_data
func _set_item_data(value: ResourceItem):
	# item_data = value gán giá trị mới cho item_data.
	item_data = value
	# _update_texture() cập nhật texture của sprite dựa trên item_data mới.
	_update_texture()
	pass
# _update_texture() cập nhật texture của sprite
func _update_texture():
	# if item_data and sprite_2d: kiểm tra xem cả item_data và sprite_2d đều không null.
	if item_data and sprite_2d:
	# sprite_2d.texture = item_data.texture đặt texture của sprite thành texture 
	# được chỉ định trong item_data.
		sprite_2d.texture = item_data.texture
	pass
