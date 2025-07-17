{
  description = "foodesc";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    mypkgs.url = "github:spitulax/mypkgs";
  };

  outputs = { self, nixpkgs, mypkgs, ... }:
    let
      inherit (nixpkgs) lib;
      systems = [ "x86_64-linux" "aarch64-linux" ];
      eachSystem = f: lib.genAttrs systems f;
      pkgsFor = eachSystem (system:
        import nixpkgs {
          inherit system;
          overlays = [
            mypkgs.overlays.default
            self.overlays.libs
            self.overlays.odin
            self.overlays.default
          ];
        });
    in
    {
      overlays = import ./nix/overlays.nix { inherit self lib mypkgs; };

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
          default = pkgs.callPackage ./nix/shell.nix { inherit self; };
        }
      );
    };

  nixConfig = {
    extra-substituters = [
      "spitulax.cachix.org"
    ];
    extra-trusted-public-keys = [
      "spitulax.cachix.org-1:GQRdtUgc9vwHTkfukneFHFXLPOo0G/2lj2nRw66ENmU="
    ];
  };
}
