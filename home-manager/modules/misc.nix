{config, pkgs, inputs, ...}:
{

  #nix-shell -p glib --run "gsettings set org.gnome.desktop.interface toolkit-accessibility true"
    programs.atuin = {
     enable = true;
     settings = {
       auto_sync = false;
       sync_frequency = "5m";
       sync_address = "https://api.atuin.sh";
       search_mode = "fuzzy";
     };
  };
}
