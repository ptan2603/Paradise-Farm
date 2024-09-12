extends StaticBody2D

# khởi tạo biến với giá trị 1, đại diện cho mặt hàng hiện tại được chọn
var item = 1

# Khai báo biến coins sẽ được sử dụng để lưu giá của mặt hàng đang được bán.
var coins = Global.coins

func ready():
	# Phát animation hoặc hiệu ứng hình ảnh liên quan đến node icon, cụ thể là animation "cornseed".
	$icon.play("corn")
	# Đặt mặt hàng hiện đang chọn trở lại 1 khi node sẵn sàng.
	item = 1

func _physics_process(delta):
	# Kiểm tra xem node hiện tại có hiển thị hay không.
	if self.visible == true:
		# Kiểm tra xem mặt hàng hiện đang chọn có phải là 1 hay không.
		if item == 1:
			$icon.play("corn")
			#Đặt văn bản của node $pricelabel để hiển thị giá của mặt hàng 1.
			$pricelabel.text = "5"
		if item == 2:
			$icon.play("tomato")
			$pricelabel.text = "8"
func _on_buttonleft_pressed():
	swap_item_back()

func _on_buttonright_pressed():
	swap_item_forward()

func swap_item_back():
	#Nếu mặt hàng hiện chọn là 1, chuyển sang 2 và ngược lại.
	if item == 1:
		item = 2 
	elif item == 2:
		item = 1

func swap_item_forward():
	#Tương tự như swap_item_back, hàm này chuyển đổi mặt hàng chọn qua lại.
	if item == 1:
		item = 2
	elif item == 2:
		item = 1 

func _on_sell_button_pressed():
	if item == 1:
		#Nếu người chơi sở hữu mặt hàng 1, gọi hàm sell để bán.
		for harvest in Global.Harvests:
			if harvest["Name"] == "corn":
				coins += harvest["Count"] * 5
			# Đặt màu của node $BuyButtoncolor thành màu xanh, cho biết mặt hàng có thể được mua.
				$SellButtoncolor.color = "353ad31a" #green
			#  Nếu người chơi không đủ tiền, đặt màu nút thành màu đỏ.
			else:
				$SellButtoncolor.color = "35d31a1a" #red
		Global.coins = coins
	elif item == 2:
		for harvest in Global.Harvests:
			if harvest["Name"] == "tomato":
				coins += harvest["Count"] * 8
				harvest["Count"] = 0
				$SellButtoncolor.color = "353ad31a" #green
			#  Nếu người chơi không đủ tiền, đặt màu nút thành màu đỏ.
			else:
				$SellButtoncolor.color = "35d31a1a" #red
		# Update global coins
		Global.coins = coins 

