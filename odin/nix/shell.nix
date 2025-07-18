{ self
, pkgs
, mkShell
, odin-git
, ols
, odin-doc
, gnumake
}:
mkShell {
  name = "fooname-shell";
  nativeBuildInputs = [
    ols
    odin-git
    odin-doc
    gnumake
  ];
  inputsFrom = [
    self.packages.${pkgs.system}.default
  ];
}
