package server

import "core:fmt"
import enet "vendor:ENet"
import "../common"

LOCAL_HOST :: "localhost"
PORT :: common.PORT
TIMEOUT :: common.TIMEOUT
PEER_COUNT :: 8

address : enet.Address
server_host : ^enet.Host
event : enet.Event

net_init :: proc() {
    _ = enet.initialize()

    address.host = enet.HOST_ANY
    address.port = PORT

    server_host = enet.host_create(&address, PEER_COUNT, 2, 0, 0)

    if (server_host == nil) {
        fmt.eprintln("An error occured while trying to create the ENet server host.")
        return
    }

    fmt.println("Successfully initialized server.")
}

net_tick :: proc() {
    if enet.host_service(server_host, &event, TIMEOUT) > 0 {
        switch event.type {
            case .CONNECT:
                fmt.printfln("A new client has connected from {d}:{d}", 
                    event.peer.address.host,
                    event.peer.address.port,
                )
            case .DISCONNECT:
                fmt.println("A client has disconnected.")
            case .RECEIVE:
                fmt.printfln("Recieved packet of length {d} ontaining {v} on channel {d}.", 
                    event.packet.dataLength,
                    event.packet.data,
                    event.channelID,
                )
                enet.packet_destroy(event.packet)
            case.NONE:
        }
    }
}

net_shutdown :: proc() {
    enet.host_destroy(server_host)
}
