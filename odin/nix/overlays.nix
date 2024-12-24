{ self, lib, inputs }: {
  default = final: prev: {
    foobar = final.callPackage ./default.nix { };
    foobar-debug = final.callPackage ./default.nix { debug = true; };
  };
}
