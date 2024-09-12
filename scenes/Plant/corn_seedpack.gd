extends Area2D

@onready var player = preload("res://scenes/player/player.tscn")

func _on_body_entered(body):
	if body.name == "player":
		queue_free()
