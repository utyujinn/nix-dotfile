{ config, pkgs, lib, ... }:
{
  xdg.configFile."rofi/tablet-theme.rasi".text = ''
    * {
        bg:     #111827;
        bg-alt: #1f2937;
        fg:     #f9fafb;
        fg-alt: #6b7280;
        accent: #4c7899;

        background-color: transparent;
        text-color:       @fg;
    }

    window {
        width:            680px;
        background-color: @bg;
        border:           1px;
        border-color:     @accent;
        border-radius:    12px;
        padding:          0px;
    }

    mainbox {
        background-color: transparent;
        spacing:          0px;
        padding:          0px;
    }

    inputbar {
        background-color: @bg-alt;
        border-radius:    12px 12px 0px 0px;
        padding:          14px 16px;
        spacing:          8px;
        children:         [prompt, entry];
    }

    prompt {
        background-color: transparent;
        text-color:       @accent;
    }

    entry {
        background-color:  transparent;
        text-color:        @fg;
        placeholder-color: @fg-alt;
        placeholder:       "Search apps and files...";
        cursor-color:      @accent;
    }

    listview {
        background-color: transparent;
        padding:          8px;
        spacing:          2px;
        lines:            9;
        scrollbar:        false;
    }

    element {
        background-color: transparent;
        border-radius:    8px;
        padding:          10px 12px;
        spacing:          12px;
        orientation:      horizontal;
        children:         [element-icon, element-text];
    }

    element-icon {
        background-color: transparent;
        size:             28px;
    }

    element-text {
        background-color: transparent;
        text-color:       @fg;
        vertical-align:   0.5;
    }

    element selected.normal {
        background-color: @accent;
    }

    element selected.normal element-text {
        text-color: #ffffff;
    }

    mode-switcher {
        background-color: @bg-alt;
        border-radius:    0px 0px 12px 12px;
        padding:          8px;
        spacing:          4px;
        border:           1px 0px 0px 0px;
        border-color:     #374151;
    }

    button {
        background-color: transparent;
        text-color:       @fg-alt;
        border-radius:    6px;
        padding:          4px 12px;
        cursor:           pointer;
    }

    button selected {
        background-color: @accent;
        text-color:       #ffffff;
    }
  '';

  # fd でホーム全体を再帰検索するカスタムスクリプトモード
  home.file.".local/bin/rofi-file-search" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      # 選択時: xdg-open で開く
      if [[ "''${ROFI_RETV:-0}" == "1" ]]; then
        xdg-open "$1" &
        exit 0
      fi
      # 一覧: ホーム以下のファイルを高速列挙
      ${pkgs.fd}/bin/fd . \
        --type f \
        --hidden \
        --exclude .git \
        --exclude .cache \
        --exclude node_modules \
        --exclude __pycache__ \
        --exclude ".local/share/Trash" \
        --max-depth 12 \
        --search-path "$HOME" 2>/dev/null
    '';
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = "${config.xdg.configHome}/rofi/tablet-theme.rasi";
    extraConfig = {
      modi         = "drun,file-search:${config.home.homeDirectory}/.local/bin/rofi-file-search,window";
      show-icons   = true;
      icon-theme   = "Adwaita";
      display-drun        = "Apps";
      display-file-search = "Files";
      display-window      = "Windows";
      drun-display-format = "{name}";
    };
  };
}
