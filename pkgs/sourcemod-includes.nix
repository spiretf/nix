{ stdenv, fetchFromGitHub }:
stdenv.mkDerivation rec {
  pname = "sourcemod-includes";
  version = "1.11";

  src = fetchFromGitHub {
    owner = "alliedmodders";
    repo = "sourcemod";
    rev = "39c2dc60e0c0d963cfbe39bee3a7cf953cc8055c";
    sha256 = "sha256-9maE7NKSpkMfK4NgO0NAItpj2ONhGhsOOp81rTpKyFE=";
  };

  doConfigure = false;
  doBuild = false;

  installPhase = ''
    mkdir $out
    cp -r plugins/include $out
  '';
}