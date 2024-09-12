extends CanvasLayer

# khởi tạo các biến onready cho ba nút: save (lưu), load (tải) và exit (thoát). 
# Từ khóa @onready đảm bảo rằng các biến được khởi tạo sau khi node được thêm vào cảnh. 	
@onready var button_save: Button = $Control/HBoxContainer/Button_Save
@onready var button_load: Button = $Control/HBoxContainer/Button_Load
@onready var button_exit: Button = $Control/HBoxContainer/Button_Exit

# Dòng này khai báo một biến boolean is_paused để theo dõi trạng thái trò chơi có đang tạm dừng hay không.
var is_paused : bool = false

# định nghĩa hai tín hiệu tùy chỉnh: shown và hidden. 
# Các tín hiệu này có thể được phát ra khi menu tạm dừng được hiển thị hoặc ẩn đi.
signal shown
signal hidden

# Nó ẩn menu tạm dừng ban đầu và kết nối các tín hiệu pressed của các nút save 
# và load với các hàm xử lý tương ứng _on_save_pressed và _on_load_pressed
func _ready():
	hide_pause_menu()
	button_save.pressed.connect(_on_save_pressed)
	button_load.pressed.connect(_on_load_pressed)

# Hàm _unhandled_input xử lý các sự kiện đầu vào chưa được xử lý bởi các node khác. 
# Nếu hành động "pause" được nhấn, nó chuyển đổi menu tạm dừng. 
# Phương thức get_viewport().set_input_as_handled() đánh dấu sự kiện đã được xử lý để nó không được xử lý thêm nữa.
func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("pause"):
		if is_paused == false:
			show_pause_menu()
		else:
			hide_pause_menu()
		get_viewport().set_input_as_handled()
		

# Hàm show_pause_menu tạm dừng trò chơi, làm cho menu tạm dừng hiển thị, 
# đặt is_paused thành true, lấy focus cho nút save, và phát tín hiệu shown.
func show_pause_menu():
	get_tree().paused = true
	visible = true 
	is_paused = true 
	button_save.grab_focus()
	shown.emit()

# Hàm hide_pause_menu hủy tạm dừng trò chơi, ẩn menu tạm dừng,
# đặt is_paused thành false, và phát tín hiệu hidden.
func hide_pause_menu():
	get_tree().paused = false
	visible = false 
	is_paused = false 
	hidden.emit()

# Hàm _on_save_pressed được gọi khi nút save được nhấn. 
# Nếu trò chơi không đang tạm dừng, nó trả về ngay lập tức. 
# Nếu không, nó gọi hàm save_game của SaveManager và ẩn menu tạm dừng.
func _on_save_pressed():
	if is_paused == false:
		return 
	SaveManager.save_game()
	hide_pause_menu()

# Hàm _on_load_pressed được gọi khi nút load được nhấn. 
# Nếu trò chơi không đang tạm dừng, nó trả về ngay lập tức. 
# Nếu không, nó gọi hàm load_game của SaveManager, chờ tín hiệu level_load_started từ LevelManager, 
# và sau đó ẩn menu tạm dừng.
func _on_load_pressed():
	if is_paused == false:
		return 
	SaveManager.load_game()
	await LevelManager.level_load_started
	hide_pause_menu()
	
