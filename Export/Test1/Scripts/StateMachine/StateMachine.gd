extends Node

@export var initial_state: State
@onready var animation_player = %AnimationPlayer

# CHARACTER ATTRIBUTES
var boredom: float = 0
var curiosity: float = 0
var excitement: float = 0

# THRESHOLD
const BOREDOM_THRESHOLD:= 50
const CURIOSITY_THRESHOLD:= 30
const EXCITEMENT_THRESHOLD:= 60


var current_state: State
var states: Dictionary = {}

var dragging:= false


func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transitioned)
	if initial_state:
		initial_state.Enter()
		current_state = initial_state

func _process(delta):
	_player_not_on_ground()
	_manage_attributes(delta)
	_update_state_by_attributes()
	_chase_state()
	if current_state:
		current_state.Update(delta)

func _physics_process(delta):
	if current_state:
		current_state.Physics_Update(delta)
	
func on_child_transitioned(state, new_state_name):
	if state != current_state:
		return
		
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state == new_state:
		return
	
	if current_state:
		current_state.Exit()
	
	new_state.Enter()
	current_state = new_state
	print("State changed to: ", current_state.name)

func _get_current_state():
	return current_state.name.to_lower()

# for drag
func _on_button_button_down():
	dragging = true
	on_child_transitioned(current_state, "drag")

# for drag release
func _on_button_button_up():
	dragging = false
	on_child_transitioned(current_state, "fall")

func _chase_state():
	var follow_threshold = 100
	if curiosity < CURIOSITY_THRESHOLD:
		return
	var mouse_x = owner.get_global_mouse_position().x
	var player_x = owner.global_position.x
	if abs(mouse_x - player_x) <= follow_threshold:
		on_child_transitioned(current_state, "chase")
	else:
		curiosity = 0
		_update_state_by_attributes()

func _player_not_on_ground():
	if not owner.is_on_floor() and not dragging:
		on_child_transitioned(current_state, "fall")
	elif owner.is_on_floor() and _get_current_state() == "fall":
		on_child_transitioned(current_state, "idle")
		_update_state_by_attributes()
		
func _manage_attributes(_delta):
	if _get_current_state() == "idle":
		boredom += _delta * 10
		curiosity += _delta * 15
	elif _get_current_state() == "wander":
		boredom += _delta * 2
	else:
		boredom = max(boredom - _delta * 5, 0)
	
	
	if _get_current_state() == "wander":
		curiosity += _delta * 5
	else:
		curiosity = max(curiosity - _delta * 5, 0)
		
	if _get_current_state() in ["idle", "wander", "chase"]:
		excitement -= _delta * 3
		
	if _get_current_state() == "drag":
		excitement += _delta * 5
	

func _update_state_by_attributes():
	if boredom > BOREDOM_THRESHOLD and _get_current_state() == "idle":
		on_child_transitioned(current_state, "wander")
		boredom = 0
	elif boredom > BOREDOM_THRESHOLD and _get_current_state() == "wander":
		on_child_transitioned(current_state, "idle")
		boredom = 0
	elif curiosity > CURIOSITY_THRESHOLD and _get_current_state() == "idle":
		# we can setup something like oushing here
		pass
	elif excitement > EXCITEMENT_THRESHOLD:
		pass


