final: prev: {
  hl2sdk = (import ./hl2sdk.nix) {
    inherit (final) fetchFromGitHub lib;
    inherit (final.stdenvNoCC) mkDerivation;
  };
  ambuild = final.python3Packages.callPackage ./ambuild.nix {};
  metamod-source = final.callPackage ./metamod-source.nix {};
  sourcemod = final.callPackage ./sourcemod.nix {};
  sourcepawn = final.callPackage ./sourcepawn.nix {};
  sourcemod-includes = final.callPackage ./includes/sourcemod-includes.nix {};
  buildSourcePawnScript = final.callPackage ./build-sourcepawn-script.nix {};
  sourcemod-include-library = final.callPackage ./includes/sourcemod-include-library.nix {};
  sourcemod-include-curl = final.callPackage ./includes/curl.nix {};
}
