{
  stdenv,
  fetchFromGitHub,
  ambuild,
  python3Packages,
  buildEnv,
  writeShellScriptBin,
  symlinkJoin,
  sourcemod-includes,
  sourcemod-include-curl,
  sourcemod-include-library,
  sourcemod-include-steamworks,
  runCommand,
}: let
  inherit (builtins) concatStringsSep substring stringLength;
  self = stdenv.mkDerivation rec {
    pname = "sourcepawn";
    version = "1.12";

    NIX_CFLAGS_COMPILE = "-Wno-error=sign-compare -Wno-error=unused-but-set-variable -Wno-error=maybe-uninitialized -Wno-error=ignored-attributes -Wno-error=unused-variable";

    src = fetchFromGitHub {
      owner = "alliedmodders";
      repo = pname;
      rev = "11b22edb634b9764d19fd28699e03289cfd18520";
      hash = "sha256-O9V6D0tL9EBX1r41AgPNliNIU2SPfwZVU89Pgsuw/Cw=";
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

    passthru = {
      buildInclude = let
        fileNameForStorePath = path: substring 44 (stringLength path - 44) path;
      in
        files:
          runCommand "sourcepawn-include" {} ''
            mkdir -p $out/include
            ${concatStringsSep "\n" (map (file: "cp ${file} $out/include/${fileNameForStorePath file}") files)}
          '';
      includes = {
        library = sourcemod-include-library;
        sourcemod = sourcemod-includes;
        curl = sourcemod-include-curl;
        steamworks = sourcemod-include-steamworks;
      };
      buildEnv = imports: let
        unwrapped = symlinkJoin {
          name = "sourcepawn-env-unwrapped";
          paths = imports ++ [self];
          postBuild = ''
            mv $out/bin/spcomp{,.unwrapped}
          '';
        };
        wrapped = writeShellScriptBin "spcomp" "exec -a $0 ${unwrapped}/bin/spcomp.unwrapped $@";
      in
        symlinkJoin {
          name = "sourcepawn-env";
          paths = [unwrapped wrapped];
        };
    };
    meta.mainProgram = "spcomp";
  };
in
  self
