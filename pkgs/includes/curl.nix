{
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "sourcemod-include-curl";
  version = "2.0.0-beta";

  src = fetchFromGitHub {
    owner = "sapphonie";
    repo = "SM-neocurl-ext";
    rev = "7b92e4acf6dea29348efeb4c0cc89e3071aee56e";
    hash = "sha256-CniARMYWJm3Z4mVQFb3uW0CnRE+ENYeZV3NNOWEnf1U=";
  };

  doConfigure = false;
  doBuild = false;

  installPhase = ''
    mkdir $out
    cp -r pawn/scripting/include $out
  '';
}
