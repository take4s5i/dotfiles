#!/bin/sh

set -ex

source ~/.cargo/env
cargo install cargo-watch
cargo install cargo-expand
# cargo install cargo-edit --features vendored-openssl
rustup component add clippy rustfmt
