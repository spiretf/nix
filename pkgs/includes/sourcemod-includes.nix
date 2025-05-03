{
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "sourcemod-includes";
  version = "1.11";

  src = fetchFromGitHub {
    owner = "alliedmodders";
    repo = "sourcemod";
    rev = "b0cf46521b2be5f1497644275caee9b7c330ed6c";
    hash = "sha256-4cB1Ey5eWoCYXmMrT/Irqk+w+1q0RwBQ23YZ4FKI/gM=";
  };

  doConfigure = false;
  doBuild = false;

  installPhase = ''
    mkdir $out
    cp -r plugins/include $out
  '';
}
