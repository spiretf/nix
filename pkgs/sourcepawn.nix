{
  stdenv,
  fetchFromGitHub,
  ambuild,
  python3Packages,
  buildEnv,
  writeShellScriptBin,
  symlinkJoin
}: let
  self = stdenv.mkDerivation rec {
    pname = "sourcepawn";
    version = "1.11";

    NIX_CFLAGS_COMPILE = "-Wno-error=sign-compare -Wno-error=unused-but-set-variable -Wno-error=maybe-uninitialized";

    src = fetchFromGitHub {
      owner = "alliedmodders";
      repo = pname;
      rev = "9cf9f31d4560fe7e76c6be75a2245088d03a3937";
      hash = "sha256-lqd6aN5FLCJo8+B+tabABqkkgIFH+o0/0WpnYLse/o4=";
      fetchSubmodules = true;
    };

    buildInputs = [
      ambuild
      python3Packages.setuptools
    ];

    configurePhase = ''
      mkdir build
      cd build
      python ../configure.py
    '';

    buildPhase = ''
      ambuild
    '';

    installPhase = ''
      mkdir -p $out/bin
      cp spcomp/*/spcomp spshell/*/spshell verifier/*/verifier $out/bin
    '';

    passthru.buildEnv = imports: let
        unwrapped = symlinkJoin {
          name = "sourcepawn-env-unwrapped";
          paths = imports ++ [self];
          postBuild = ''
            mv $out/bin/spcomp{,.unwrapped}
          '';
        };
        wrapped = writeShellScriptBin "spcomp" "exec -a $0 ${unwrapped}/bin/spcomp.unwrapped $@";
      in symlinkJoin {
        name = "sourcepawn-env";
        paths = [unwrapped wrapped];
      };
  };

in
  self
