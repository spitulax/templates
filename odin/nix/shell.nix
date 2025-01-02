{ self
, pkgs
, mkShell
}:
mkShell {
  name = "fooname-shell";
  nativeBuildInputs = with pkgs; [
    odin
  ];
  inputsFrom = [
    self.packages.${pkgs.system}.default
  ];
}
