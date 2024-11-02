extends Node

# CHARACTER ATTRIBUTES
var boredom: float = 0
var curiosity: float = 0
var excitement: float = 0

# THRESHOLD
const BOREDOM_THRESHOLD:= 50
const CURIOSITY_THRESHOLD:= 30
const EXCITEMENT_THRESHOLD:= 60

@onready var state_machine = $"../StateMachine"

func _process(delta):
	_manage_attributes(delta)

		
func _manage_attributes(_delta):
	if state_machine._get_current_state() == "idle":
		boredom += _delta * 10
	else:
		boredom = max(boredom - _delta * 5, 0)
	
	if state_machine._get_current_state() == "wander":
		curiosity += _delta * 5
	else:
		curiosity = max(curiosity - _delta * 5, 0)
		
	if state_machine._get_current_state() in ["idle", "wander"]:
		excitement -= _delta * 3

func _update_state_by_attributes():
	if boredom > BOREDOM_THRESHOLD and state_machine._get_current_state() == "idle":
		state_machine.on_child_transitioned(state_machine.current_state, "wander")
	elif curiosity > CURIOSITY_THRESHOLD and state_machine._get_current_state() == "idle":
		# we can setup something like oushing here
		pass
	elif excitement > EXCITEMENT_THRESHOLD:
		pass
