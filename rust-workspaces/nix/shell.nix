{ pkgs
, myLib
, craneLib
, rust-analyzer
, cargo-hakari
, cargo-nextest
}:
craneLib.devShell {
  name = "fooname-shell";
  buildInputs = [
    (myLib.rustToolchain pkgs)
    rust-analyzer
    cargo-hakari
    cargo-nextest
  ];
  inputsFrom = [
    (myLib.cargoArtifacts.overrideAttrs {
      cargoVendorDir = null;
    })
  ];
}
