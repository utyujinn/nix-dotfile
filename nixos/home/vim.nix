{ config, pkgs, inputs, ...}:
{
  home.sessionVariables = {
    EDITOR = "vim";
    VISUAL = "vim";
  };

  home.packages = with pkgs; [
    vim
  ];

  xdg.configFile."nvim" = {
    source = ../dotfile/vim/nvim; # あなたの環境に合わせてパスを確認
    recursive = true;
  };
  # "vim/vimrc" はもしvimも使うなら残す
  xdg.configFile."vim/vimrc".source = ../dotfile/vim/vimrc;

  programs.neovim = {
    enable = true;
  };
}
