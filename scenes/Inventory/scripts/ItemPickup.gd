extends Node2D
class_name ItemPickup

@export var item_data : ResourceItem : set = _set_item_data

@onready var area_2d: Area2D = $Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var audio_steam_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
# Called when the node enters the scene tree for the first time.
func _ready():
	_update_texture()
	if Engine.is_editor_hint():
		pass
	area_2d.body_entered.connect(_on_body_entered)
	pass

func _on_body_entered(b):
	if b is Player:
		if item_data:
			if PlayerManager.INVENTORY_DATA.add_item(item_data) == true:
				item_picked_up()
	pass

func item_picked_up():
	area_2d.body_entered.disconnect(_on_body_entered)
	audio_steam_player_2d.play()
	visible = false
	await audio_steam_player_2d.finished
	queue_free()
	pass
	
func _set_item_data(value: ResourceItem):
	item_data = value
	_update_texture()
	pass

func _update_texture():
	if item_data and sprite_2d:
		sprite_2d.texture = item_data.texture
	pass

