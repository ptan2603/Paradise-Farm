extends CharacterBody2D

class_name chicken

enum ChickenState  {EAT, WALK}

@export var move_speed : float = 20.0

@onready var animation = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

var move_direction : Vector2 = Vector2.ZERO
var xdir = 1  # 1 == right, -1 == left
var ydir = 1  # 1 == down, -1 == up
var current_state : ChickenState = ChickenState.EAT
var moving_vertical_horizontal = 1  # 1 = horizontal, 2 = vertical

func _ready(): 
	randomize()
	select_new_direction()
	
func _physics_process(delta):
	velocity = move_direction * move_speed
	update_animation()
	move_and_slide()
	
func select_new_direction():
	var x = randf_range(1, 2)
	var y = randf_range(1, 2)
	
	if x > 1.5:
		xdir = 1 # right
	else:
		xdir = -1 # left

	if y > 1.5:
		ydir = 1 # down
	else:
		ydir = -1 # up
	move_direction = Vector2(
		randi_range(-1, 1),
		randi_range(-1, 1)
	).normalized() # Normalized to ensure consistent speed
	
func pick_new_state():
	if current_state == ChickenState.EAT:
		current_state = ChickenState.WALK
	elif current_state == ChickenState.WALK:
		current_state = ChickenState.EAT

func update_animation():
	if current_state == ChickenState.EAT:
		if abs(move_direction.x) > abs(move_direction.y):
			if move_direction.x > 0:
				animation.play("eat_right")
			else:
				animation.play("eat_left")
		else:
			if move_direction.y > 0:
				animation.play("eat_down")
			else:
				animation.play("eat_up")
	elif current_state == ChickenState.WALK:
		if abs(move_direction.x) > abs(move_direction.y):
			if move_direction.x > 0:
				animation.play("walk_right")
			else:
				animation.play("walk_left")
		else:
			if move_direction.y > 0:
				animation.play("walk_down")
			else:
				animation.play("walk_up")


func _on_changestatertimer_timeout():
	var waittime = 1
	if current_state == ChickenState.WALK:
		current_state = ChickenState.EAT
		waittime = randf_range(1, 5)
	elif current_state == ChickenState.EAT:
		current_state = ChickenState.WALK
		waittime = randf_range(2, 6)
	$changestatertimer.wait_time = waittime
	$changestatertimer.start()

func _on_walkingtimer_timeout():
	select_new_direction()
	$walkingtimer.wait_time = randf_range(1, 4)
	$walkingtimer.start()
