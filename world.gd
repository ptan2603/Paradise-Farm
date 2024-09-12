extends Node2D

# tạo biến tile_map tham chiếu
@onready var tile_map = $TileMap
@onready var player = $Player/player
@onready var grid_helper = $GridHelper
@onready var selecbar = $Player/player/SelectBar
@onready var weather = $Player/player/Camera2D/weather_control

var has_seed = false

func _ready():
	# đặt vị trí đối tượng player theo giá trị Global.player_pos
	player.global_position = Global.player_pos
	
	# Đặt hình ảnh trỏ chuột từ file png với vị trí gốc là (0, 0).
	DisplayServer.cursor_set_custom_image(load("res://tilemap/mouse.png"), 0, Vector2i(0, 0))
	
#hàm này được gọi trong mỗi frame của game và thường được sử dụng cho logic vật lý.
func _physics_process(delta):
	var playerMapCoord = tile_map.local_to_map(player.global_position)
	var playerDir = player.direction
	var playerMapsCoord = playerMapCoord + Vector2i(playerDir) / 32
	grid_helper.global_position = playerMapCoord * 16
func _on_weather_changed(new_weather):
	pass
