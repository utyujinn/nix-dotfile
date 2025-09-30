{ config, pkgs, ... }:
let
  s = name: { source = ../apps/zsh + "/${name}"; };
in
{
  home.file = {
    ".zshrc_comp" = s "zshrc";
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = ''
      source "$HOME/.zshrc_comp"
    '';
  };

  programs.autojump = {
    enable = true;
    enableZshIntegration = true;
  };
}
