-- nvim-treesitter is installed on the `main` branch, which is a full
-- incompatible rewrite. The `require('nvim-treesitter.configs').setup{}` call
-- that most guides still show is `master`-branch API and does not exist here.
--
-- Parser installation needs tree-sitter-cli (>= 0.26.1) and a C compiler;
-- plugins/nvim/nvim.sh installs the CLI via brew.
--
-- Run :TSUpdate after every nvim-treesitter update to keep parsers in step
-- with the plugin. This plugin does not support lazy-loading.

local languages = {
    'bash',
    'css',
    'go',
    'gomod',
    'html',
    'javascript',
    'json',
    'lua',
    'markdown',
    'markdown_inline',
    'ruby',
    'scss',
    'tsx',
    'typescript',
    'xml',
    'yaml',
}

local ok, ts = pcall(require, 'nvim-treesitter')
if not ok then
    return
end

-- async, and a no-op once the parsers are present
pcall(ts.install, languages)

-- highlighting is Neovim's, not the plugin's -- see :h treesitter-highlight
vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('treesitter_highlight', {clear = true}),
    pattern = languages,
    callback = function()
        pcall(vim.treesitter.start)
    end,
})
