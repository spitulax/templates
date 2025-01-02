{ lib
, self
, pkgs
, mkShell
, rustToolchain
}:
let
  inherit (pkgs) system;
in
mkShell {
  name = lib.getName self.packages.${system}.default + "-shell";
  nativeBuildInputs = [
    rustToolchain
  ];
  inputsFrom = [
    self.packages.${system}.default
  ];
}
