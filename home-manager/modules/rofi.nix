{ config, pkgs, ... }:

{
  #programs.rofi.enable = true;

  
  xdg.configFile."rofi".source = pkgs.fetchFromGitHub{
    owner = "adi1090x";
    repo = "rofi";
    rev = "master"; # 2024年7月頃の最新コミット
    sha256 = "sha256-iUX0Quae06tGd7gDgXZo1B3KYgPHU+ADPBrowHlv02A=";
  };

  # 5. テーマに必要なフォントをインストール
  #home.packages = with pkgs; [
    ##(nerdfonts.override { fonts = [ "JetBrainsMono" "Iosevka" ]; })
  #];
  
  # 6. スクリプトディレクトリにPATHを通す
  #home.sessionPath = [
    #"$HOME/.config/rofi/scripts"
  #];

  # ... 他のhome-manager設定 ...
}
