extends Node

# What region will we be connecting to?
var region: String = "Local"

# Dictionary of server regions containing their matching IP/port
var _server_dict: Dictionary = {
	"Local": ["127.0.0.1", 65432]
}

var connection: StreamPeerTCP
var connected: bool = false

func _ready():
	var code = connect_to_server()
	print(code)
	var respose = get_data_from_server()
	var strings = []
	var string = ""
	print(respose)
	

func connect_to_server() -> String:
	# Retrieve IP and port based on region
	var ip = _server_dict[region][0]
	var port = _server_dict[region][1]

	# Initialize and connect the StreamPeerTCP
	connection = StreamPeerTCP.new()
	connection.connect_to_host(ip, port)
	connection.poll()  # Process connection requests

	# Check connection status and return appropriate message
	if connection.get_status() == StreamPeerTCP.STATUS_CONNECTED:
		connected = true
		return "Successfully connected to server " + ip + ":" + str(port)
	elif connection.get_status() == StreamPeerTCP.STATUS_CONNECTING:
		return "Attempting to connect to server " + ip + ":" + str(port)
	else:
		connected = false
		return "Error connecting to server " + ip + ":" + str(port)

func get_data_from_server() -> String:
	if not connected:
		return "Not connected to any server."

	# Poll the connection and check for available data
	connection.poll()
	var available_bytes: int = connection.get_available_bytes()
	print("availaable bytes: ", available_bytes)
	if available_bytes > 0:
		var data: Array = connection.get_partial_data(available_bytes)
		
		# Check for any read errors
		if data[0] != OK:
			return "Error getting data from stream: " + str(data[0])
		else:
			# Return the received data as a UTF-8 string
			return data[1].get_string_from_utf8()
	else:
		return "No data available from server."
