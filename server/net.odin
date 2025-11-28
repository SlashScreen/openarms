package server

import cm "../common"
import "core:encoding/cbor"
import "core:fmt"
import "core:strings"
import "core:thread"
import enet "vendor:ENet"

LOCAL_HOST :: cm.LOCALHOST
PORT :: cm.PORT
TIMEOUT :: cm.TIMEOUT
PEER_COUNT :: 8

address: enet.Address
server_host: ^enet.Host
net_thread: ^thread.Thread
early_exit := false

DataPacket :: struct {
	header: string,
	data:   any,
}

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

	for !early_exit {
		if enet.host_service(server_host, &event, TIMEOUT) > 0 {
			#partial switch event.type {
			case .CONNECT:
				fmt.printfln(
					"A new client has connected from %d:%d",
					event.peer.address.host,
					event.peer.address.port,
				)
				net_share_state(event.peer)
			case .DISCONNECT:
				fmt.println("A client has disconnected.")
			case .RECEIVE:
				fmt.printfln(
					"Recieved packet of length %d containing %q on channel %d.",
					event.packet.dataLength,
					strings.string_from_ptr(event.packet.data, int(event.packet.dataLength)),
					event.channelID,
				)
				enet.packet_destroy(event.packet)
			}
		}
	}
}

net_send_all :: proc(data_packet: cm.NetCommand) {
	encoded, err := cm.serialize_command_packet(data_packet)
	if err != nil {
		fmt.eprintfln("[SERVER] failed to marshal packet: %s", err)
		return
	}
	packet := enet.packet_create(raw_data(encoded), len(encoded) + 1, enet.PacketFlags{.RELIABLE})
	enet.host_broadcast(server_host, 0, packet)
}

net_send_peer :: proc(data_packet: cm.NetCommand, who: ^enet.Peer) {
	encoded, err := cm.serialize_command_packet(data_packet)
	if err != nil {
		fmt.eprintfln("[SERVER] failed to marshal packet: %s", err)
		return
	}
	packet := enet.packet_create(raw_data(encoded), len(encoded), enet.PacketFlags{.RELIABLE})
	_ = enet.peer_send(who, 0, packet)
}

net_shutdown :: proc() {
	early_exit = true
	thread.destroy(net_thread)

	enet.host_destroy(server_host)
	enet.deinitialize()
}

net_share_state :: proc(peer: ^enet.Peer) {
	data := sim_gather_keyframe_for_all()
	defer delete(data)

	net_send_peer(cm.KeyframeCommand{data}, peer)
}
