{ config, pkgs, inputs, ...}:
{
  #xdg.configFile = builtins.foldl
  xdg.configFile =
    let
      s = name: { source = ../dotfile/yazi + "/${name}"; };
    in
    {
      # entry files
      "yazi/yazi.toml" = s "yazi.toml";
      "yazi/keymap.toml" = s "keymap.toml";
    };
}