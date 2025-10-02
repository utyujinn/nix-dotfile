{ config, pkgs, ... }:

let
  rofiRepo = pkgs.fetchFromGitHub {
    owner = "adi1090x";
    repo = "rofi";
    rev = "master";
    sha256 = "sha256-iUX0Quae06tGd7gDgXZo1B3KYgPHU+ADPBrowHlv02A=";
  };
in
{
  # rofi設定ファイル（scriptsディレクトリを除外）
  # programs.rofi.enableをfalseにして、手動で設定ファイルを配置
  home.file.".config/rofi/applets".source = "${rofiRepo}/files/applets";
  home.file.".config/rofi/colors".source = "${rofiRepo}/files/colors";
  home.file.".config/rofi/config.rasi".source = "${rofiRepo}/files/config.rasi";
  home.file.".config/rofi/images".source = "${rofiRepo}/files/images";
  home.file.".config/rofi/launchers".source = "${rofiRepo}/files/launchers";
  home.file.".config/rofi/powermenu".source = "${rofiRepo}/files/powermenu";
  home.file.".config/rofi/scripts".source = "${rofiRepo}/files/scripts";

  # スクリプトディレクトリを書き込み可能な場所にコピー
  #home.file.".local/bin" = {
    #source = "${rofiRepo}/files/scripts";
    #recursive = true;
  #};

  # テーマに必要なフォントをインストール（新しい構文）
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
  ];

  # .local/binをPATHに追加
  home.sessionPath = [
    "$HOME/.local/bin"
  ];
}
