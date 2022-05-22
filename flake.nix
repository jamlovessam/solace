{
  description = "Initial flake for the Solace project";

  outputs = { self, nixpkgs }: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };

    hs = pkgs.haskell.packages.ghc8107;
    myPackage = hs.callCabal2nix "solace" ./. { };
  in
  {
    packages.x86_64-linux = {
      solace = myPackage;
    };

    devShells.x86_64-linux.default = 
    let
      packages = p: [ myPackage ];
      tools = [
        hs.cabal-install
        hs.haskell-language-server
        hs.ghcid
        hs.time
      ];
      libraries = with pkgs; [ 
      	zlib
	nixFlakes
      ];
      libraryPath = "${pkgs.lib.makeLibraryPath libraries}";
    in pkgs.mkShell {
      buildInputs = tools ++ libraries;
      shellHook = ''
        export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${libraryPath}"
        export LIBRARY_PATH="${libraryPath}"
      '';
    };
  };
}
