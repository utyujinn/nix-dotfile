{ config, pkgs, inputs, ... }:

{
  home.username = "utyujin";
  home.homeDirectory = "/home/utyujin";

  imports = [
    #./desktop.nix
    #./systemd.nix
    ./xournalpp.nix
  ];
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
  ];

  home.file = {
  };

  home.sessionVariables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "ibus";
  };

  programs.git = {
    enable = true;
    userName="utyujinn";
    userEmail="hg33fah9@utyujin.com";
  };

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-code-dark
    ];
    settings = {
      ignorecase = true;
    };
    extraConfig = ''
set autoindent
set expandtab
set tabstop=2
set shiftwidth=2
set number
set ruler
colorscheme codedark

set hlsearch
set incsearch
nnoremap K 10k
nnoremap J 10j
nnoremap H 10h
nnoremap L 10l
    '';
};

  programs.zsh = {
    enable = true;
    #enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable=true;
    history.ignoreDups = true;

    #plugins = [
      #{
        #name = "zsh-autosuggestions";
        #src = pkgs.zsh-autosuggestions;
      #}
    #];

    shellAliases = {
      ls = "ls --color";
      ll = "ls -l --color";
      update = "sudo nixos-rebuild switch --flake .#nixos";
      clip = "wl-copy";
      update-home = "home-manager switch --impure";
    };
#
    initExtra = ''
cd() {
  builtin cd "$@" && ls --color
}
function dad() {
  blobdrop "$1"
}
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

PROMPT='♡ %~ %F{magenta}%#%f '
RPROMPT='♡ '
EDITOR='vim'
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#888888"
    '';
  };

  programs.yazi = {
  enable = true;
  settings = {
    opener = {
      xournalpp = [
        { run = "xournalpp \"$@\""; orphan = true; for = "unix"; }
      ];
      pdf = [
        { run = "evince \"$@\""; orphan = true; for = "unix"; }
      ];
    };
    open = {
      prepend_rules = [
        { name = "*.xopp"; use = "xournalpp"; }
        { name = "*.pdf"; use = "pdf"; }
      ];
    };
  };
};

  programs.home-manager.enable = true;

  systemd.user.services.rclone-gdrive-mount = {
    Unit = {
      Description = "Service that connects to Google Drive";
      #After = [ "network-online.target" ];
      #Requires = [ "network-online.target" ];
    };
    Install = {
      WantedBy = [ "default.target" ];
    };

    Service = let
      gdriveDir = "/home/utyujin/gdrive";
      in
      {
        Type = "simple";
        ExecStartPre = "/run/current-system/sw/bin/mkdir -p ${gdriveDir}";
        ExecStart = "${pkgs.rclone}/bin/rclone mount --vfs-cache-mode full gdrive: ${gdriveDir}";
        ExecStop = "/run/current-system/sw/bin/fusermount -u ${gdriveDir}";
        Restart = "on-failure";
        RestartSec = "10s";
        Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
      };
    };

}
