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
    rev = "9392da7c7e0a148bf8e0089b88d372a6eb62c65c";
    sha256 = "sha256-4Ar6EWhgUiO5ZHna5JqwRHlYeh54WjZi0xqv/u3tqOU=";
  };

  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/alliedmodders/ambuild";
    description = "AMBuild is a lightweight build system designed for performance and accuracy";
    license = licenses.bsd3;
  };
}
