extends TileMap
class_name LevelTileMap

func _ready():
	# truyền vào các giới hạn hiện tại của tilemap
	LevelManager.ChangeTilemapBounds(GetTilemapBounds())
	pass # Replace with function body.

# hàm đại diện cho tọa độ của góc trên trái và góc dưới phải.
func GetTilemapBounds() -> Array[Vector2] :
	# biến có mảng rỗng để chứa tọa độ giới hạn
	var bounds : Array[Vector2] = []
	# thêm tọa độ của góc trên trái của tilemap
	bounds.append(
		Vector2(get_used_rect().position * rendering_quadrant_size)
	)
	# thêm tọa độ của góc dưới phải của tilemap
	bounds.append(
		Vector2(get_used_rect().end * rendering_quadrant_size)
	)
	return bounds
