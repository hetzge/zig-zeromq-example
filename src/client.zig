const std = @import("std");

const c = @cImport({
    @cInclude("zmq.h");
});

pub fn main() anyerror!void {
    const context = c.zmq_ctx_new();
    const requester = c.zmq_socket(context, c.ZMQ_REQ);
    const rc = c.zmq_connect(requester, "tcp://localhost:5555");
    defer _ = c.zmq_close(requester);
    defer _ = c.zmq_ctx_destroy(context);

    var request_nbr: usize = 0;
    while (request_nbr < 10) : (request_nbr += 1) {
        var buffer: [100]u8 = undefined;
        std.debug.warn("Sening Hello {}...\n", .{request_nbr});
        _ = c.zmq_send(requester, "Hello", 5, 0);
        _ = c.zmq_recv(requester, &buffer, 10, 0);
        std.debug.warn("Received World {}\n", .{request_nbr});
    }

    std.debug.warn("done\n", .{});
}
