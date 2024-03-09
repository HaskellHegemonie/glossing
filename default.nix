{ system ? builtins.currentSystem
, pkgs ? import <nixpkgs> { inherit system; config = {}; overlays = []; }
, lib ? pkgs.lib
, stdenv ? pkgs.stdenv
}:
let 
  build =  stdenv.mkDerivation {
    name = "testing";
    dontUnpack = true;
    buildInputs = with pkgs; [ (ghc.withPackages (hs-pkgs: with hs-pkgs; [ gloss ])) ];
    passthru = { inherit pkgs; inherit shell;};
  };
  shell = pkgs.mkShell {
    inputsFrom = [ build ];
  };
in
build
  
