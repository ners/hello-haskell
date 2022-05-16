{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };
  outputs = inputs:
    with inputs;
    with builtins;
    flake-utils.lib.eachSystem (attrNames nixpkgs.legacyPackages) (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        hello-haskell =
          pkgs.haskellPackages.callCabal2nix "hello-haskell" ./. { };
      in
      {
        defaultPackage = hello-haskell;
        devShell = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [ cabal-install ghc ];
        };
      });
}
