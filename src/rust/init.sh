#!/bin/sh

set -ex

source ~/.cargo/env
cargo install cargo-watch
cargo install cargo-expand
# cargo install cargo-edit --features vendored-openssl
rustup component add clippy rustfmt
curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/bin/rust-analyzer
chmod +x ~/bin/rust-analyzer
