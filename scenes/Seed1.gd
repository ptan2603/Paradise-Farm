@tool
extends Button


# cho phép bạn chỉnh sửa giá trị của nó từ Editor của Godot
@export var item : Item :
	# Khi giá trị của item thay đổi (set(item_to_slot)), icon của Button sẽ thay đổi thành texture.
	set(item_to_slot):
		item = item_to_slot
		icon = item.texture

# Khai báo biến hand_equip kiểu HandEquip, một đối tượng có thể được gắn vào trong Godot.
var hand_equip : HandEquip

func _ready():
	# Nếu không phải là chế độ chỉnh sửa (not Engine.is_editor_hint()), nó sẽ kết nối sự kiện "pressed" với hàm _on_pressed.
	if(not Engine.is_editor_hint()):
		connect("pressed", _on_pressed)

func _on_pressed():
	# Nếu không phải là chế độ chỉnh sửa.
	if(not Engine.is_editor_hint()):
		# nó kiểm tra xem item có phải là một EquippableItem hay không.
		if(item is EquippableItem):
		# nó kiểm tra nếu hand_equip khác null, thì gán item vào hand_equip.equipped_item.
			if(hand_equip != null):
				hand_equip.equipped_item = item
