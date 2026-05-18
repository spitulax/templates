{ self
, pkgs
, clangStdenv
, clang
, mkShell
, lld
, xwin
, libllvm
, clang-tools
, meson
, ninja
, pkg-config
, overrideCC
, symlinkJoin
}:
let
  clangFix = symlinkJoin {
    name = "clang-fix";
    paths = [
      clang-tools
      clang
    ];
  };
in
(mkShell.override {
  stdenv = overrideCC clangStdenv clangFix;
}) {
  name = "fooname-shell";
  buildInputs = [
    lld
    xwin
    libllvm
    meson
    ninja
    pkg-config
  ];
  inputsFrom = [
    self.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
