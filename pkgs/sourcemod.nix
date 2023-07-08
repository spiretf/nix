{ multiStdenv, fetchFromGitHub, ambuild, metamod-source, git, sdks ? {} }: let
  inherit (builtins) attrNames concatStringsSep;
  sdkNames = attrNames sdks;
  links = map (sdk: "ln -s ${sdks.${sdk}} hl2sdk-${sdk}") sdkNames;
  metamod-sdks = metamod-source.override {inherit sdks;};
in multiStdenv.mkDerivation rec {
  pname = "sourcemod";
  version = "1.10";

  NIX_CFLAGS_COMPILE = "-Wno-error=class-memaccess -Wno-error=format-truncation -Wno-error=misleading-indentation";

  src = fetchFromGitHub {
    owner = "alliedmodders";
    repo = pname;
    rev = "39c2dc60e0c0d963cfbe39bee3a7cf953cc8055c";
    sha256 = "sha256-SwrBuOAebmLq5bgjw5i8CFuEDTtvDqLYY/dk4holrzw=";
    fetchSubmodules = true;
  };

  buildInputs = [
    ambuild
    git
  ];

  hardeningDisable = [ "all" ];

  configurePhase = ''
    ${concatStringsSep "\n" links}
    ln -s ${metamod-sdks.src} metamod-source
    mkdir build
    cd build
    python ../configure.py --sdks present --no-mysql --disable-auto-versioning
  '';

  buildPhase = ''
    ambuild
  '';

  installPhase = ''
    mkdir $out
    mv package $out/share
  '';
}