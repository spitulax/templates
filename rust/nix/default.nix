{ lib
, myLib
}:
{
  fooname = myLib.mkCrate {
    pname = "fooname";

    meta = {
      description = "foodesc";
      mainProgram = "fooname";
      homepage = "https://github.com/spitulax/fooname";
      #license = lib.licenses.;
      #platforms = lib.platforms.;
    };
  };
}
