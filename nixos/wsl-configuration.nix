{ config, pkgs, lib, inputs, home-manager, ...}:{
  
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.11";
  wsl.enable = true;
  wsl.defaultUser = "unia";

  home-manager = {
    users.unia = import ./wsl-home.nix;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-bak";
    extraSpecialArgs = { inherit inputs; };
  };

  users.users.unia = {
    shell = pkgs.zsh;
  };

  programs = {
    zsh.enable=true;
	  nix-ld.enable = true;
  };
	
	virtualisation.podman = {
    enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  # OxiCloud + Postgres as managed OCI containers (no working directory required)
  virtualisation.oci-containers = {
    backend = "podman";
    containers = {

      oxicloud-postgres = {
        image = "postgres:18.2-alpine3.23";
        environment = {
          POSTGRES_USER     = "postgres";
          POSTGRES_PASSWORD = "postgres";
          POSTGRES_DB       = "oxicloud";
        };
        volumes = [ "oxicloud-pg:/var/lib/postgresql/" ];
        extraOptions = [
          "--network=oxicloud-net"
          "--health-cmd=pg_isready -U postgres"
          "--health-interval=5s"
          "--health-retries=5"
        ];
      };

      oxicloud = {
        image = "diocrafts/oxicloud:latest";
        ports = [ "8086:8086" ];
        environment = {
          OXICLOUD_DB_CONNECTION_STRING = "postgres://postgres:postgres@oxicloud-postgres/oxicloud";
          OXICLOUD_SERVER_HOST          = "0.0.0.0";
          OXICLOUD_SERVER_PORT          = "8086";
          OXICLOUD_OIDC_ENABLED         = "false";
          OXICLOUD_WOPI_ENABLED         = "false";
          MIMALLOC_PURGE_DELAY          = "0";
          MIMALLOC_ALLOW_LARGE_OS_PAGES = "0";
        };
        volumes = [ "oxicloud-storage:/app/storage" ];
        extraOptions = [ "--network=oxicloud-net" ];
        dependsOn   = [ "oxicloud-postgres" ];
      };

    };
  };

  # Create the podman network before containers start
  systemd.services.oxicloud-network = {
    description = "Create oxicloud-net podman network";
    before  = [ "podman-oxicloud-postgres.service" "podman-oxicloud.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type            = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.bash}/bin/sh -c '${pkgs.podman}/bin/podman network create oxicloud-net 2>/dev/null; true'";
      ExecStop  = "${pkgs.bash}/bin/sh -c '${pkgs.podman}/bin/podman network rm -f oxicloud-net 2>/dev/null; true'";
    };
  };

	services.tailscale.enable = true;
	services.cloudflared = {
  enable = true;
  tunnels = {
    "oxicloud" = {
      credentialsFile = "/etc/cloudflared/oxicloud.json";
      default = "http_status:404";
      ingress = {
        "cloud.utyujin.com" = "http://localhost:8086";
        "talk.utyujin.com"  = "http://localhost:8000";
      };
    };
  };
};

	environment.systemPackages = with pkgs; [
    # Development
    python3
    uv
    gcc
    git
		cloudflared
    claude-code

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

  fonts = {
    packages = with pkgs; [
      udev-gothic
      source-han-serif
      source-han-sans
      (pkgs.stdenv.mkDerivation {
        name = "Kosefont JP";
        src = pkgs.fetchFromGitHub {
          owner = "lxgw";
          repo = "kose-font";
          rev = "v3.123";
          sha256 = "sha256-WDVMsdU9ZWWl0txziT70lbS0gGde+aCl5TBZ4OhEjHg=";
        };
        installPhase = ''
          install -d -m755 $out/share/fonts/truetype
          find . -name "*.ttf" -exec install -m644 {} $out/share/fonts/truetype/ \;
        '';
      })
    ];
    fontconfig = {
      defaultFonts = {
        serif     = [ "Source Han Serif" "Kosefont JP" ];
        sansSerif = [ "Source Han Sans"  "Kosefont JP" ];
        monospace = [ "UDEV Gothic" ];
      };
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
	systemd.services."sysinit-reactivation".serviceConfig.TimeoutSec = 10;
}
