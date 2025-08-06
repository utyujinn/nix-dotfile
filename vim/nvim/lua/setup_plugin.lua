-- Plugin Maneger を自動でダウンロードする
local jetpackfile = vim.fn.stdpath('data') .. '/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'
local jetpackurl = "https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim"
if vim.fn.filereadable(jetpackfile) == 0 then
  vim.fn.system(string.format('curl -fsSLo %s --create-dirs %s', jetpackfile, jetpackurl))
end

-- vim-jetpack で入れ込むプラグインをここに記載していく
vim.cmd('packadd vim-jetpack')

require('jetpack.paq') {
  -- ここの中に、プラグインを追記していきます。
  {'tani/vim-jetpack', opt = 1}, -- bootstrap
  {'navarasu/onedark.nvim'},
  {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}, 
  {'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
      }
  },
  {'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { 'nvim-lua/plenary.nvim' },
  },
  {
    'nvim-telescope/telescope-file-browser-nvim',
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },
  {
  'nvim-lualine/lualine.nvim',
  requires = 'kyazdani42/nvim-web-devicons'
  },
  {'neoclide/coc.nvim', branch='release'},
  { 'yamatsum/nvim-cursorline' },
  { 'pechorin/any-jump.vim' },
  {'numToStr/Comment.nvim', config = function() require('Comment').setup() end},
  {'lewis6991/gitsigns.nvim'},
  {'windwp/nvim-ts-autotag'},
  {'pocco81/auto-save.nvim'},
  {'akinsho/bufferline.nvim'},
  {'windwp/nvim-autopairs'},
  {'akinsho/toggleterm.nvim'},
  {'xolox/vim-misc'},
  {'xolox/vim-session'},
  {'rmagatti/auto-session',
    config = function()
    require("auto-session").setup {
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    }
  end,},
}
