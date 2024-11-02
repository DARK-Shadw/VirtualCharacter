extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	_initialize_canvas()
	
func _initialize_canvas():
	get_tree().get_root().set_transparent_background(true)
	
	var window: Window = get_window()
	window.size = Vector2i(DisplayServer.screen_get_size() + Vector2i(1, 1))
	window.position = DisplayServer.screen_get_position()
	window.always_on_top = true
