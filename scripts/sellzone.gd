extends StaticBody2D

func _ready():
	$npc.play("default")
	$menusell.visible = false
	
func _process(delta):
	if Global.weather == "rain":
		if $npc:
			$npc.visible = false
		if $menusell:
			$menusell.visible = false
	elif Global.weather == "none":
		if $npc:
			$npc.visible = true
		if $menusell:
			$menusell.visible = true
		
func _on_area_2d_body_entered(body):
	if body.has_method("player_shop_method"):
		$menusell.visible = true
	
func _on_area_2d_body_exited(body):
	$menusell.visible = false
