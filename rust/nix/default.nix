{ lib
, rustPlatform
, debug ? false
}:
let
  version = (lib.importTOML ../Cargo.toml).package.version;
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
