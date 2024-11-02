extends State
class_name StateDrag

@onready var animationplayer: AnimationPlayer = $%AnimationPlayer
@onready var state_machine = $".."



var offset = Vector2(0,0)

func Enter():
	animationplayer.play("Hang")
	offset = owner.get_global_mouse_position() - owner.global_position

func Physics_Update(_delta: float):
	owner.position = owner.get_global_mouse_position() - offset

