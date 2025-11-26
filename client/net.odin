package client

PORT :: 1975

import "core:fmt"
import enet "vendor:ENet"

client_host : ^enet.Host

net_init :: proc() {
    _ = enet.initialize()
    
    client_host = enet.host_create(nil, 1, 2, 0, 0)

    if (client_host == nil) {
        fmt.eprintln("An error occured while trying to create the ENet client host.")
        return
    }

    fmt.println("Successfully initialized client.")
}


net_shutdown :: proc() {
    enet.host_destroy(client_host)
}
