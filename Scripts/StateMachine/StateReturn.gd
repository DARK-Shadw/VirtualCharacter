extends State
class_name StateReturn
@onready var animation_player = %AnimationPlayer
@onready var state_machine = $".."

var dropoff = Vector2()
var speed= 40

func Enter():
	animation_player.play("Return")
	dropoff.x = randf_range(200, DisplayServer.screen_get_size().x - 100)
	dropoff.y = randf_range(100, (DisplayServer.screen_get_size().y / 2) - 50)
	owner.position.x = DisplayServer.screen_get_size().x + 50
	owner.position.y = dropoff.y
	
func Physics_Update(_delta):
	var direction = (dropoff - owner.position).normalized()
	owner.velocity = direction * speed
	
	if owner.position.distance_to(dropoff) < 5:
		state_machine.entered_screen()
