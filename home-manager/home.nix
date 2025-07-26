{ config, pkgs, inputs, ... }:

{
  home.username = "utyujin";
  home.homeDirectory = "/home/utyujin";

  imports = [
    ./modules/vim.nix
    ./modules/zsh.nix
    ./modules/yazi.nix
    ./modules/rclone.nix
    ./modules/xournalpp.nix
  ];
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
  ];

  home.file = {
  };

 # home.sessionVariables = {
 #   GTK_IM_MODULE = "fcitx";
 #   QT_IM_MODULE = "fcitx";
 #   XMODIFIERS = "@im=fcitx";
 #   SDL_IM_MODULE = "fcitx";
 #   GLFW_IM_MODULE = "ibus";
 # };

  programs.home-manager.enable = true;
}
