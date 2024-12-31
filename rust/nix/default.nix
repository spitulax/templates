{ lib
, rustPlatform
, debug ? false
}:
let
  version = lib.pipe (lib.readFile ../Cargo.toml) [
    (lib.match "^.*\nversion = \"([0-9]+\.[0-9]+\.[0-9]+)\".*$")
    lib.head
  ];
in
rustPlatform.buildRustPackage ({
  pname = "foobar";
  inherit version;
  src = lib.cleanSource ./..;

  cargoLock = {
    lockFile = ../Cargo.lock;
    allowBuiltinFetchGit = true;
  };
} // (
  if debug then {
    buildType = "debug";
    dontStrip = true;
  }
  else { }
))
