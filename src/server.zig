const std = @import("std");

const c = @cImport({
    @cInclude("zmq.h");
});

pub fn main() anyerror!void {
    const context = c.zmq_ctx_new();
    const responder = c.zmq_socket(context, c.ZMQ_REP);
    const rc = c.zmq_bind(responder, "tcp://*:5555");
    if (rc != 0) {
        @panic("failed to bind zero mq");
    }

    while (true) {
        var buffer: [100]u8 = undefined;
        _ = c.zmq_recv(responder, &buffer, 100, 0);
        std.debug.warn("Received Hello\n", .{});
        _ = c.zmq_send(responder, "World", 5, 0);
    }

    std.debug.warn("done\n", .{});
}
