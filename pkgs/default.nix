final: prev: {
  hl2sdk =  final.callPackage ./hl2sdk.nix {};
  ambuild = final.python3Packages.callPackage ./ambuild.nix {};
  metamod-source = final.callPackage ./metamod-source.nix {};
  sourcemod = final.callPackage ./sourcemod.nix {};
  sourcepawn = final.callPackage ./sourcepawn.nix {};
  sourcemod-includes = final.callPackage ./sourcemod-includes.nix {};
  buildSourcePawnScript = final.callPackage ./build-sourcepawn-script.nix {};
}