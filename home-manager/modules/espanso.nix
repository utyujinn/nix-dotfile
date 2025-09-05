{ config, pkgs, inputs, ...}:
{
  #services.espanso = {
    #enable = true;
  #};
  home.sessionVariables = {
    ESPANSO_BACKEND = "X11";
  };

  xdg.configFile."espanso" = {
    source = ../apps/espanso;
    recursive = true;
  };
}
