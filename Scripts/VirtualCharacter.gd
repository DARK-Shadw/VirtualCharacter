extends AnimatedSprite2D

@onready var animation_player = $AnimationPlayer
@export var DEBUG: bool = false

var speed = 120 # Speed in pixels per second
var scale_factor = 2.0 # Scale factor for the sprite
var horizontal_shrink_factor = 0.5 # Reduce the horizontal size to 50%
var texture_corners: PackedVector2Array = PackedVector2Array()

func _ready():
	animation_player.play("Walk")
	

func _process(delta):
	position.x += speed * delta
	set_passthrough(self)
	#if DEBUG:
		#queue_redraw()

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

#func _draw():
	## Draw the passthrough area borders for debugging
	#print("why are u running?")
	#if texture_corners.size() == 4:
		#for i in range(texture_corners.size()):
			#var next = (i + 1) % texture_corners.size()
			#draw_line(to_local(texture_corners[i]), to_local(texture_corners[next]), Color(1, 0, 0), 2) # Red border
