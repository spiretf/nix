{
  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "nixpkgs/release-23.05";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
  }:
    utils.lib.eachDefaultSystem (system: let
      inherit (builtins) mapAttrs attrNames;
      overlays = [(import ./pkgs)];
      pkgs = (import nixpkgs) {
        inherit system overlays;
      };
      testScript = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/spiretf/nocheats/master/plugin/nocheats.sp";
        sha256 = "sha256-Z3RJhuc9c8YQTo9gnLTBrqL4JpADZgDttrJVyE/MWdM=";
      };
    in rec {
      packages = rec {
        inherit (pkgs) ambuild sourcemod sourcepawn sourcemod-includes buildSourcePawnScript hl2sdk;
        sourcemods = mapAttrs (name: sdk: pkgs.sourcemod.override {sdks = {${name} = sdk;};}) hl2sdk;
        buildTestScript = buildSourcePawnScript {name = "test"; src = testScript;};
      };

      devShells.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [];
      };

      sdks = attrNames packages.hl2sdk;

      overlays.default = import ./pkgs;
    });
}
