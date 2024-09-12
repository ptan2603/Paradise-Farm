extends Node2D

# khai báp biến entered = false. 
# Biến này dùng để kiểm tra xem đối tượng đã rời khỏi vùng thoát (exit area) hay chưa.
var entered = false

# Khai báo biến outside và gán nó với đường dẫn của cảnh bên ngoài (world.tscn).
# Biến này chứa đường dẫn đến cảnh sẽ được tải khi người chơi thoát khỏi nhà.
var outside = "res://world.tscn"

# Hàm này được gọi khi một đối tượng (body) đi vào vùng thoát (exit area). 
func _on_exit_body_entered(body):
	if entered:
		get_tree().change_scene_to_file(outside)

# Hàm này được gọi khi một đối tượng (body) rời khỏi vùng thoát (exit area). 
# Nó sẽ đặt biến entered thành true, đánh dấu rằng đối tượng đã rời khỏi vùng thoát.
func _on_exit_body_exited(body):
	entered = true
