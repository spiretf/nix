{
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "sourcemod-include-steamworks";
  version = "1.2.3c";

  src = fetchFromGitHub {
    owner = "JoinedSenses";
    repo = "SourceMod-IncludeLibrary";
    rev = "9d4e4263b77aa0c4fcdadd498c1420c64b3c1c10";
    hash = "sha256-kO3iRHr3D0qLmgMh4SD3yz14bxSUD0r9pi6dHj8dnN0=";
  };

  doConfigure = false;
  doBuild = false;

  installPhase = ''
    mkdir -p $out/include
    cp -r include/steamworks.inc $out/include
  '';
}
