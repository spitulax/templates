{
  description = "foodesc";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, rust-overlay, ... }@inputs:
    let
      toolchain-channel = "beta";

      inherit (nixpkgs) lib;
      systems = [ "x86_64-linux" "aarch64-linux" ];
      eachSystem = f: lib.genAttrs systems f;
      pkgsFor = eachSystem
        (system:
          let
            rustPkgs = import nixpkgs {
              inherit system;
              overlays = [
                rust-overlay.overlays.default
              ];
            };
            inherit (rustPkgs) rust-bin;
          in
          import nixpkgs {
            inherit system;
            overlays = [
              self.overlays.default
              (final: prev:
                {
                  rustToolchain = rust-bin.${toolchain-channel}.latest.minimal;
                  rustPlatform = prev.makeRustPlatform {
                    cargo = final.rustToolchain;
                    rustc = final.rustToolchain;
                  };
                })
            ];
          });
    in
    {
      overlays = import ./nix/overlays.nix { inherit self lib inputs; };

      packages = eachSystem (system:
        let
          pkgs = pkgsFor.${system};
        in
        {
          default = self.packages.${system}.fooname;
          inherit (pkgs) fooname fooname-debug;
        });

      devShells = eachSystem (system:
        let
          pkgs = pkgsFor.${system};
        in
        {
          default = pkgs.callPackage ./nix/shell.nix { inherit self; };
        }
      );
    };
}
