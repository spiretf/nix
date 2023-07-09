{
  multiStdenv,
  fetchFromGitHub,
  ambuild,
  git,
  sdks ? {},
}: let
  inherit (builtins) attrNames concatStringsSep;
  sdkNames = attrNames sdks;
  links = map (sdk: "ln -s ${sdks.${sdk}} hl2sdk-${sdk}") sdkNames;
in
  multiStdenv.mkDerivation rec {
    pname = "metamod-source";
    version = "1.10";

    NIX_CFLAGS_COMPILE = "-Wno-error=class-memaccess -Wno-error=format-truncation";

    src = fetchFromGitHub {
      owner = "alliedmodders";
      repo = pname;
      #    rev = version;
      rev = "b8d1fd401d685fe711ad27e4e169742bd8a51978";
      sha256 = "sha256-8rQJ99f+XxD+rSP7OpyU5Ml+Wwp/SqJ9+B9EEWmcqDY=";
    };

    buildInputs = [
      ambuild
      git
    ];

    hardeningDisable = ["all"];

    CFLAGS = "-Wno-error=class-memaccess";

    buildPhase = ''
      ${concatStringsSep "\n" links}
      mkdir build
      cd build
      python ../configure.py --sdks present --disable-auto-versioning
      ambuild
    '';

    installPhase = ''
      mkdir $out
      mv package $out/share
      cp -r $src $out/include
    '';
  }
