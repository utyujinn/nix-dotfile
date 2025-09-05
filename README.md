# nix-dotfile
You can setup nixos with i3 desktop by using this in few minutes.
## setup
```
cp /etc/nixos/hardware-configuration.nix nixos/hardware-configuration.nix 
sudo nixos-rebuild switch --flake .#laptop
```

## rclone
```
rclone config
```
name is gdrive.
