let
  env = ''
    stty -echo
    export PS1='RACKME \w $ '
    export EDITOR=E
  '';
  pkgs = import <nixpkgs> {};
  drv = pkgs.callPackage ./. {};
  devTools = with pkgs; [ git gdb ];
in
pkgs.stdenv.lib.overrideDerivation drv (orig: { buildInputs = orig.buildInputs ++ devTools;
                                                shellHook = env; })
