{ pkgs
, myLib
, craneLib
, rust-analyzer
, cargo-nextest
}:
craneLib.devShell {
  name = "fooname-shell";
  buildInputs = [
    (myLib.rustToolchain pkgs)
    rust-analyzer
    cargo-nextest
  ];
  inputsFrom = [
    (myLib.cargoArtifacts.overrideAttrs {
      cargoVendorDir = null;
    })
  ];
}
