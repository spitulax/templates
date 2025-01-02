{ lib
, self
, pkgs
, mkShell
}:
mkShell {
  name = lib.getName self.packages.${pkgs.system}.default + "-shell";
  nativeBuildInputs = with pkgs; [
    odin
  ];
  inputsFrom = [
    self.packages.${pkgs.system}.default
  ];
}
