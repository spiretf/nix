{
  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "nixpkgs/release-23.05";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
  }: let
      inherit (nixpkgs.lib.lists) concatMap;
      inherit (builtins) map;
      systems = with utils.lib.system; [x86_64-linux i686-linux];
    in utils.lib.eachSystem systems (system: let
      inherit (builtins) mapAttrs attrNames elem;
      inherit (pkgs) lib;
      inherit (lib.attrsets) filterAttrs;
      overlays = [(import ./pkgs)];
      pkgs = (import nixpkgs) {
        inherit system overlays;
#        crossSystem = { config = "i686-unknown-linux-gnu"; };
      };
      testScript = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/spiretf/nocheats/master/plugin/nocheats.sp";
        sha256 = "sha256-Z3RJhuc9c8YQTo9gnLTBrqL4JpADZgDttrJVyE/MWdM=";
      };
      platformSdks = filterAttrs (name: sdk: elem system sdk.meta.platforms) pkgs.hl2sdk;
    in rec {
      packages = rec {
        inherit (pkgs) ambuild sourcemod sourcepawn sourcemod-includes buildSourcePawnScript hl2sdk;
        sourcemods = mapAttrs (name: sdk: pkgs.sourcemod.override {sdks = {${name} = sdk;};}) hl2sdk;
        buildTestScript = buildSourcePawnScript {name = "test"; src = testScript;};
      };

      devShells.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [clangStdenv];
      };

      sdks = attrNames platformSdks;

      overlays.default = import ./pkgs;
    }) // {
      matrix = {
        include = concatMap (system: map (sdk: {inherit system sdk;}) self.sdks.${system}) systems;
      };
    };
}
