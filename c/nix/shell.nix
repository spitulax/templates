{ self
, pkgs
, mkShell
}:
mkShell {
  name = "fooname-shell";
  inputsFrom = [
    self.packages.${pkgs.system}.default
  ];
}
