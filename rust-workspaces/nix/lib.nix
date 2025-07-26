{ self
, pkgs
, lib
}:
let
  inherit (pkgs) craneLib;
in
rec {
  rustToolchain = pkgs: pkgs.rust-bin.stable.latest.default;

  mkDate = longDate: (lib.concatStringsSep "-" [
    (builtins.substring 0 4 longDate)
    (builtins.substring 4 2 longDate)
    (builtins.substring 6 2 longDate)
  ]);

  src = lib.cleanSource ./..;

  version = src: (craneLib.crateNameFromCargoToml { inherit src; }).version
    + "+date=" + (mkDate (self.lastModifiedDate or "19700101"))
    + "_" + (self.shortRev or "dirty");

  commonArgs = {
    inherit src;
    version = version src;
    strictDeps = true;
    nativeBuildInputs = [ ];
    buildInputs = [ ];
  };

  crateFileset =
    crate:
    lib.fileset.toSource {
      root = ./..;
      fileset = lib.fileset.unions [
        ../Cargo.toml
        ../Cargo.lock
        ../workspace-hack
        ../lib
        (craneLib.fileset.commonCargoSources crate)
      ];
    };

  cargoArtifacts = craneLib.buildDepsOnly commonArgs;

  mkCrate =
    { pname
    , crateSrc
    , ...
    }@args:
    craneLib.buildPackage (commonArgs // {
      inherit pname cargoArtifacts;
      doCheck = false;
      cargoExtraArgs = "-p ${pname}";
      src = crateFileset crateSrc;
    } // args);
}
