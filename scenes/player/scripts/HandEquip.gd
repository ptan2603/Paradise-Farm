@tool
extends Sprite2D

class_name HandEquip

# Được xuất ra để có thể chỉnh sửa trực tiếp 
@export var equipped_item : EquippableItem :
# tùy chỉnh để cập nhật texture của HandEquip mỗi khi giá trị của equipped_item thay đổi.
	set(next_equipped):
		equipped_item = next_equipped
		self.texture = equipped_item.texture
		
# Được xuất ra để có thể chỉnh sửa trực tiếp
@export var sprite_2d : Sprite2D

# Được khởi tạo với giá trị là $Area2D thông qua @onready.
@onready var area_2d : Area2D = $Area2D

func _ready():
	# nếu trò chơi không ở chế độ trình soạn thảo (editor hint), 
	# thuộc tính monitoring của area_2d được đặt là false.
	if(not Engine.is_editor_hint()):
		area_2d.monitoring = false
# hàm được gọi khi một thân thể (body) khác đi vào vùng Area2D.
func _on_area_2d_body_entered(body):
	# Nếu equipped_item có phương thức interact_with_body, phương thức này sẽ được gọi tham số là body.
	if(equipped_item.has_method("interact_with_body")):
		equipped_item.interact_with_body(body)
	
