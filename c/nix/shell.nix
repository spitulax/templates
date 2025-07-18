{ self
, pkgs
, mkShell
, man-pages
, gcc
, clang-tools
, meson
, ninja
, pkg-config
}:
mkShell {
  name = "fooname-shell";
  buildInputs = [
    man-pages
    gcc
    clang-tools
    meson
    ninja
    pkg-config
  ];
  inputsFrom = [
    self.packages.${pkgs.system}.default
  ];
}
