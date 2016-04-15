{stdenv, buildEnv, callPackage}:

let
  rackme-lib = callPackage ./lib {};
  find = callPackage ./find { inherit rackme-lib; };
  env = buildEnv rec {
    name = "rackme";
    paths = [ find ];

    postBuild = ''
      # TODO: This could be avoided if buildEnv could be forced to create all directories
      if [ -L $out/bin ]; then
        rm $out/bin
        mkdir $out/bin
        for prog in ${stdenv.lib.concatStrings paths}; do
          for i in $prog/bin/*; do
            ln -s $i $out/bin
          done
        done
      fi
    '';
  };
in
env
