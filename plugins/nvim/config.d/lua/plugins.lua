
vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Git 
    use 'tpope/vim-fugitive'


    -- Utils
    use 'scrooloose/syntastic'
    use 'kien/ctrlp.vim'
    use 'scrooloose/nerdtree'
    use 'tpope/vim-dadbod'

    -- use 'bling/vim-airline'
	use {
	  'nvim-lualine/lualine.nvim',
	  requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	}
    use 'tpope/vim-dispatch'

    -- Themes
    use 'wdhg/dragon-energy'
    use 'FrancescoMagliocco/CmptrClr'
    use 'sainnhe/gruvbox-material'
    use 'cjgajard/patagonia-vim'
    use 'ciaranm/inkpot'
    use 'lsdr/monokai'
    use 'chriskempson/vim-tomorrow-theme'
    use 'vim-scripts/vilight.vim'
    use 'dsolstad/vim-wombat256i'
    use 'altercation/vim-colors-solarized'
    use 'nanotech/jellybeans.vim'
    use 'vim-scripts/ecostation'
    use 'vim-scripts/rdark'
    use 'trevorrjohn/vim-obsidian'
    use 'sotte/presenting.vim'

    -- Syntax Highlighting
    use 'cakebaker/scss-syntax.vim'
    use 'pangloss/vim-javascript'
    use 'vim-ruby/vim-ruby'
    use 'vim-scripts/matchit.zip'
    use 'oscarh/vimerl'
    use 'sukima/xmledit'
    use 'mxw/vim-jsx'
    use 'gorodinskiy/vim-coloresque'
    use 'groenewege/vim-less'
    use 'tpope/vim-markdown'
    use 'tpope/vim-haml'

	-- golang
	use 'ray-x/go.nvim'
	use 'ray-x/guihua.lua' -- recommanded if need floating window support
	use 'neovim/nvim-lspconfig'
	use 'nvim-treesitter/nvim-treesitter'
	use 'nvim-lua/plenary.nvim'


end)
