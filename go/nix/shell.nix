{ self
, pkgs
, mkShell
, go
, gopls
, golangci-lint
}:
mkShell {
  name = "fooname-shell";
  buildInputs = [
    go
    gopls
    golangci-lint
  ];
  inputsFrom = [
    self.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
