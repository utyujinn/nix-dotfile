{ config, pkgs, ... }:
{
  programs.zsh.enable=true;

  users.users.utyujin = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Utyujin";
    extraGroups = [ "wheel" "uucp" "fuse" "docker" ];
    packages = with pkgs; [];
  };

}
