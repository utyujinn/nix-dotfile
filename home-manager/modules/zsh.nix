{ config, pkgs, ... }:
let
  s = name: { source = ../../zsh + "/${name}"; };
in
{
  home.file = {
    ".zshrc_comp" = s "zshrc";
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initExtra = ''
      source "$HOME/.zshrc_comp"
    '';
  };
}

#{ config, pkgs, inputs, ...}:
#let
#  s = name: { source = ../../. + "/${name}"; };
#in
#{
#  home.file = {
#      ".zshenv" = s "zsh/zshenv";
#  };
##
#  programs.zsh = {
#    enable = true;
#    #enableCompletion = true;
#    autosuggestion.enable = true;
#    syntaxHighlighting.enable=true;
#    history.ignoreDups = true;
#  };
#}
#
    #plugins = [
      #{
        #name = "zsh-autosuggestions";
        #src = pkgs.zsh-autosuggestions;
      #}
    #];

#    shellAliases = {
#      ls = "ls --color";
#      ll = "ls -l --color";
#      update = "sudo nixos-rebuild switch --flake .#nixos";
#      clip = "wl-copy";
#      update-home = "home-manager switch --impure";
#    };
##
#    initExtra = ''
#cd() {
#  builtin cd "$@" && ls --color
#}
#function dad() {
#  blobdrop "$1"
#}
#function y() {
#	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
#	yazi "$@" --cwd-file="$tmp"
#	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
#		builtin cd -- "$cwd"
#	fi
#	rm -f -- "$tmp"
#}
#
#PROMPT='♡ %~ %F{magenta}%#%f '
#RPROMPT='♡ '
#EDITOR='vim'
#export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#888888"
#    '';
#  };
#
#}
