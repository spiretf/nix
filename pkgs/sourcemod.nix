{
  clangStdenv,
  fetchFromGitHub,
  ambuild,
  metamod-source,
  symlinkJoin,
  lib,
  writeShellScriptBin,
  zlib,
  sdks ? {},
}: let
  inherit (builtins) concatStringsSep attrNames attrValues;
  inherit (lib) optionals;
  combinedSdks = symlinkJoin {
    name = "hl2sdk-${concatStringsSep "-" (attrNames sdks)}";
    paths = attrValues sdks;
  };
  ambuildArchs = {
    "x86_64-linux" = "x86_64";
    "i686-linux" = "x86";
  };
  ambuildArch = ambuildArchs.${clangStdenv.system};
  sdkNames = concatStringsSep "," (attrNames sdks);
  # ambuild doesn't allow configuring a target prefix for "ar"
  arWrapper = writeShellScriptBin "ar" "exec -a $0 ${clangStdenv.cc.targetPrefix}ar $@";
in
  clangStdenv.mkDerivation rec {
    pname = "sourcemod";
    version = "1.11";

    NIX_CFLAGS_COMPILE = "-Wno-error=implicit-const-int-float-conversion -Wno-error=tautological-overlap-compare";

    src = fetchFromGitHub {
      owner = "alliedmodders";
      repo = pname;
      rev = "b09a675eb01c65dd95d7ac1a522fb62";
      sha256 = "sha256-FQBYxBt2AoM7OQYhz+qZuLddT9tIfW7ZlRg1Zkd5qE0=";
      fetchSubmodules = true;
    };

    nativeBuildInputs =
      [
        ambuild
      ]
      ++ optionals (clangStdenv.cc.targetPrefix != "") [arWrapper];

    buildInputs = [
      zlib
    ];

    #  hardeningDisable = [ "all" ];

    configurePhase = ''
      mkdir build
      cd build
      python ../configure.py --targets ${ambuildArch} --enable-optimize --sdks=${sdkNames} \
        --no-mysql --disable-auto-versioning --mms-path=${metamod-source.src} --hl2sdk-root=${combinedSdks}
    '';

    buildPhase = ''
      ambuild
    '';

    installPhase = ''
      mkdir $out
      mv package $out/share
    '';
  }
