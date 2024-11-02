extends State
class_name StateChase

@onready var animation_player = %AnimationPlayer
@onready var state_machine = $".."

var move_speed := 40.0
var follow_threshold:= 60

func Enter():
	animation_player.play("Walk")

func Physics_Update(_delta):
	var mouse_x = owner.get_global_mouse_position().x
	var player_x = owner.global_position.x
	if abs(mouse_x - player_x) <= follow_threshold:
		owner.velocity.x = sign(mouse_x - player_x) * move_speed
	else:
		owner.velocity = Vector2(0, 0)
		state_machine.on_child_transitioned(state_machine.current_state, "idle")
