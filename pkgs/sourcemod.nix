{ clangMultiStdenv, fetchFromGitHub, ambuild, metamod-source, symlinkJoin, sdks ? {} }: let
  inherit (builtins) concatStringsSep attrNames attrValues;
  sdkNames = attrNames sdks;
  combinedSdks = symlinkJoin {
    name = "hl2sdk-${concatStringsSep "-" (attrNames sdks)}";
    paths = attrValues sdks;
  };
in clangMultiStdenv.mkDerivation rec {
  pname = "sourcemod";
  version = "1.10";

  NIX_CFLAGS_COMPILE = "-Wno-error=implicit-const-int-float-conversion -Wno-error=tautological-overlap-compare";

  src = fetchFromGitHub {
    owner = "alliedmodders";
    repo = pname;
    rev = "39c2dc60e0c0d963cfbe39bee3a7cf953cc8055c";
    sha256 = "sha256-SwrBuOAebmLq5bgjw5i8CFuEDTtvDqLYY/dk4holrzw=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    ambuild
  ];

  hardeningDisable = [ "all" ];

  configurePhase = ''
    mkdir build
    cd build
    python ../configure.py --sdks present --no-mysql --disable-auto-versioning --mms-path=${metamod-source.src} --hl2sdk-root=${combinedSdks}
  '';

  buildPhase = ''
    ambuild
  '';

  installPhase = ''
    mkdir $out
    mv package $out/share
  '';
}