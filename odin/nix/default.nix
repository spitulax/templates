{ stdenv
, lib
, odin

, debug ? false
}:
let
  version = lib.trim (lib.readFile ../VERSION);
in
stdenv.mkDerivation rec {
  pname = "foobar";
  inherit version;
  src = lib.cleanSource ./..;

  nativeBuildInputs = [
    odin
  ];

  buildInputs = [

  ];

  buildPhase = ''
    runHook preBuild

    make ${if debug then "debug" else "release"}

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    install -Dm755 build/${pname} -t $out/bin

    runHook postInstall
  '';

}
