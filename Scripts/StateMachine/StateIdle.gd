extends State
class_name StateIdle
@onready var animation_player = $"../../AnimationPlayer"

var wave_time:float

func randomize_time():
	wave_time = randf_range(5, 8)

func Enter():
	animation_player.play("Idle")
	
func Update(delta):
	if wave_time > 0:
		wave_time -= delta
	else:
		animation_player.play("Wave")
		randomize_time()

