{ self
, lib
}:
{
  default = self.overlays.fooname;

  fooname = final: prev: {
    fooname = prev.callPackage ./default.nix { inherit (prev.myLib) version; };
  };

  libs = final: prev: {
    myLib = import ./lib.nix { inherit self lib; };
  };
}
