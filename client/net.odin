package client

PORT :: 1975

import "../common"
import "core:fmt"
import "core:thread"
import enet "vendor:ENet"

LOCAL_HOST :: common.LOCALHOST
TIMEOUT :: common.TIMEOUT
CONNECT_TRIES :: 5

address: enet.Address
client_host: ^enet.Host
peer: ^enet.Peer
connect_thread: ^thread.Thread
net_thread: ^thread.Thread

net_init :: proc() {
	if enet.initialize() != 0 {
		fmt.eprintln("[CLIENT] An error occured while trying to initialize ENet.")
		return
	}

	client_host = enet.host_create(nil, 1, 2, 0, 0)

	if (client_host == nil) {
		fmt.eprintln("An error occured while trying to create the ENet client host.")
		return
	}

	fmt.println("Successfully initialized client.")

	connect_thread = thread.create_and_start(net_connect_server)
}

net_tick :: proc() {

}


net_connect_server :: proc() {
	event: enet.Event

	enet.address_set_host(&address, cstring(LOCAL_HOST))
	address.port = PORT

	for i in 0 ..< CONNECT_TRIES {
		peer = enet.host_connect(client_host, &address, 1, 0)
		if (peer == nil) {
			fmt.println("No available peers available for a connection.")
			return
		}

		if (enet.host_service(client_host, &event, 1000) > 0 && event.type == .CONNECT) {
			fmt.println("Connected to server.")
			net_thread = thread.create_and_start(net_service_loop)
			return
		} else {
			enet.peer_reset(peer)
			#partial switch event.type {
			case .DISCONNECT:
				fmt.println("Failed to connect to server: Connection refused by server.")
			case .NONE:
				fmt.println("Failed to connect to server: No response from server peer.")
			case:
				fmt.println("Failed to connect to server: Unknown reason.")
			}
		}
	}

	fmt.eprintln("Failed to connect to server.")
}

net_service_loop :: proc() {
	event: enet.Event

	for {
		if enet.host_service(client_host, &event, TIMEOUT) > 0 {
			#partial switch event.type {
			case .RECEIVE:
				fmt.printfln(
					"Recieved packet of length {d} containing {v} on channel {d}.",
					event.packet.dataLength,
					event.packet.data,
					event.channelID,
				)
				enet.packet_destroy(event.packet)
			}
		}
	}
}

net_shutdown :: proc() {
    thread.terminate(connect_thread, 0)
	thread.destroy(connect_thread)
    thread.terminate(net_thread, 0)
	thread.destroy(net_thread)

	enet.host_destroy(client_host)
	enet.deinitialize()
}
