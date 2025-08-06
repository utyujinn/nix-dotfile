{ config, pkgs, inputs, ...}:
{
  home.sessionVariables = {
    EDITOR = "vim";
    VISUAL = "vim";
  };
  home.packages = with pkgs; [
    vim
    tree-sitter
  ];
  xdg.configFile =
    let
      s = name: { source = ../../vim + "/${name}"; };
    in
    {
      # entry files
      "vim/vimrc" = s "vimrc";
      #"nvim/init.lua" = s "init.lua";
      #"ideavim/ideavimrc" = s "ideavimrc";
    };
}
#  programs.vim = {
#    enable = true;
#    plugins = with pkgs.vimPlugins; [
#      vim-code-dark
#    ];
#    settings = {
#      ignorecase = true;
#    };
#    extraConfig = ''
#set autoindent
#set expandtab
#set tabstop=2
#set shiftwidth=2
#set number
#set ruler
#colorscheme codedark
#
#set hlsearch
#set incsearch
#nnoremap K 10k
#nnoremap J 10j
#nnoremap H 10h
#nnoremap L 10l
#    '';
#};
#
#}
