#[bind] broadcast(message string, payload *void)
#[bind] subscribe(message string, userdata ?*void, callback MessageCallback)

type MessageCallback = fn (payload *void)
