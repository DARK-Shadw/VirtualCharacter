extends State
class_name StateFall

@onready var animation_player: AnimationPlayer = $%AnimationPlayer

var landing:= false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func Enter():
	animation_player.play("Fall")

func Physics_Update(_delta):
	if not owner.is_on_floor():
		owner.velocity.y += gravity * _delta

func Exit():
	owner.velocity = Vector2(0,0)
	
