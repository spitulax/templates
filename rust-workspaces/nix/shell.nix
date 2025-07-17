{ pkgs
, myLib
, cargo-hakari
, craneLib
, rust-analyzer
}:
craneLib.devShell {
  name = "fooname-shell";
  buildInputs = [
    (myLib.rustToolchain pkgs)
    rust-analyzer
    cargo-hakari
  ];
  inputsFrom = [
    (myLib.cargoArtifacts.overrideAttrs {
      cargoVendorDir = null;
    })
  ];
}
