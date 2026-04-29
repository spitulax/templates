#!/usr/bin/env bash

set -euo pipefail

WINSYSROOT_DIR=${1:-"$HOME/.local/share/xwin"}
WINSYSROOT_INI="$(dirname "$0")/winsysroot.ini"

cat << EOF > "$WINSYSROOT_INI"
[binaries]
c = [
    'clang-cl',
    '--target=x86_64-pc-windows-msvc',
    '-imsvc', '$WINSYSROOT_DIR/crt/include',
    '-imsvc', '$WINSYSROOT_DIR/sdk/include/ucrt',
    '-imsvc', '$WINSYSROOT_DIR/sdk/include/shared',
    '-imsvc', '$WINSYSROOT_DIR/sdk/include/um'
  ]
cpp = [
    'clang-cl',
    '--target=x86_64-pc-windows-msvc',
    '-imsvc', '$WINSYSROOT_DIR/crt/include',
    '-imsvc', '$WINSYSROOT_DIR/sdk/include/ucrt',
    '-imsvc', '$WINSYSROOT_DIR/sdk/include/shared',
    '-imsvc', '$WINSYSROOT_DIR/sdk/include/um'
  ]

[built-in options]
c_link_args = [
    '/LIBPATH:$WINSYSROOT_DIR/crt/lib/x64',
    '/LIBPATH:$WINSYSROOT_DIR/sdk/lib/ucrt/x64',
    '/LIBPATH:$WINSYSROOT_DIR/sdk/lib/um/x64'
  ]
cpp_link_args = [
    '/LIBPATH:$WINSYSROOT_DIR/crt/lib/x64',
    '/LIBPATH:$WINSYSROOT_DIR/sdk/lib/ucrt/x64',
    '/LIBPATH:$WINSYSROOT_DIR/sdk/lib/um/x64'
  ]
EOF

echo "$WINSYSROOT_INI created successfully."
