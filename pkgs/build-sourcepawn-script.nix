{
  lib,
  stdenv,
  sourcepawn,
  which,
}: {
  defaultIncludes ? true,
  includes ? [],
  src,
  outPath ? "",
  ...
} @ args: let
  inherit (lib) optionals;
  inherit (builtins) removeAttrs;
  allIncludes = includes ++ optionals defaultIncludes [sourcepawn.includes.sourcemod];
  forwardAttrs = removeAttrs args ["defaultIncludes" "includes" "entrypoint"];
  spEnv = sourcepawn.buildEnv allIncludes;
  outPathRelative =
    if outPath == ""
    then ""
    else "/${outPath}";
  mkdirOut =
    if outPath == ""
    then ""
    else "mkdir -p $out";
in
  stdenv.mkDerivation (rec {
      nativeBuildInputs = [spEnv which];
      dontUnpack = true;
      buildPhase = ''
        # absolute path is needed for spcomp to find the includes
        spcomp ${src} -o out.smx
      '';
      installPhase = ''
        ${mkdirOut}
        cp out.smx $out${outPathRelative}
      '';
      testPhase = ''
        verifier out.smx
      '';
    }
    // args)
