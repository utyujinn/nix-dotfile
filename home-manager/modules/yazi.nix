{ config, pkgs, inputs, ...}:
{
  #xdg.configFile = builtins.foldl
  xdg.configFile =
    let
      s = name: { source = ../../yazi + "/${name}"; };
    in
    {
      # entry files
      "yazi/yazi.toml" = s "yazi.toml";
      "yazi/keymap.toml" = s "keymap.toml";
      #"nvim/init.lua" = s "init.lua";
      #"ideavim/ideavimrc" = s "ideavimrc";
    };
}
#  programs.yazi = {
#    enable = true;
#    settings = {
#      opener = {
#        xournalpp = [
#          { run = "xournalpp \"$@\""; orphan = true; for = "unix"; }
#        ];
#        pdf = [
#          { run = "evince \"$@\""; orphan = true; for = "unix"; }
#        ];
#      };
#      open = {
#        prepend_rules = [
#          { name = "*.xopp"; use = "xournalpp"; }
#          { name = "*.pdf"; use = "pdf"; }
#        ];
#      };
#    };
#  };
#}
