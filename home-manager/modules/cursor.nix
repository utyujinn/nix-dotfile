{ config, pkgs, inputs, ...}:
{
  home.pointerCursor =
    let
      getFrom = url: hash: name: {
          gtk.enable = true;
          x11.enable = true;
          name = name;
          size = 48;
          package =
            pkgs.runCommand "moveUp" {} ''
              mkdir -p $out/share/icons
              ln -s ${pkgs.fetchzip {
                url = url;
                hash = hash;
              }} $out/share/icons/${name}
          '';
        };
    in
      getFrom
        "https://github.com/utyujinn/lumine_cursor/releases/download/v1.3.0/lumine_cursor_linux.tar.gz"
        "sha256-LLE6broOMrboFCtWAUXkaxg+Fa3pUecTPGbqsdaxJeQ="
        "lumine_cursor_linux";
}
