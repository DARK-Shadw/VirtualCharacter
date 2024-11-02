extends State
class_name StateWander

@export var character: CharacterBody2D
@export var move_speed:= 10.0

var move_direction: Vector2
var wander_time: float
@onready var animation_player = %AnimationPlayer

func randomize_wander():
	move_direction = Vector2(randf_range(-1, 1), 0).normalized()
	wander_time = randf_range(1, 3)
	
func Enter():
	randomize_wander()
	animation_player.play("Walk")
	

func Update(_delta: float):
	if wander_time > 0:
		wander_time -= _delta
	else:
		randomize_wander()

func Physics_Update(_delta: float):
	if character:
		character.velocity = move_direction * move_speed

func Exit():
	if character:
		character.velocity = Vector2(0, 0)
