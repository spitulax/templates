{ self
, pkgs
, mkShell
}:
mkShell {
  name = "fooname-shell";
  inputsFrom = [
    self.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
