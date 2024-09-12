extends Control
class_name InventoryUI

# Dòng này định nghĩa một hằng số INVENTORY_SLOT và tải trước một tệp cảnh.
#  Việc tải trước đảm bảo rằng tài nguyên được tải vào bộ nhớ trước khi cần, điều này có thể cải thiện hiệu suất.
const INVENTORY_SLOT = preload("res://scenes/Inventory/inventory_slot.tscn")

# Dòng này khai báo một biến xuất data thuộc loại InventoryData. 
# Các biến xuất có thể được thiết lập trong trình soạn thảo Godot, 
# giúp dễ dàng điều chỉnh và gán giá trị mà không cần sửa đổi script.
@export var data: InventoryData


func _ready():
	# Các dòng này kết nối các tín hiệu shown và hidden của PauseMenu với 
	# các hàm update_inventory và clear_inventory tương ứng. 
	# Khi PauseMenu được hiển thị hoặc ẩn, các hàm được kết nối sẽ được gọi.
	PauseMenu.shown.connect(update_inventory)
	PauseMenu.hidden.connect(clear_inventory)
	# Dòng này gọi hàm clear_inventory, sẽ xóa các ô trong kho đồ khi InventoryUI được khởi tạo.
	clear_inventory()
	pass

# Dòng này định nghĩa hàm clear_inventory, sẽ chịu trách nhiệm xóa tất cả các ô trong kho đồ.
func clear_inventory():
	# Các dòng này lặp qua tất cả các con của nút InventoryUI và gọi queue_free() trên mỗi nút. 
	# queue_free() sẽ lập lịch xóa các nút, hiệu quả là xóa các ô trong kho đồ.
	for c in get_children():
		c.queue_free()

# Dòng này định nghĩa hàm update_inventory, 
# sẽ chịu trách nhiệm cập nhật kho đồ với dữ liệu hiện tại.
func update_inventory():
	# Các dòng này lặp qua mỗi ô trong mảng data.slots, 
	# tạo một instance mới của cảnh INVENTORY_SLOT, 
	# thêm nó làm con của nút InventoryUI, và 
	# đặt slot_data của nó thành dữ liệu ô tương ứng từ data.slots
	for s in data.slots:
		var new_slot = INVENTORY_SLOT.instantiate()
		add_child(new_slot)
		new_slot.slot_data = s
	# Dòng này đặt tiêu điểm vào đứa con đầu tiên của nút InventoryUI, 
	# đảm bảo rằng ô trong kho đồ mới được tạo ra được chọn và sẵn sàng để tương tác.
	get_child(0).grab_focus()
