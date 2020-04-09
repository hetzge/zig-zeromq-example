const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    create_exe(b, "server", "src/server.zig");
    create_exe(b, "client", "src/client.zig");
}

fn create_exe(b: *Builder, name: []const u8, entry_point: []const u8) void {
    const exe = b.addExecutable(name, entry_point);
    exe.setBuildMode(b.standardReleaseOptions());
    exe.addIncludeDir("include");
    exe.linkSystemLibrary("c");
    exe.linkSystemLibrary("zmq");
    exe.install();
}
