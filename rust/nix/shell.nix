{ lib
, self
, pkgs
, mkShell
, rustToolchain
}:
mkShell {
  name = lib.getName self.packages.${pkgs.system}.default + "-shell";
  nativeBuildInputs = [
    rustToolchain
  ];
  inputsFrom = [
    self.packages.${pkgs.system}.default
  ];
}
