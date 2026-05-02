-- basic_config.luaに記述してあるコードを読み込む
require ('basic_config')
require ('setup_plugin')
require ('colorscheme')
require ('plugins/nvim_tree')
require ('plugins/lualine')
require ('plugins/nvim_cursorline')
require ('plugins/gitsigns')
require ('plugins/auto_save')
require ('plugins/bufferline')
require ('plugins/toggleterm')
require ('plugins/auto_session')


vim.g.mapleader = ' ' -- 半角スペースを設定しています。

vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', {silent=true})

vim.keymap.set('n', ';', ':', {silent=true}) -- シフトを押すことなく、;を入力する。割と便利

vim.keymap.set('n', '<leader>sv', '<C-w>v') -- ウィンドウを垂直方向に分割する
vim.keymap.set('n', '<leader>sh', '<C-w>s') -- ウィンドウを水平に分割する
vim.keymap.set('n', '<leader>se', '<C-w>=') -- ウィンドウの幅を等分にする
vim.keymap.set('n', '<leader>sx', ':close<CR>') -- 現在、カーソルがいるウィンドウを閉じる
vim.keymap.set('n', '<leader>sw', '<C-w>><C-w>><C-w>><C-w>><C-w>><C-w>><C-w>><C-w>>') -- ウィンドウの幅を少し広げる
vim.keymap.set('n', '<leader>sww', '<C-w>><C-w>><C-w>><C-w>><C-w>><C-w>><C-w>><C-w>><C-w>><C-w>><C-w>><C-w>><C-w>><C-w>><C-w>><C-w>>') -- ウィンドウの幅を大きく広げる
vim.keymap.set('n', '<leader>st', '<C-w><<C-w><<C-w><<C-w><<C-w><<C-w><<C-w><<C-w><') -- ウィンドウの幅を少し狭める
vim.keymap.set('n', '<leader>stt', '<C-w><<C-w><<C-w><<C-w><<C-w><<C-w><<C-w><<C-w><<C-w><<C-w><<C-w><<C-w><<C-w><<C-w><<C-w><<C-w><') -- ウィンドウの幅を大きく狭める

-- タブを作成、削除
vim.keymap.set('n', '<leader>to', ':tabnew<CR>')
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>')
vim.keymap.set('n', '<leader>tn', ':tabn<CR>')
vim.keymap.set('n', '<leader>tp', ':tabp<CR>')
-- ウィンドウを移動する
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
-- 単語を' " どちらかで囲う
vim.keymap.set('n', '<leader>aw', 'ciw""<Esc>P')
vim.keymap.set('n', '<leader>aW', "ciw''<Esc>P")

vim.keymap.set('n', '<leader>l', '<cmd>bnext<cr>', opts)
vim.keymap.set('n', '<leader>h', '<cmd>bprevious<cr>', opts)
vim.keymap.set('n', '<leader>q', '<cmd>bdelete<cr>', opts)
vim.keymap.set('n', '<leader>bl', '<cmd>ls<cr>', opts)

vim.keymap.set('c', 'q', 'qa', opts)
