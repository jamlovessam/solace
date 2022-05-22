#!/bin/sh

nix shell "nixpkgs#"{haskell.compiler.ghc8107,cabal-install,zlib}
