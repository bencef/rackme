{stdenv, racket, rackme-lib, makeWrapper}:

stdenv.mkDerivation {
  name = "rackme-find";
  version = "0.1";
  src = ./.;

  buildInputs = [ racket makeWrapper ];
  phases = [ "unpackPhase" "buildPhase" "installPhase" ];

  buildPhase = ''
    # can't use raco exe in NixOS as of now.
    # see https://github.com/NixOS/nixpkgs/issues/11698
    PLTCOLLECTS=:${rackme-lib}/lib raco make main.rkt
  '';

  installPhase = ''
    mkdir -p $out/bin $out/libexec
    mv main.rkt compiled $out/libexec
    makeWrapper "racket $out/libexec/main.rkt" $out/bin/Find \
      --set PATH "$PATH:${racket}/bin" \
      --set PLTCOLLECTS ":${rackme-lib}/lib"
  '';
}
