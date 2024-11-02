extends State
class_name StateThrow

@onready var state_machine = $".."

var _velocity = Vector2()
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = Vector2(0, 1000)


func Enter():
	_velocity = state_machine._throw_velocity
	
func Physics_Update(_delta):
	_velocity += gravity * _delta
	owner.velocity = _velocity
	
func Exit():
	owner.velocity = Vector2(0, 0)
	

