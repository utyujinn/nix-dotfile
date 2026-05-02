{ config, pkgs, lib, home-manager, ...}:{
  
  system.stateVersion = "25.11";
  wsl.enable = true;
  wsl.defaultUser = "unia";
  
  
  home-manager = {
    users.unia = import ./wsl-home.nix;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-bak";
  };

  users.users.unia = {
    shell = pkgs.zsh;
  };

  programs.zsh.enable=true;
	programs.nix-ld.enable = true;
	
	virtualisation.podman.enable = true;
	
	services.tailscale.enable = true;

	environment.systemPackages = with pkgs; [
		
    # Development
    python3
    uv
    gcc
    git
		podman-compose

    # Text Editors
		vim
    neovim
    emacs

    # Terminal Tools
    wget
    yazi
    zsh
    zsh-autosuggestions
    dbus
    rclone
    zoxide
    tree
    gh
    atuin

	];

	systemd = {
    user.services.dbus-broker = {
      # Override the restart behavior
      serviceConfig.Restart = lib.mkForce "no";
    };
    services.seafile = {
      after = [ "network.target" "podman.socket" ];
      requires = [ "podman.socket" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        WorkingDirectory = "/home/unia/seafile";  # compose.ymlのある場所
        ExecStart = "${pkgs.podman}/bin/podman compose up -d";
        ExecStop = "${pkgs.podman}/bin/podman compose down";
        Environment = "PATH=${pkgs.podman}/bin:${pkgs.podman-compose}/bin:/run/current-system/sw/bin";
      };
    };
  };
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
