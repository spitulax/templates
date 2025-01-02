{ self, lib, inputs }: {
  default = final: prev: {
    fooname = final.callPackage ./default.nix { };
  };
}
