extends Node

# khai báo biến hằng số
const PLAYER = preload("res://scenes/player/player.tscn")
const INVENTORY_DATA :  = preload("res://scenes/Inventory/player_inventory.tres")

# khai báo biến với kiểu dữ liệu player
var player : Player
# khai báo biến với kiểu dữ liệu boolean
# theo dõi trạng thái của người xem
var player_spawned : bool = false 

func _ready():
	# tạo bộ đếm thời gian với tgian chờ 0.2
	await get_tree().create_timer(0.2).timeout
	player_spawned = true
	
func set_player_position(_new_pos : Vector2 ):
	# thay đổi vị trí của đối tượng player.
	player.global_position = _new_pos
	pass
# thiết lập đối tượng kiểu node2d làm cha player
func set_as_parent(_p : Node2D):
	# kiểm tra đã có nút cha chưa
	if player.get_parent():
		# nếu có loại bỏ player ra khỏi nút cha hiện tại
		player.get_parent().remove_child(player)
		# thêm player làm con của dối tượng
		_p.add_child(player)

# phương thức loại bỏ player ra khỏi nút cha
func unparent_player(_p : Node2D):
	_p.remove_child(player)
