extends StaticBody2D

class_name ResourceNode # đặt lớp

# khai báo biến thành viên của lớp
@export var node_types : Array[ResourceNodeType]
# chỉ số tài nguyên bắt đầu của nút.
@export var starting_resources : int = 1 
# lưu trữ cảnh của đối tượng thu thập tài nguyên
@export var pickup_type : PackedScene
# lưu trữ hiệu ứng khi tài nguyên hết.
@export var depleted_effect: PackedScene
# xác định tốc độ khi tài nguyên được phóng ra.
@export var launch_speed : float = 100
# xác định thời gian kéo dài của sự phóng tài nguyên
@export var launch_duration : float = 0.25

var level_parent: Node

# dùng để lưu trữ số lượng tài nguyên hiện tại.
var current_resources : int :
	# được gọi mỗi khi giá trị của current_resources được thay đổi.
	set(resource_count):
		# Cập nhật giá trị của current_resources với giá trị mới resource_count.
		current_resources = resource_count
		
		if(resource_count <= 0):
			# tạo một đối tượng GPUParticles2D từ cảnh depleted_effect.
			var effect_instance : GPUParticles2D = depleted_effect.instantiate()
			effect_instance.position = position
			# Thêm effect_instance vào level_parent để nó hiển thị trong cảnh.
			level_parent.add_child(effect_instance)
			# Bắt đầu phát ra hiệu ứng hạt của effect_instance.
			effect_instance.emitting = true
			queue_free()
	
func _ready():
	# Đặt current_resources bằng giá trị của starting_resources khi nút được sẵn sàng.
	current_resources = starting_resources
	#  Lưu trữ nút cha của ResourceNode vào biến level_parent
	level_parent = get_parent()

# dùng để thu hoạch tài nguyên từ ResourceNode.
func harvest(amount : int):
	for n in amount:
		# để tạo tài nguyên mới.
		spawn_resource()
	# Giảm số lượng tài nguyên hiện tại bằng amount.
	current_resources -= amount

# dùng để tạo và phóng tài nguyên.
func spawn_resource():
	if level_parent != null: # Kiểm tra nếu level_parent không null
		# Tạo một đối tượng Pickup từ cảnh pickup_type.
		var pickup_instance = pickup_type.instantiate() as Pickup
		# Thêm pickup_instance vào level_parent.
		level_parent.add_child(pickup_instance)
		pickup_instance.position = position
		
		var direction : Vector2 = Vector2 (
			randf_range(-1.0, 1.0),
			randf_range(-1.0, 1.0)
		).normalized() # chuân hóa bằng 1
		
		# truyền vào hướng và tốc độ phóng tài nguyên cùng với thời gian phóng.
		pickup_instance.launch(direction * launch_speed, launch_duration)
	else:
		print("Lỗi: level_parent là null")
