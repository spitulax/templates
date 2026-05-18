{ self
, pkgs
, mkShell
, clang-tools
, meson
, ninja
, pkg-config
}:
mkShell {
  name = "fooname-shell";
  buildInputs = [
    clang-tools
    meson
    ninja
    pkg-config
  ];
  inputsFrom = [
    self.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
