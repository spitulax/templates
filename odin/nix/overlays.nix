{ self, lib, inputs }: {
  default = final: prev: {
    fooname = final.callPackage ./default.nix { };
    fooname-debug = final.callPackage ./default.nix { debug = true; };
  };
}
