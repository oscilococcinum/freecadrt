{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    freecadrt-appimage-x86_64-linux.url = "https://github.com/realthunder/FreeCAD/releases/download/20241003stable/FreeCAD-Link-Stable-Linux-x86_64-py3.11-20241003.AppImage";
    freecadrt-appimage-x86_64-linux.flake = false;
  };

  outputs = { nixpkgs, ... }@inputs: {
    packages = builtins.listToAttrs (map (system:
      {
        name = system;
        value = with import nixpkgs { inherit system; config.allowUnfree = true;}; rec {

          ondsel-appimage = appimageTools.wrapType2 {
            name = "freecadrt";
            src = inputs."freecadrt-appimage-${system}";
          };
        };
      }
    )[ "x86_64-linux" "aarch64-linux" ]);
  };
}
