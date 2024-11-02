extends State
class_name StateDrag

@onready var animationplayer: AnimationPlayer = $%AnimationPlayer
@onready var state_machine = $".."



var offset = Vector2(0,0)
var previous_mouse_position = Vector2()
var _velocity = Vector2()

func Enter():
	animationplayer.play("Hang")
	offset = owner.get_global_mouse_position() - owner.global_position
	previous_mouse_position = owner.get_global_mouse_position()

func Physics_Update(_delta: float):
	var current_mouse_position = owner.get_global_mouse_position()
	owner.position = current_mouse_position - offset
	
	_velocity = (current_mouse_position - previous_mouse_position)/_delta
	previous_mouse_position = current_mouse_position
	
	state_machine._throw_velocity =	_velocity

