{ stdenv
, lib
, meson
, ninja
, pkg-config

, debug ? false
}:
let
  version = lib.trim (lib.readFile ../VERSION);
in
stdenv.mkDerivation {
  pname = "foobar";
  inherit version;
  src = lib.cleanSource ./..;

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
  ];

  buildInputs = [

  ];

  mesonBuildType = if debug then "debug" else "release";
}
