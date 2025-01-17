{ stdenv
, lib
, meson
, ninja
, pkg-config

, version ? "git"
, debug ? false
}:
stdenv.mkDerivation {
  pname = "fooname";
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

  meta = {
    description = "foodesc";
    mainProgram = "fooname";
    homepage = "https://github.com/spitulax/fooname";
    # license = lib.licenses.;
    # platforms = lib.platforms.;
  };
}
