extends StaticBody2D
# khởi tạo biến với giá trị 1, đại diện cho mặt hàng hiện tại được chọn
var item = 1

# khai báo 2 biến  với giá trị của 2 mặt hàng item1 = 100 và item2 = 250
var item1price = 100
var item2price = 250

# Khởi tạo hai biến boolean để theo dõi quyền sở hữu mặt hàng: 
# cả hai đều được đặt thành false, nghĩa là người chơi chưa sở hữu mặt hàng nào.
var item1owned = false
var item2owned = false

# Khai báo biến price sẽ được sử dụng để lưu giá của mặt hàng đang được mua.
var price

func ready():
	# Phát animation hoặc hiệu ứng hình ảnh liên quan đến node icon, cụ thể là animation "cornseed".
	$icon.play("cornseed")
	# Đặt mặt hàng hiện đang chọn trở lại 1 khi node sẵn sàng.
	item = 1

func _physics_process(delta):
	# Kiểm tra xem node hiện tại có hiển thị hay không.
	if self.visible == true:
		# Kiểm tra xem mặt hàng hiện đang chọn có phải là 1 hay không.
		if item == 1:
			$icon.play("cornseed")
			#Đặt văn bản của node $pricelabel để hiển thị giá của mặt hàng 1.
			$pricelabel.text = "100"
			# Kiểm tra xem người chơi có đủ tiền để mua mặt hàng 1 không.
			if Global.coins >= item1price:
			# Kiểm tra xem mặt hàng 1 có chưa được sở hữu hay không.
				if item1owned == false:
			# Đặt màu của node $BuyButtoncolor thành màu xanh, cho biết mặt hàng có thể được mua.
					$BuyButtoncolor.color = "353ad31a" #green
				else: 
					$BuyButtoncolor.color = "35d31a1a" #red
			#  Nếu người chơi không đủ tiền, đặt màu nút thành màu đỏ.
			else:
				$BuyButtoncolor.color = "35d31a1a" #red
		if item == 2:
			$icon.play("randomseed")
			$pricelabel.text = "250"
			if Global.coins >= item2price:
				if item1owned == false:
					$BuyButtoncolor.color = "353ad31a" #green
				else: 
					$BuyButtoncolor.color = "35d31a1a" #red
			else:
				$BuyButtoncolor.color = "35d31a1a" #red
func _on_buttonleft_pressed():
	swap_item_back()

func _on_buttonright_pressed():
	swap_item_forward()

func _on_buy_button_pressed():
	#Nếu mặt hàng được chọn là 1, đặt biến price thành giá của mặt hàng 1.
	if item == 1:
		price = item1price
		# Kiểm tra xem người chơi có đủ tiền để mua mặt hàng 1 không.
		if Global.coins >= price:
		#Nếu người chơi không sở hữu mặt hàng 1, gọi hàm buy để mua.
			if item1owned == false:
				buy()
	# Nếu mặt hàng được chọn là 2, đặt biến price thành giá của mặt hàng 2.
	elif item == 2:
		price = item2price
		# Kiểm tra xem người chơi có đủ tiền để mua mặt hàng 2 không.
		if Global.coins >= price:
		# Nếu người chơi không sở hữu mặt hàng 2, gọi hàm buy để mua.
			if item2owned == false:
				buy()
	
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

func buy():
	# Trừ giá của mặt hàng từ tổng số tiền của người chơi.
	Global.coins -= price 
	# Nếu mặt hàng 1 được mua, đặt item1owned thành true.
	if item == 1:
		item1owned = true
	# Nếu mặt hàng 2 được mua, đặt item2owned thành true.
	if item == 2:
		item2owned = true
