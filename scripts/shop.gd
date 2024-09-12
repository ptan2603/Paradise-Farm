extends StaticBody2D

func _ready():
	$npc.play("default")
	$shopmenu.visible = false
	
func _process(delta):
	if Global.weather == "rain":
		$npc.visible = false
		$shopmenu.visible = false
	elif Global.weather == "none":
		$npc.visible = true

	if $shopmenu.item1owned == true and $PickupCornSeedpack != null:
		$PickupCornSeedpack.visible = true
	if $shopmenu.item2owned == true:
		print("randomseedpack swaping in")

func _on_area_2d_body_entered(body):
	if body.has_method("player_shop_method"):
		$shopmenu.visible = true

func _on_area_2d_body_exited(body):
	$shopmenu.visible = false

