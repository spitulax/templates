#![warn(
    rust_2018_idioms,
    rust_2018_compatibility,
    missing_debug_implementations,
    clippy::shadow_same,
    clippy::shadow_reuse,
    clippy::shadow_unrelated
)]

const PROG_VERSION: &str = env!("CARGO_PKG_VERSION");

pub fn print() {
    println!("Hello, Rust! fooname version {PROG_VERSION}");
}
