extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	_create_boundaries()


func get_taskbar_height():
	return DisplayServer.screen_get_size().y - DisplayServer.screen_get_usable_rect().size.y

func _create_taskbar_boundary():
	var staticBody = StaticBody2D.new()
	var taskbar_height = get_taskbar_height()
	var taskbar_width = DisplayServer.screen_get_size().x
	#print("Taskbar Height: ", taskbar_height)
	#print("TaskBar Width: ", taskbar_width)
	#print("DisplayServer Height: ", DisplayServer.screen_get_size())
	
	var shape = RectangleShape2D.new()
	shape.set_size(Vector2(taskbar_width, taskbar_height))
	print(shape.get_size())
	var collision = CollisionShape2D.new()
	collision.shape = shape
	staticBody.add_child(collision)
	staticBody.position = Vector2(taskbar_width/2, (DisplayServer.screen_get_size().y - taskbar_height / 2))
	print(staticBody.position)
	add_child(staticBody)

func _create_boundaries():
	_create_taskbar_boundary()
	#OS.execute()

