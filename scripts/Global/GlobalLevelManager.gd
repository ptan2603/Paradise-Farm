extends Node

# khai báo tín hiệu
signal level_load_started # thông báo quá trình tải level đã bắt đầu. 
signal level_load # thông báo 1 level đang được  tải.
signal TileMapBoundsChanged(bounds : Array[Vector2]) # phát khi giới hạn của tile map thay đổi.

# biến lưu trữ giới hạn hiện tại của tilemap 
var current_tilemap_bounds : Array[Vector2]
# biến lưu trữ thông tin chuyển cảnh khi chuyển sang level mới
var target_transition : String
# biến lưu trữ độ lệch vị trí khi chuyển sang level mới
var position_offset : Vector2

# hàm dùng để cập nhật giới hạn của tilemap
func ChangeTilemapBounds(bounds : Array[Vector2]):
	# cập nhật giá trị current_tilemap_bounds với bounds được truyền vào
	current_tilemap_bounds = bounds
	# thông báo tilemap đã  thay đổi.
	TileMapBoundsChanged.emit(bounds)
	
func load_new_level(
	level_path : String,
	_target_transition : String,
	_position_offset : Vector2
):
	# dừng toàn bộ cây của cảnh, các hoạt động trong game
	get_tree().paused = true
	# lưu giá trị _target_transition vào biến target_transition
	target_transition = _target_transition
	# lưu giá trị _position_offset vào biến position_offset
	position_offset = _position_offset
	
	# đến khi kết thúc khung hình hiện tại, đảm bảo các câu lệnh trước đó đã xử lý
	await get_tree().process_frame
	
	# phát tín hiệu quá trình tải level mới đã bắt đầu
	level_load_started.emit()
	
	await get_tree().process_frame
	
	# thay đổi cảnh hiện tại sang cảnh được chỉ định bởi level_path
	get_tree().change_scene_to_file(level_path)
	
	# đợi đến khi kết thúc khung hình hiện tại 
	await get_tree().process_frame
	
	# tiếp tục toàn bộ các hoạt động trong game khi level mới đã được tải
	get_tree().paused = false
