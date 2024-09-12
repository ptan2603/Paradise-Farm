extends Node2D

# khai báo biến inside_scene kiểu PackedScene và 
# đánh dấu là có thể thiết lập trong trình chỉnh sửa 
# Biến chứa cảnh sẽ được tải khi người chơi vào hang.
@export var inside_scene: PackedScene

# Hàm này được gọi khi một đối tượng (body) đi vào vùng cửa.
# Nó gán thuộc tính cave của đối tượng body bằng chính đối tượng hiện tại (self).
func _on_door_body_entered(body):
	# lưu thông tin về hang mà đối tượng vừa vào
	body.house = self

# Hàm này được gọi khi một đối tượng (body) rời khỏi vùng cửa. 
# Nếu thuộc tính cave của đối tượng body bằng đối tượng hiện tại (self), 
# nó sẽ đặt thuộc tính cave của đối tượng body thành null.
func _on_door_body_exited(body):
	if body.house == self:
		# đối tượng không còn ở trong hang.
		body.house = null

# Hàm này chuyển đổi cảnh hiện tại sang cảnh được lưu trong biến inside_scene.
# Nó sử dụng phương thức change_scene_to_file của SceneTree và truyền vào đường dẫn tài nguyên của cảnh inside_scene.
func enter():
	get_tree().change_scene_to_file(inside_scene.resource_path)
