{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
}:
buildPythonPackage rec {
  pname = "ambuild";
  version = "2.2.3-dev";

  src = fetchFromGitHub {
    owner = "alliedmodders";
    repo = pname;
    rev = "25a23ac92307eb1e181fd3e7d9385412d4034532";
    hash = "sha256-edKJM+dwba2xih0bAOc/MT0BIUwoP+5cTAdtn0cfZUo=";
  };

  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/alliedmodders/ambuild";
    description = "AMBuild is a lightweight build system designed for performance and accuracy";
    license = licenses.bsd3;
  };
}
