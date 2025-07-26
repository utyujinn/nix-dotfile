{ config, pkgs, inputs, ...}:
{
  systemd.user.services.rclone-gdrive-mount = {
    Unit = {
      Description = "Service that connects to Google Drive";
      #After = [ "network-online.target" ];
      #Requires = [ "network-online.target" ];
    };
    Install = {
      WantedBy = [ "default.target" ];
    };

    Service = let
      gdriveDir = "/home/utyujin/gdrive";
      in
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

}
