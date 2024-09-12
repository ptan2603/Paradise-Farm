extends Area2D

@onready var player = preload("res://scenes/player/player.tscn")
@onready var timer = $Timer
@onready var plant = $Sprite
var stage = 1
var time = 0.0
var PlantNum = -1

func _ready():
	if time != 0:
		timer.wait_time = time
	if PlantNum == -1:
		PlantNum = Global.Plot.size()
	Global.Plot += [{
		"Seed": "tomato",
		"Time": timer.time_left,
		"Stage": stage,
		"Harvested": false,
	}]

func _process(delta):
	Global.Plot[PlantNum]["Time"] = timer.time_left
	match stage:
		1: 
			plant.frame = stage + 6
		2: 
			plant.frame = stage + 6
		3: 
			plant.frame = stage + 6
		4: 
			plant.frame = stage + 6
		5: 
			plant.frame = stage + 6
		6:
			plant.frame = 11
	
func _on_timer_timeout():
	if stage <= 5:
		stage += 1
	Global.Plot[PlantNum]["Stage"] = stage

func _on_body_entered(body):
	var has_item = false
	if stage >= 5:
		if body.name == "player":
			for i in Global.Harvests.size():
				if "tomato" in Global.Harvests[i]["Name"]:
					has_item = true
				
			if has_item:
				for i in Global.Harvests.size():
					if "tomato" == Global.Harvests[i]["Name"]:
						Global.Harvests[i]["Count"] += 1
			else:
				Global.Harvests += [{
					"Name": "tomato",
					"Count": 1,
					"Consumable": true,
				}]
			Global.Plot[PlantNum]["Harvested"] = true
			get_parent().has_seed = false
			queue_free()
