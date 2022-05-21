#!/bin/sh

nix shell "nixpkgs#"{ghc,cabal-install,zlib}
