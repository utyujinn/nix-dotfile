{ config, pkgs,...}:

{
  fonts = {
    packages = with pkgs; [
      udev-gothic
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
        serif = [ "UDEV Gothic" "Kosefont JP" "setofont" ];
        sansSerif = [ "UDEV Gothic" "Kosefont JP" "setofont" ];
        monospace = [ "UDEV Gothic" "Kosefont JP" "setofont" ];
      };
    };
  };
}
