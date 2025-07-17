{ self
, lib
, mypkgs
}:
{
  default = self.overlays.fooname;

  fooname = final: prev: {
    fooname = prev.callPackage ./default.nix { inherit (prev.myLib) version; };
  };

  libs = final: prev: {
    myLib = import ./lib.nix { inherit self lib; };
  };

  odin = final: prev: rec {
    inherit (prev.mypkgs) odin-git odin-doc;
    ols = prev.mypkgs.ols.override {
      odinRoot = "${odin-git}/share";
    };
  };
}
