{ self
, pkgs
, mkShell
, rust-bin
}:
mkShell {
  name = "fooname-shell";
  nativeBuildInputs = [
    rust-bin.latest.default
  ];
  inputsFrom = [
    self.packages.${pkgs.system}.default
  ];
}
