package common

Subscriber :: struct {
	userdata: rawptr,
	callback: proc(self: rawptr, event: rawptr),
}

MessageBus :: struct {
	subscriptions: map[string][dynamic]Subscriber,
}

NIL_USERDATA : ^int : (^int)(uintptr(0))
NIL_MESSAGE : ^int : (^int)(uintptr(0))

message_bus: MessageBus

message_bus_create :: proc() {
	message_bus = MessageBus{make(map[string][dynamic]Subscriber)}
}

message_bus_destroy :: proc() {
	delete(message_bus.subscriptions)
}

message_bus_subscribe :: proc(event: string, subscription: Subscriber) {
	if lst, ok := message_bus.subscriptions[event]; ok {
		append(&lst, subscription)
	} else {
		n_lst := make([dynamic]Subscriber)
		append(&n_lst, subscription)
		message_bus.subscriptions[event] = n_lst
	}
}

subscribe :: proc(event: string, userdata: ^$U, $callback: proc(^U, ^$E)) {
	w_callback := proc(self: rawptr, event: rawptr) {
		callback((^U)(self), (^E)(event))
	}

	subscription := Subscriber {
		rawptr(userdata),
		w_callback,
	}

	message_bus_subscribe(event, subscription)
}

broadcast :: proc(event: string, data: ^$E) {
	if lst, ok := message_bus.subscriptions[event]; ok {
		for s in lst {
			s.callback(s.userdata, rawptr(data))
		}
	}
}
