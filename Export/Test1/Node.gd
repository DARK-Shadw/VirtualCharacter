extends Node

var client = WebSocketPeer.new()
var url = "ws://localhost:5500"

func _ready():
	var err = client.connect_to_url(url)
	if err != OK:
		print("Unable to connect")
		set_process(false)
		
