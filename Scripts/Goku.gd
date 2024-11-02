extends CharacterBody2D

@onready var sprite_2d = $Sprite2D
@onready var animationplayer = $AnimationPlayer
@onready var state_machine = $StateMachine


var speed = 120 # Speed in pixels per second
# Variables for passthrough
var scale_factor = 0.45# Scale factor for the sprite
var horizontal_shrink_factor = 0.89# Reduce the horizontal size to 50%
var texture_corners: PackedVector2Array = PackedVector2Array()

#Throw Variables
var dragging = false
var previous_position: Vector2
var throw_velocity: Vector2
#
## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animationplayer.play("Idle")
	


func _physics_process(delta):
	
	#if not is_on_floor():
		#state_machine.on_child_transitioned(state_machine.current_state, "fall")
	
	#if velocity.length() > 0:
		#animationplayer.play("Walk")
	#elif velocity.length() == 0:
		#animationplayer.play("Idle")
		
	if velocity.x > 0:
		sprite_2d.flip_h = false
	else:
		sprite_2d.flip_h = true	
	
	#if dragging:
		#animationplayer.play("Idle")
		## Calculate throw velocity based on mouse movement
		#throw_velocity = (get_global_mouse_position() - previous_position) / delta
		## Update position to follow mouse
		#global_position = get_global_mouse_position()
		#previous_position = global_position
	#
	#
	#
	## Add the gravity.
	#else:
		#animationplayer.play("Walk")
		#if not is_on_floor():
			#velocity.y += gravity * delta
		#else:
			#position.x += speed * delta
	set_passthrough(sprite_2d)
	move_and_slide()
	
func set_passthrough(sprite: AnimatedSprite2D):
	# Get the texture of the current frame
	var frame_texture = sprite.get_sprite_frames().get_frame_texture(sprite.animation, sprite.get_frame())
	var frame_size = frame_texture.get_size() * scale_factor
	var shrunk_frame_width = frame_size.x * horizontal_shrink_factor
	var top_left = sprite.global_position - Vector2(shrunk_frame_width / 2, frame_size.y / 2)
	texture_corners = PackedVector2Array([
		top_left,
		top_left + Vector2(shrunk_frame_width, 0),         # Top right with shrunk width
		top_left + Vector2(shrunk_frame_width, frame_size.y), # Bottom right with shrunk width
		top_left + Vector2(0, frame_size.y)                 # Bottom left
	])
	DisplayServer.window_set_mouse_passthrough(texture_corners)
	


#func _input(event):
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_LEFT:
			#if event.pressed and get_global_mouse_position().distance_to(global_position) < 20:
				#dragging = true
			#else:
				#dragging = false
				## Throw the character if released
				#velocity = throw_velocity

#func _draw():
	## Draw the passthrough area borders for debugging
	#print("why are u running?")
	#if texture_corners.size() == 4:
		#for i in range(texture_corners.size()):
			#var next = (i + 1) % texture_corners.size()
			#draw_line(to_local(texture_corners[i]), to_local(texture_corners[next]), Color(1, 0, 0), 2) # Red border
#
