{ config, pkgs, inputs, ...}:
let
	gdriveDir = "/home/utyujin/gdrive";
	seafileDir = "/home/utyujin/seafile";
	oxicloudDir = "/home/unia/oxicloud";
in
{
  xdg.configFile."rclone/rclone.conf".source = ../dotfile/rclone/rclone.conf;

  systemd.user.services.rclone-gdrive-mount = {
    Unit = {
      Description = "Service that connects to Google Drive";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };

    Service = 
      {
        Type = "simple";
        ExecStartPre = "/run/current-system/sw/bin/mkdir -p ${gdriveDir}";
        ExecStart = "${pkgs.rclone}/bin/rclone mount --vfs-cache-mode full gdrive: ${gdriveDir}";
        ExecStop = "/run/current-system/sw/bin/fusermount -u ${gdriveDir}";
        Restart = "on-failure";
        RestartSec = "10s";
        Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
      };
    };
		# --- Seafile Mount ---
  systemd.user.services.rclone-seafile-mount = {
    Unit.Description = "Service that connects to Seafile via WebDAV";
    Install.WantedBy = [ "default.target" ];
    Service = {
      Type = "simple";
      ExecStartPre = "/run/current-system/sw/bin/mkdir -p ${seafileDir}";
      # rclone configで設定した名前 "seafile:" を使用
      ExecStart = "${pkgs.rclone}/bin/rclone mount --vfs-cache-mode full seafile: ${seafileDir}";
      ExecStop = "/run/current-system/sw/bin/fusermount -u ${seafileDir}";
      Restart = "on-failure";
      RestartSec = "10s";
      Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
    };
  };

  systemd.user.services.rclone-oxicloud-mount = {
    Unit = {
      Description = "Mount OxiCloud via WebDAV (rclone)";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };
    Install.WantedBy = [ "default.target" ];
    Service = {
      Type = "simple";
      ExecStartPre = "/run/current-system/sw/bin/mkdir -p ${oxicloudDir}";
      ExecStart = "${pkgs.rclone}/bin/rclone mount --vfs-cache-mode full oxicloud: ${oxicloudDir}";
      ExecStop = "/run/current-system/sw/bin/fusermount -u ${oxicloudDir}";
      Restart = "on-failure";
      RestartSec = "10s";
      Environment = [ "PATH=/run/wrappers/bin/:$PATH" ];
    };
  };
}
