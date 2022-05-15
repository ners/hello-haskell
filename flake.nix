{ 
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs = inputs:
    let
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      hello-haskell = pkgs.haskellPackages.callCabal2nix "hello-haskell" ./. {};
    in
    {
      defaultPackage.${system} = hello-haskell;
      devShell.${system} = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          cabal-install
          ghc
        ];
      };
    };
}