{ self
, pkgs
, mkShell
, odin-git
, ols
, odin-doc
}:
mkShell {
  name = "fooname-shell";
  nativeBuildInputs = [
    ols
    odin-git
    odin-doc
  ];
  inputsFrom = [
    self.packages.${pkgs.system}.default
  ];
}
