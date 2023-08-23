
colorscheme ecostation
" colorscheme gruvbox-material
" colorscheme jellybeans
" colorscheme monokai
" colorscheme slate
" colorscheme vilight

filetype plugin indent on


set number
set tabstop=4
set shiftwidth=4
set expandtab
set termguicolors
set autochdir
" Enhance command-line completion
set wildmenu
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Use UTF-8 without BOM
set encoding=utf-8 "nobomb

set binary

" Don't add empty newlines at the end of files
" set noeol

set history=500  " Number of things to remember in history.
set t_Co=256

syntax on

set wildignore=*.png,*.jpg,node_modules,*.min.js,*.txt,*.bak,*.exe,vendor.js

set tags=./.git/tags,tags

set clipboard+=unnamedplus


set guifont=Pragmata\ Pro\ Mono\ Liga:h12,Literation_Mono_for_Powerline:h12,Inconsolata\ for\ Powerline:h10,Ubuntu\ Mono:h26,Consolas:h12,Courier:h12

set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_

set omnifunc=syntaxcomplete#Complete
set completeopt-=preview

set list
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Enable mouse in all modes
set mouse=a
" Disable error bells
set noerrorbells
" Dont reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Dont show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as its being typed
set showcmd

" Start scrolling x lines before the horizontal window border
set scrolloff=4

lua require('plugins')
lua require('lsp')

" Change mapleader
let mapleader = ","

map <leader><Space> :HardTimeToggle<CR>

map <Space> :noh<CR>

"replace with regular newlines
noremap <leader>k :%s/ //g<CR>

"list buffers
map <leader>w :buffers<CR>

" open erros
map <leader>e :lw 5<CR>

" mini buffer explorer toggle
map <Leader>b :MBEToggle<cr>

" easymotion mappings
" n character search
map <leader>/ <Plug>(easymotion-tn)
" 2 character search
map <leader>s <Plug>(easymotion-s2)

" nerdtree mapppings
nmap <leader>n :NERDTreeToggle %:p:h<CR>
nmap <leader>m :NERDTreeClose<CR>:NERDTreeFind<CR>


if exists("g:neovide")
    let g:neovide_cursor_vfx_mode = "railgun"
endif


" pane resizing
noremap <C-w> :resize -3<Cr>
noremap <C-x> :resize +3<Cr>
noremap <C-a> :vertical resize +3<Cr>
noremap <C-d> :vertical resize -3<Cr>

"pane movements
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

map <leader>x :%s/\s\+$//<CR>:noh<Cr>

"reload vim config
noremap <leader>rr :so ~/.config/nvim/init.vim<CR>

"open vimrc in a new tab
map <leader>v :tabedit ~/.config/nvim/init.vim<CR>
map <F1> <Nop>

" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" generate tags
nnoremap <leader>c :! ctags -R -f ./.git/tags .<CR>

" enable neocomplete
let g:neocomplete#enable_at_startup = 0

" Use smartcase
let g:neocomplete#enable_smart_case = 0

" indent guides 
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

" tern
let g:tern_show_argument_hits='on_hold'
let g:tern_map_keys=1
let g:tern_map_prefix = '<leader>'

" vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1
" -b -w -p"

let g:syntastic_go_checkers = ['go', 'errcheck', 'gofmt', 'golint', 'govet']
"let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" Automatic commands
if has("autocmd")
  " Use relative line numbers
  if exists("&relativenumber")
    set relativenumber
    au BufReadPost * set relativenumber
  endif

  " rename symbol
  au FileType go nmap <Leader>r <Plug>(go-rename)

  " show type info
  au FileType go nmap <Leader>ki <Plug>(go-info)

  " go def
  au FileType go nmap <Leader>di <Plug>(go-def-split)
  au FileType go nmap <Leader>ds <Plug>(go-def-vertical)
  au FileType go nmap <Leader>dt <Plug>(go-def-tab)

  " go docs
  au FileType go nmap <Leader>gd <Plug>(go-doc)
  au FileType go nmap <Leader>gi <Plug>(go-doc-vertical)
  au FileType go nmap <Leader>gb <Plug>(go-doc-browser)

endif

augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end

" ctrl p
let g:ctrlp_map = '<C-P>'
"nnoremap <C-l> :CtrlPTag<cr>

let g:ctrlp_cmd = 'CtrlPLastMode'
let g:ctrlp_extensions = ['line']
let g:ctrlp_show_hidden = 1


"'c' - the directory of the current file.
"'a' - the directory of the current file, unless it is a subdirectory of the cwd
"'r' - the nearest ancestor of the current file that contains one of these directories or files: .git .hg .svn .bzr _darcs
"'w' - modifier to "r": start search from the cwd instead of the current file's directory
"0 or '' (empty string) - disable this feature.
let g:ctrlp_working_path_mode = 'ra'

let g:ctrlp_by_filename = 0
let g:ctrlp_max_files = 5000
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

