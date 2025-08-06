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


#  xdg.configFile =
#    let
#      s = name: { source = ../../vim + "/${name}"; };
#    in
#    {
#      "vim/vimrc" = s "vimrc";
#      "vim/vimrc" = s "vimrc";
#      "nvim/init.lua" = s "nvim/init.lua";
#      "nvim/lua/basic_config.lua" = s "nvim/basic_config.lua";
#      "nvim/lua/colorscheme.lua" = s "nvim/colorscheme.lua";
#      "nvim/lua/setup_plugin.lua" = s "nvim/setup_plugin.lua";
#      "nvim/lua/plugins/auto_save.lua" = s "nvim/plugins/auto_save.lua";
#      "nvim/lua/plugins/bufferline.lua" = s "nvim/plugins/bufferline.lua";
#      "nvim/lua/plugins/gitsigns.lua" = s "nvim/plugins/gitsigns.lua";
#      "nvim/lua/plugins/lualine.lua" = s "nvim/plugins/lualine.lua";
#      "nvim/lua/plugins/nvim_cursorline.lua" = s "nvim/plugins/nvim_cursorline.lua";
#      "nvim/lua/plugins/nvim_tree.lua" = s "nvim/plugins/nvim_tree.lua";
#      "nvim/lua/plugins/toggleterm.lua" = s "nvim/plugins/toggleterm.lua";
#      "nvim/lua/plugins/auto_session.lua" = s "nvim/plugins/auto_session.lua";
#    };
#
  programs.neovim = {
    enable = true;
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
