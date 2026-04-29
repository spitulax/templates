{ self
, pkgs
, mkShell
, clang
, lld
, xwin
, libllvm
, clang-tools
, meson
, ninja
, pkg-config
}:
mkShell {
  name = "fooname-shell";
  buildInputs = [
    clang
    lld
    xwin
    libllvm
    clang-tools
    meson
    ninja
    pkg-config
  ];
  inputsFrom = [
    self.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
