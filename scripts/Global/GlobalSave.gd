extends Node

# khai báo hằng số , dùng để chỉ định nơi lưu trữ tập tin trò chơi
const SAVE_PATH = "res://"

# khai báo tín hiệu game_loaded được phát ra để báo đã được tải thành công
signal game_loaded
# khai báo tín hiệu game_saved được phát ra để báo đã được lưu thành công
signal game_saved

# dùng để lưu dữ liệu của trò chơi.
var current_save : Dictionary = {
	scene_path = "",
	player = {
		pos_x = 0,
		pos_y = 0
	},
	items = [],
	persistence = [],
}

# phương thức dùng để lưu trạng thái của trò chơi vào một tập tin.
func save_game():
	# cập nhật dữ liệu về vị trí người chơi.
	update_player_data()
	# cập nhật đường dẫn cảnh hiện tại.
	update_scene_path()
	# cập nhật dữ liệu vật phẩm.
	update_item_data()
	# mở tập tin ở chế độ ghi
	var file := FileAccess.open(SAVE_PATH + "save.sav", FileAccess.WRITE)
	
	# chuyển đổi thành chuỗi JSON đề lưu tập tin
	var save_json = JSON.stringify(current_save)
	
	# ghi chuỗi JSON vào tập tin
	file.store_line(save_json)
	# phát tín hiệu đã được lưu thành công.
	game_saved.emit()
	
	print("save_game")
	pass 
	
# phương thức dùng để tải trạng thái của trò chơi từ tập tin lưu trữ.
func load_game():
	# Mở tập tin ở chế độ đọc.
	var file := FileAccess.open(SAVE_PATH + "save.sav", FileAccess.READ)
	
	# Tạo một đối tượng JSON mới để xử lý dữ liệu JSON.
	var json := JSON.new()
	# Đọc một dòng từ tập tin và phân tích cú pháp JSON.
	json.parse(file.get_line())
	
	# Chuyển dữ liệu JSON thành kiểu Dictionary.
	var save_dirt : Dictionary = json.get_data() as Dictionary
	# Cập nhật current_save với dữ liệu được đọc từ tập tin.
	current_save = save_dirt
	
	# Tải cảnh mới dựa trên scene_path từ current_save.
	LevelManager.load_new_level(current_save.scene_path, "", Vector2.ZERO)
	
	# Chờ cho đến khi quá trình tải cảnh bắt đầu.
	await LevelManager.level_load_started
	
	# Đặt vị trí của người chơi dựa trên tọa độ từ current_save.
	PlayerManager.set_player_position(Vector2(current_save.player.pos_x, current_save.player.pos_y))
	
	# Phân tích dữ liệu vật phẩm từ current_save và cập nhật dữ liệu kho của người chơi.
	PlayerManager.INVENTORY_DATA.parse_save_data(current_save.items)
	
	# Chờ cho đến khi quá trình tải cảnh hoàn tất.
	await LevelManager.level_load
	
	# Phát tín hiệu game_loaded để thông báo rằng trò chơi đã được tải thành công.
	game_loaded.emit()
	
	print("load_game")
	pass 

# cập nhật dữ liệu về vị trí của người chơi.
func update_player_data():
	# Lấy đối tượng người chơi từ PlayerManager.
	var p : Player = PlayerManager.player
	current_save.player.pos_x = p.global_position.x
	current_save.player.pos_y = p.global_position.y

# cập nhật đường dẫn của cảnh hiện tại.
func update_scene_path():
	# Khai báo biến p kiểu String để lưu trữ đường dẫn cảnh.
	var p : String = ""
	# Lặp qua tất cả các con của nút gốc (root) trong cây cảnh.
	for c in get_tree().root.get_children():
	# Kiểm tra xem nút c có phải là một đối tượng Level không.
		if c is Level:
		# Nếu c là một đối tượng Level, gán đường dẫn của cảnh vào p
			p = c.scene_file_path
	#  Cập nhật đường dẫn cảnh trong current_save.
	current_save.scene_path = p
	
# cập nhật dữ liệu vật phẩm.
func update_item_data():
	# Lấy dữ liệu vật phẩm từ INVENTORY_DATA của PlayerManager và cập nhật vào current_save.items.
	current_save.items = PlayerManager.INVENTORY_DATA.get_save_data()
