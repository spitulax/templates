{
  description = "foodesc";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    crane.url = "github:ipetkov/crane";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, crane, rust-overlay, ... }:
    let
      inherit (nixpkgs) lib;
      systems = [ "x86_64-linux" "aarch64-linux" ];
      eachSystem = f: lib.genAttrs systems f;
      pkgsFor = eachSystem
        (system:
          import nixpkgs {
            inherit system;
            overlays = [
              rust-overlay.overlays.default
              self.overlays.libs
              self.overlays.default
            ];
          });
    in
    {
      overlays = import ./nix/overlays.nix { inherit self lib crane; };

      packages = eachSystem (system:
        let
          pkgs = pkgsFor.${system};
        in
        {
          default = self.packages.${system}.fooname;
          inherit (pkgs) fooname;
        });

      devShells = eachSystem (system:
        let
          pkgs = pkgsFor.${system};
        in
        {
          default = pkgs.callPackage ./nix/shell.nix { };
        }
      );

      checks = eachSystem (system:
        let
          pkgs = pkgsFor.${system};
          inherit (pkgs) craneLib myLib;
        in
        self.packages.${system}
        // {
          clippy = craneLib.cargoClippy
            (myLib.commonArgs // {
              inherit (myLib) cargoArtifacts;
              cargoClippyExtraArgs = "--all-targets";
            });

          nextest = craneLib.cargoNextest (
            myLib.commonArgs
            // {
              inherit (myLib) cargoArtifacts;
              partitions = 1;
              partitionType = "count";
              cargoNextestPartitionsExtraArgs = "--no-tests=pass";
            }
          );

          hakari = craneLib.mkCargoDerivation {
            inherit (myLib) src;
            pname = "fooname-hakari";
            cargoArtifacts = null;
            doInstallCargoArtifacts = false;

            buildPhaseCargoCommand = ''
              cargo hakari generate --diff
              cargo hakari manage-deps --dry-run
              cargo hakari verify
            '';

            nativeBuildInputs = [
              pkgs.cargo-hakari
            ];
          };
        }
      );
    };
}
