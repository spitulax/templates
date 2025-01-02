{ self
, pkgs
, mkShell
, rustToolchain
}:
mkShell {
  name = "fooname-shell";
  nativeBuildInputs = [
    rustToolchain
  ];
  inputsFrom = [
    self.packages.${pkgs.system}.default
  ];
}
