# Spire nix packages

A set of tf2 related nix packages

## Packages

The following is currently packaged:

- `ambuild`
- `sourcepawn`
- `metamod-source`
- `sourcemod`
- [`sourcemod-include-library`](https://github.com/JoinedSenses/SourceMod-IncludeLibrary)


## Sourcemod SDKs

For the `sourcemod` package, you need to enable one or more SDKs at build time.
The SDKs are packaged under the `hl2sdk` package and can be enabled like in the following example.

```nix
pkgs.sourcemod.override {sdks = {inherit (pkgs.hl2sdk) tf2;};};
```

### Supported SDKs

#### i686-linux

`episode1`, `ep2`, `css`, `hl2dm`, `dods`, `sdk2013`, `tf2`, `l4d`, `l4d2`, `nucleardawn`, `csgo`, `insurgency`, `bms` and `doi`

#### x86_64-linux

`csgo` and `blade`

## Building sourcepawn script

```nix
buildSourcePawnScript {
  name = "test";
  src = ./test.sp;
};
```

By default, the sourcemod includes are available.

Additional includes can be added by setting the `includes` argument to an array of packages containing an `include` folder containing the `.inc` files.
A helper is provided to create include packages:

```nix
sourcepawn.buildInclude [./cURL.inc ./cURL_header.inc]
```