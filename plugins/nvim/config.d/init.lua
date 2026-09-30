vim.opt.termguicolors = true

-- ~/.config/nvim/init.lua is a symlink into the dotfiles repo; load siblings from there
local config_dir = vim.fn.fnamemodify(vim.fn.resolve(vim.env.MYVIMRC), ':h')

require('plugins')
dofile(config_dir .. '/config.lua')
vim.cmd('source ' .. config_dir .. '/init.vim')
