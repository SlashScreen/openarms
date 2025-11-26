package server

import "../common"
import "core:fmt"
import "core:thread"
import enet "vendor:ENet"

LOCAL_HOST :: common.LOCALHOST
PORT :: common.PORT
TIMEOUT :: common.TIMEOUT
PEER_COUNT :: 8

address: enet.Address
server_host: ^enet.Host
net_thread: ^thread.Thread

net_init :: proc() {
	if enet.initialize() != 0 {
		fmt.eprintln("[SERVER] An error occured while trying to initialize ENet.")
		return
	}

	address.host = enet.HOST_ANY
	address.port = PORT

	server_host = enet.host_create(&address, PEER_COUNT, 2, 0, 0)

	if (server_host == nil) {
		fmt.eprintln("An error occured while trying to create the ENet server host.")
		return
	}

	fmt.println("Successfully initialized server.")

	net_thread = thread.create_and_start(net_service_loop)
}

net_tick :: proc() {

}

net_service_loop :: proc() {
    event: enet.Event

	for {
		if enet.host_service(server_host, &event, TIMEOUT) > 0 {
			#partial switch event.type {
			case .CONNECT:
				fmt.printfln(
					"A new client has connected from %d:%d",
					event.peer.address.host,
					event.peer.address.port,
				)
			case .DISCONNECT:
				fmt.println("A client has disconnected.")
			case .RECEIVE:
				fmt.printfln(
					"Recieved packet of length %d containing %v on channel %d.",
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
    thread.terminate(net_thread, 0)
    thread.destroy(net_thread)

	enet.host_destroy(server_host)
	enet.deinitialize()
}
