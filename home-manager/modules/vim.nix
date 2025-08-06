{ config, pkgs, inputs, ...}:
{
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  home.packages = with pkgs; [
    vim
  ];

  xdg.configFile."nvim" = {
    source = ../../vim/nvim; # あなたの環境に合わせてパスを確認
    recursive = true;
  };
  # "vim/vimrc" はもしvimも使うなら残す
  xdg.configFile."vim/vimrc".source = ../../vim/vimrc;

  programs.neovim = {
    enable = true;
  };
}
