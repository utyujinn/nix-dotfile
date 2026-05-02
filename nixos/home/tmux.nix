{ config, pkgs, inputs, ...}:
{
  home.file.".tmux.conf" = {
    source = ../dotfile/tmux/tmux.conf;
  };
}
