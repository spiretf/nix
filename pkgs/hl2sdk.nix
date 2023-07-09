{fetchFromGitHub, mkDerivation, lib}: let
  inherit (builtins) mapAttrs elem;
  inherit (lib) optionals;
  revisions = {
    csgo = {rev = "4e0975afe5b2994c76ec9b40951b6347b8788463"; sha256 = "sha256-Z5LD3I4uPKGIXTeSC3yQcJl6455XFwQVuiitND8ULEQ=";};
    tf2 = {rev = "2d3560994fbc31aebbe3a250048bbbc7f76d2803"; sha256 = "sha256-hKwF1cqg08NRPoZk77+lpC2cPMZeKVhsYFpGNi5IH30=";};
    swarm = {rev = "f6026555a7227b2ff8ebed4f86dd760e50de96db"; sha256 = "sha256-jU3yCEVZUWkiOhqPbbX3oEx26tQaZCpaneMGNSQVnxI=";};
    portal2 = {rev = "4555a278a5f3a6cf956a0b78f9c481b40664aa4f"; sha256 = "sha256-Zx5d1qhzoqTybFQQWdJw9/QqbnHUcOB3IyRVbZ/5YyA=";};
    gmod = {rev = "c12fac7c95d9ef5eca89627f944f397af16ae9b4"; sha256 = "sha256-zO1MJIY0ZgHOt9NKtWBi494bOQixk9wo5ybiQI7Esc8=";};
    nucleardawn = {rev = "568c25dcc3ded2123f851d77f27bf2a3c15382b7"; sha256 = "sha256-81O9XVd39Zq15uiTI4vNVtwTtx/qyyR+xZKNjkEze70=";};
    ep2 = {rev = "968ec84e340343f42e3d0552dbd74500ef3034d1"; sha256 = "sha256-XZYJvsIeH+Wh5xzTFHm9fB6JPJh1CELIq/F8ERivZcc="; dirName = "orangebox";};
    bgt = {rev = "a9a75c4d74e87d53b190680e4d71e93f59b3539e"; sha256 = "sha256-e7XgRvfWod6gEElNvqLC09HiUy3affoed3eqFOizk/I=";};
    darkm = {rev = "e659cbdd058fe197a2a5ead4038a591c75063331"; sha256 = "sha256-4RMOMUHLjStsqTMHToxMnxzV2TrP/buiFP3pECYf5IE=";};
    eye = {rev = "f152e66ac838fb5b8eca1a9076eb26122ac3cb51"; sha256 = "sha256-Zy/rKDKPx3pv9uZD9XhrGBoOiY8/zCBXnc9+LPEwWoQ=";};
    bms = {rev = "058ed4de4a5db08052937b91798c303bc27b4a14"; sha256 = "sha256-h9+I+lOf4PiTw6U4taQrMLZt1vbPZbucJmf4Td6ltTg=";};
    l4d = {rev = "a628c16a21f95752d021a16a0c5816ef1f18c37b"; sha256 = "sha256-TqHVJK0nWhg5Gd0KJ4wYQ1Q3QhIidDUxpYSIXKu32G8=";};
    contagion = {rev = "cbab58f4da31c6a88a4fc1f1bad92dc748343314"; sha256 = "sha256-TitcR3CUHmvlVi6ZlAYC7tojQIldL/01IFHOHiAhev0=";};
    blade = {rev = "a14ad10afc41d0150ab945cfa1b0e2a64995a503"; sha256 = "sha256-i/1TT/+NJ44Eip9B4RvQFXPd2NQhGBrjgrXdeE+3f7U=";};
    insurgency = {rev = "29da165490c70f00b2b3d56e38ba97be5287f222"; sha256 = "sha256-ECbTsgbGowUbMhPN5H6sofS5OZRRDmLlNHC/oNkweWE=";};
    pvkii = {rev = "6769441f9f283c96b3915c5a9399ca8949b1ecb0"; sha256 = "sha256-Z3OYaAuLxBuaznQm6eU0d4dWpOUl1S943b8BazSW6Ug=";};
    episode1 = {rev = "b3addd57ec0304e03b8a52a5f1f869609538df0a"; sha256 = "sha256-AhjxQ86NEvKwANihD123QSMWrBhw/17mkvcfXQA2q0Q=";};
    dota = {rev = "8626bfe25f17f98e4a55e71133e1d368780daa37"; sha256 = "sha256-n7HBnEBzf8eBUqOAGZLJWOrPAGNW68nJ9y80OCB0z8c=";};
    mcv = {rev = "6ef5dfa3f5b504e0ad33dffc1596509caa2cbb04"; sha256 = "sha256-xP2pTBfzNGY/1saGaaISaUp+QKETJjVmhJP50GB9f4c=";};
    dods = {rev = "d82a11ffc0b3164721f4f919aab289c461e5a375"; sha256 = "sha256-gCbVqyi5Q8zuiTcMMDwb1DUU2XUXiiY+Lxj2wUzM0a8=";};
    sdk2013 = {rev = "78dab58646d5983c77af44c45a877b89196eb82c"; sha256 = "sha256-2RHuzT6r4WIKYWZaPWFtiDgCAnKgeD9HUyeg1daNCnU=";};
    hl2dm = {rev = "6f8b684753626bbedc463f2ed5a382ff54e5de3d"; sha256 = "sha256-KMMH0/kM4e1SQ/sr87Bdb81ZwvZoN3N20LrHBMuxNAM=";};
    l4d2 = {rev = "66743d0eeef0537201104e94affde4e446897822"; sha256 = "sha256-JvcAV6U5hbnfMdOc4YfGLumZqAFWLvnWAFoFUfMgtFQ=";};
    css = {rev = "ef291082a9efa01225001626e2b14bee8c2c63be"; sha256 = "sha256-x4tZ+fUTb+i2HoKIXgkpXjOUQIWurmHTLyJVuOm/lD0=";};
    doi = {rev = "a4a0aa9de0a648d7f91fbb9ad8aecb119bd44314"; sha256 = "sha256-qMVHEeJqHyg9Kq1Y2+MNTjChiIUyO6PkbWmKPoGZa/Q=";};
  };
  # from https://github.com/alliedmodders/sourcemod/blob/5addaffa5665f353c874f45505914ab692535c24/AMBuildScript#L51
  linuxX86Sdks = ["episode1" "ep2" "css" "hl2dm" "dods" "sdk2013" "tf2" "l4d" "l4d2" "nucleardawn" "csgo" "insurgency" "bms" "doi"];
  linuxX64Sdks = ["blade" "csgo"];
  isX86 = name: elem name linuxX86Sdks;
  isX64 = name: elem name linuxX64Sdks;
  fetchRev = {rev, sha256, ...}: fetchFromGitHub {
    inherit rev sha256;
    owner = "alliedmodders";
    repo = "hl2sdk";
  };
  buildSdk = sdkName: sdk: mkDerivation rec {
    name = "hl2sdk-${sdkName}";
    src = fetchRev sdk;
    installPhase = ''
      mkdir -p $out
      cp -r $src $out/hl2sdk-${sdk.dirName or sdkName}
    '';

    meta = {
      platforms = optionals (isX86 sdkName) ["i686-linux"] ++
        optionals (isX64 sdkName) ["x86_64-linux"];
    };
  };
  sdks = mapAttrs buildSdk revisions;
in sdks