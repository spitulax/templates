{ stdenv
, lib
, odin
, version ? "git"

, debug ? false
}:
stdenv.mkDerivation {
  pname = "fooname";
  inherit version;
  src = lib.cleanSource ./..;

  nativeBuildInputs = [
    odin
  ];

  buildInputs = [

  ];

  makeFlags = [
    (if debug then "debug" else "release")
  ];

  installFlags = [
    "install"
    "PREFIX=$(out)"
  ];

  meta = {
    description = "foodesc";
    mainProgram = "fooname";
    homepage = "https://github.com/spitulax/fooname";
    # license = lib.licenses.;
    # platforms = lib.platforms.;
  };
}
