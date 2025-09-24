{ config, pkgs, inputs, ...}:
{
  home.file.".tmux.conf" = {
    source = ../apps/tmux/tmux.conf;
  };
}
