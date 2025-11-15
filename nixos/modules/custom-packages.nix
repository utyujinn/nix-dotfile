{ config, pkgs, lib, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      snes-pixel-editor = final.callPackage ./mypackage/snes-pixel-editor.nix {};
      qwen-code = final.callPackage ./mypackage/qwen-code.nix {};
    })
  ];
}
