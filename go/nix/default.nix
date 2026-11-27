{ lib
, buildGoModule
, version ? "git"
}:
buildGoModule {
  pname = "fooname";
  inherit version;
  src = lib.cleanSource ./..;

  nativeBuildInputs = [

  ];

  buildInputs = [

  ];

  # Run `go mod vendor` to vendor dependencies.
  vendorHash = null;
  # vendorHash = lib.fakeHash;

  meta = {
    description = "foodesc";
    mainProgram = "fooname";
    homepage = "https://github.com/spitulax/fooname";
    # license = lib.licenses.;
    # platforms = lib.platforms.;
  };
}
