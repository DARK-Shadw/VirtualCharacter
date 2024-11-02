# window_server.py
import socket
import pygetwindow as gw

def get_window_data():
    windows_data = []
    for window in gw.getAllWindows():
        if window.title and not window.isMinimized:
            # Collect window information in CSV format
            if window.top > 0 and window.left > 0:
                windows_data.append(f"{window.title},{window.left},{window.top},{window.width},{window.height}")
    # Join all window data entries into a single string separated by newlines
    return "\n".join(windows_data)

def start_server(host="127.0.0.1", port=65432):
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.bind((host, port))
    server_socket.listen(1)
    print(f"Server started on {host}:{port}")

    try:
        while True:
            client_socket, addr = server_socket.accept()
            print(f"Connection from {addr}")

            # Get window data and send as plain text
            data = get_window_data()
            print("Sending data")
            print(data)
            client_socket.sendall(data.encode('utf-8'))

            # Close connection after sending data
            client_socket.close()
    except KeyboardInterrupt:
        print("\nServer is shutting down...")
    finally:
        server_socket.close()
        print("Server closed.")

if __name__ == "__main__":
    start_server()