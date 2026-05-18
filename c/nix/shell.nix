{ self
, pkgs
, mkShell
, gcc
, clang
, clang-tools
, meson
, ninja
, pkg-config
}:
mkShell {
  name = "fooname-shell";
  buildInputs = [
    gcc
    # clang
    clang-tools
    meson
    ninja
    pkg-config
  ];
  inputsFrom = [
    self.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
