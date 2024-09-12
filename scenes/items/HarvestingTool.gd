extends EquippableItem

class_name HarvestingTool

# Danh sách các loại tài nguyên mà công cụ này có thể tương tác.
@export var effected_types : Array[ResourceNodeType]

# Số lượng tối thiểu tài nguyên có thể thu hoạch được từ một nút tài nguyên.
@export var min_amount : int = 1

#  Số lượng tối đa tài nguyên có thể thu hoạch được từ một nút tài nguyên.
@export var max_amount : int = 1 

func interact_with_body(body):
	# Nếu body là một ResourceNode
	if(body is ResourceNode):
	# Vòng lặp qua các loại tài nguyên được định nghĩa trong effected_types.
		for type in effected_types: 
		#Kiểm tra xem body có chứa loại tài nguyên nào trong danh sách effected_types hay không.
			if(body.node_types.has(type)):
		# Nếu có, in ra thông báo debug và gọi phương thức harvest của body để thu hoạch tài nguyên
				print_debug("Match found at type" + type.display_name + "on" + body.name )
			# số lượng ngẫu nhiên từ min_amount đến max_amount.
				body.harvest(randi_range(min_amount, max_amount))
	
