{ config, pkgs, lib, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      snes-pixel-editor = final.callPackage ./mypackage/snes-pixel-editor/snes-pixel-editor.nix {};
    })
  ];
}
