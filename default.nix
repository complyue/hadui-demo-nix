{ overlays ? [ ], ... }@args:
import (
# to use a version of Hadui from github
  builtins.fetchTarball {
    url = "https://github.com/complyue/hadui/archive/0.1.0.1.tar.gz";
    sha256 = "0bvhbfspkd0d7b1bwlc82v8j17ylydh2blkp1jrqgljr7c0356z3";
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
