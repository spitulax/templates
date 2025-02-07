{ lib
, rustPlatform
, version ? "git"

, debug ? false
}:
rustPlatform.buildRustPackage ({
  pname = "fooname";
  inherit version;
  src = lib.cleanSource ./..;

  cargoLock = {
    lockFile = ../Cargo.lock;
    allowBuiltinFetchGit = true;
  };

  meta = {
    description = "foodesc";
    mainProgram = "fooname";
    homepage = "https://github.com/spitulax/fooname";
    # license = lib.licenses.;
    # platforms = lib.platforms.;
  };
} // (
  if debug then {
    buildType = "debug";
    dontStrip = true;
  }
  else { }
))
