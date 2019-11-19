{ overlays ? [ ], ... }@args:
import (
# to use a version of Hadui from github
  builtins.fetchTarball {
    url = "https://github.com/complyue/hadui/archive/0.1.0.rc3.tar.gz";
    sha256 = "1pa13r33smzni1r263sbz3q2iay4qyavmcxpaslafzc1rh548hbj";
  }

  # to use the version of Hadui checked out locally
  #../hadui
) (args // {
  overlays = [
    (self: super:
      let
        myHaskellPackageSet = super.haskellPackages.override {
          overrides = hself: hsuper: {
            hadui-demo = hself.callCabal2nix "hadui-demo" ./hadui-demo { };
          };
        };
      in {
        # expose as a top-level Nix package too
        hadui-demo = myHaskellPackageSet.hadui-demo;

        # override the Haskell package set at standard locations
        haskellPackages = myHaskellPackageSet;
        haskell = super.haskell // {
          packages = super.haskell.packages // {
            ghcWithMyPkgs = myHaskellPackageSet;
          };
        };
      })
  ] ++ (args.overlays or [ ]);
})
