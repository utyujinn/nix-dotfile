{ config, pkgs, lib, ... }:
{
  xdg.configFile."albert/albert.conf".text = ''
    [General]
    frontend=widgetboxmodel
    show_tray=true
    telemetry=false

    [widgetboxmodel]
    alwaysOnTop=true
    clearOnHide=true
    hideOnFocusLoss=true
    quitOnClose=false
    theme=Dark
  '';
}
