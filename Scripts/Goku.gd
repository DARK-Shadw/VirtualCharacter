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

func _ready():
	animationplayer.play("Idle")

func _physics_process(_delta):
	if velocity.x > 0:
		sprite_2d.flip_h = false
	else:
		sprite_2d.flip_h = true

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

