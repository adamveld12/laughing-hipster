-------------------- LEADER -------------------------------
-- must be set before any mapping is defined
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-------------------- HELPERS ------------------------------

local opt = vim.opt

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local config_dir = vim.fn.stdpath('config')

-------------------- OPTIONS ------------------------------

opt.number = true
opt.relativenumber = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.termguicolors = true
opt.autochdir = true

-- Enhance command-line completion
opt.wildmenu = true
-- Allow backspace in insert mode
opt.backspace = 'indent,eol,start'
-- Optimize for fast terminal connections
opt.ttyfast = true
-- Add the g flag to search/replace by default
opt.gdefault = true
-- Use UTF-8 without BOM
opt.encoding = 'utf-8'

opt.binary = true

-- Number of things to remember in history.
opt.history = 500

opt.wildignore = '*.png,*.jpg,node_modules,*.min.js,*.txt,*.bak,*.exe,vendor.js'

opt.tags = './.git/tags,tags'

opt.clipboard:append('unnamedplus')

opt.guifont = 'Pragmata Pro Mono Liga:h12,Literation_Mono_for_Powerline:h12,Inconsolata for Powerline:h10,Ubuntu Mono:h26,Consolas:h12,Courier:h12'

opt.listchars = {tab = '▸ ', trail = '·', eol = '¬', nbsp = '_'}
opt.list = true

opt.omnifunc = 'syntaxcomplete#Complete'
opt.completeopt:remove('preview')

-- Highlight searches
opt.hlsearch = true
-- Ignore case of searches
opt.ignorecase = true
-- Highlight dynamically as pattern is typed
opt.incsearch = true
-- Always show status line
opt.laststatus = 2
-- Enable mouse in all modes
opt.mouse = 'a'
-- Disable error bells
opt.errorbells = false
-- Dont reset cursor to start of line when moving around.
opt.startofline = false
-- Show the cursor position
opt.ruler = true
-- Dont show the intro message when starting Vim
opt.shortmess = 'atI'
-- Show the current mode
opt.showmode = true
-- Show the filename in the window titlebar
opt.title = true
-- Show the (partial) command as its being typed
opt.showcmd = true
-- Start scrolling x lines before the horizontal window border
opt.scrolloff = 4

-------------------- PROVIDERS ----------------------------

vim.g.node_host_prog = vim.call('system', 'which neovim-node-host | tr -d "\n"')

-------------------- PLUGIN SETTINGS ----------------------

-- neovide
if vim.g.neovide then
    vim.g.neovide_cursor_vfx_mode = 'railgun'
end

-------------------- MAPPINGS -----------------------------

map('n', '<Space>', ':noh<CR>')   -- Clear highlights
map('n', '\\', '<cmd>noh<CR>')    -- Clear highlights

-- replace with regular newlines
map('', '<leader>k', ':%s/ //g<CR>')

-- list buffers
map('', '<leader>w', ':buffers<CR>')

-- write
map('n', '<leader>ww', ':w<CR>')

-- open errors
map('', '<leader>e', ':lw 5<CR>')

-- nerdtree
map('n', '<leader>n', ':NERDTreeToggle %:p:h<CR>', {noremap = false})
map('n', '<leader>m', ':NERDTreeClose<CR>:NERDTreeFind<CR>', {noremap = false})

-- telescope (replaces ctrlp's <C-P>)
map('n', '<C-P>', '<cmd>Telescope find_files<CR>')
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>')
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>')
map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>')

-- pane resizing
map('', '<C-w>', ':resize -3<Cr>')
map('', '<C-x>', ':resize +3<Cr>')
map('', '<C-a>', ':vertical resize +3<Cr>')
map('', '<C-d>', ':vertical resize -3<Cr>')

map('', '<C-S-Left>', ':vertical resize -5<CR>')
map('', '<C-S-Right>', ':vertical resize +5<CR>')
map('', '<C-S-Up>', ':resize +5<CR>')
map('', '<C-S-Down>', ':resize -5<CR>')

-- pane movements
map('', '<C-h>', '<C-w>h')
map('', '<C-j>', '<C-w>j')
map('', '<C-k>', '<C-w>k')
map('', '<C-l>', '<C-w>l')

-- remove trailing whitespace
map('', '<leader>x', ':%s/\\s\\+$//<CR>:noh<Cr>')

-- reload vim config
map('', '<leader>rr', ':so ' .. config_dir .. '/init.lua<CR>')
map('n', '<Leader>sv', ':source $MYVIMRC<CR>')

-- open vimrc in a new tab
map('', '<leader>v', ':tabedit ' .. config_dir .. '/init.lua<CR>')
map('', '<F1>', '<Nop>')

-- Save a file as root
map('', '<leader>W', ':w !sudo tee % > /dev/null<CR>')

-- generate tags
map('n', '<leader>c', ':! ctags -R -f ./.git/tags .<CR>')

-- <Tab> to navigate the completion menu
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

map('n', '<Leader>j', ':j<CR>')
map('n', '<Leader>J', ':j!<CR>')

-- keep visual selection after indenting
map('v', '>', '>gv')
map('v', '<', '<gv')

-- copy file path
map('n', '<Leader>cp', ':let @*=expand("%")<CR>')

map('n', '<S-u>', '<C-u>')

map('n', 'qo', ':only<CR>')

-- move selection using jk
map('v', '<S-j>', ':m\'>+<CR>gv=gv')
map('v', '<S-k>', ':m-2<CR>gv=gv')

-- escape visual selection
map('v', ';;', '<Esc>')

-- macro recording re-enabled (q for record, Q for Ex mode)
map('n', 'qq', ':q<CR>')
map('n', 'QQ', ':q!<CR>')

-- paste on selection
map('x', 'p', [["_dP]])

-------------------- AUTOCOMMANDS -------------------------

vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('yank_highlight', {clear = true}),
    callback = function()
        vim.hl.on_yank {on_visual = false, timeout = 200}
    end,
})

-- Remove trailing space
vim.api.nvim_create_autocmd('InsertLeavePre', {
    group = vim.api.nvim_create_augroup('strip_trailing_ws', {clear = true}),
    command = [[:%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('packer_user_config', {clear = true}),
    pattern = 'plugins.lua',
    command = 'source <afile> | PackerCompile',
})

-------------------- PLUGINS ------------------------------

local ok, bootstrapped = pcall(require, 'plugins')
if not ok then
    vim.notify('failed to load plugins: ' .. tostring(bootstrapped), vim.log.levels.WARN)
end

pcall(require, 'lsp')
pcall(require, 'treesitter')

-- packer just cloned itself; pull everything down on this first run
if ok and bootstrapped then
    vim.cmd('PackerSync')
end

-------------------- COLORSCHEME --------------------------
-- ships via packer (vim-scripts/ecostation), so it is missing until PackerSync runs
-- alternatives: gruvbox-material, jellybeans, monokai, slate, vilight
pcall(vim.cmd.colorscheme, 'ecostation')
