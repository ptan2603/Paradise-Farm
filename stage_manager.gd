extends CanvasLayer

const MainMenu = "res://main_menu.tscn"
const MainWorld = "res://world.tscn"

func change_stage(stage_path):
	get_node("ColorRect").show()
	get_node("Label").show()
	var old_layer = layer
	layer = 5
	get_node("AnimationPlayer").play("fade in")
	await get_node("AnimationPlayer").animation_finished
	
	get_tree().change_scene_to_file(stage_path)
	layer = old_layer
	get_node("AnimationPlayer").play("fade out")
