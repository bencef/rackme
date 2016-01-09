{stdenv, racket}:

stdenv.mkDerivation {
  name = "rackme-lib";
  version = "0.1";
  src = ./.;

  buildInputs = [ racket ];

  phases = [ "unpackPhase" "buildPhase" "installPhase" ];

  buildPhase = ''
    raco make main.rkt
  '';

  installPhase = ''
    mkdir -p $out/lib/rackme
    mv main.rkt compiled $out/lib/rackme
  '';
}
