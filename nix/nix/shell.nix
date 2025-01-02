{ lib
, self
, pkgs
, mkShell
}:
mkShell {
  name = lib.getName self.packages.${pkgs.system}.default + "-shell";
  inputsFrom = [
    self.packages.${pkgs.system}.default
  ];
}
