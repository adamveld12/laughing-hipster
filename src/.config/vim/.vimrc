" change runtime path
set runtimepath=~/.config/vim/runtime/

execute pathogen#infect()
execute pathogen#helptags()

"we don't want vi compatibility AKA Make Vim more useful
set nocompatible

"color schemes
colorscheme torte
"colorscheme jellybeans
"colorscheme molokai
"colorscheme wombat256i
"colorscheme dragon-energy
"colorscheme patagonia-vim
"colorscheme vim-colors-solarized
"colorscheme vim-obsidian
"colorscheme rdark
"colorscheme ecostation
"colorscheme vilight
"colorscheme vim-tomorrow-theme
"colorscheme monokai
"colorscheme inkpot
"colorscheme CmptrClr

set omnifunc=syntaxcomplete#Complete
set completeopt-=preview

set wildignore=*.png,*.jpg,node_modules,*.min.js,*.txt,*.bak,*.exe,vendor.js
set autochdir
set tags=./.git/tags,tags;$HOME
set noswapfile
set backupcopy=yes
set autoread
set selection=exclusive
set ttimeoutlen=60
set termguicolors
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamedplus
" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
set esckeys
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
set noeol

set history=500  " Number of things to remember in history.
set t_Co=256

" Centralize backups, swapfiles and undo history
if exists("&backupdir")
  set backupdir=~/.config/vim/backups/
endif
if exists("&directory")
  set directory=~/.config/vim/swaps/
endif
if exists("&undodir")
  set undodir=~/.config/vim/undo/
endif

" Respect modeline in files
set modeline
set modelines=4

" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure

" Enable line numbers
set number
" Enable syntax highlighting
syntax on
" Highlight current line
set cursorline
" Make tabs as wide as four spaces
set tabstop=4
set expandtab
set shiftwidth=4

" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
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

autocmd FileType javascript setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd Filetype go setlocal ts=4 sw=4 sts=4 noexpandtab


" Change mapleader
let mapleader = ","

map <leader><Space> :HardTimeToggle<CR>

map <Space> :noh<CR>

"replace  with regular newlines
noremap <leader>k :%s///g<CR>

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

" strips whitespace
noremap <leader>ws :call StripWhitespace()<CR>

" Strip trailing whitespace (,ss)
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction


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
noremap <leader>rr :so ~/.vimrc<CR>

"open vimrc in a new tab
map <leader>v :tabedit ~/.vimrc<CR>
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

let g:go_disable_autoinstall = 0

"airline config
let g:airline#extensions#tabline#enabled = 1
" the separator used on the left side >
"let g:airline_left_sep='>'
" the separator used on the right side >
"let g:airline_right_sep='<'
" enable modified detection >
let g:airline_detect_modified=1
" enable paste detection >
let g:airline_detect_paste=1
" enable iminsert detection >
let g:airline_detect_iminsert=1
" determine whether inactive windows should have the left section collapsed to only the filename of that buffer.
let g:airline_inactive_collapse=1
" enable/disable csv integration for displaying the current column.
let g:airline#extensions#csv#enabled = 1
" customize the whitespace symbol. >
let g:airline#extensions#whitespace#symbol = '.'
" themes are automatically selected based on the matching colorscheme. this can be overridden by defining a value.
"let g:airline_theme=
" if you want to patch the airline theme before it gets applied, you can supply the name of a function where you can modify the palette.
let g:airline_theme_patch_func = 'AirlineThemePatch'
function! AirlineThemePatch(palette)
  if g:airline_theme == 'badwolf'
    for colors in values(a:palette.inactive)
      let colors[3] = 245
    endfor
  endif
endfunction
" enable/disable automatic population of the `g:airline_symbols` dictionary with powerline symbols.
let g:airline_powerline_fonts=1
" define the set of text to display for each mode.
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '' : 'V',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ }
" defines whether the preview window should be excluded from have its window statusline modified (may help with plugins which use the preview window heavily) >
let g:airline_exclude_preview = 0
" change the text for when no branch is detected >
let g:airline#extensions#branch#empty_message = 'No Branch'
" truncate long branch names to a fixed length >
let g:airline#extensions#branch#displayed_head_limit = 15
" enable/disable fugitive/lawrencium integration >
let g:airline#extensions#branch#enabled = 1

" syntastic settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_loc_list_height = 1
let g:syntastic_enable_balloons = 1

let g:syntastic_javascript_checkers = ['standard']

" YCM
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']

" Enable file type detection
filetype plugin indent on

augroup myvimrc
  au!
  au BufWritePost .vimrc so $MYVIMRC
augroup END

" Automatic commands
if has("autocmd")
    " Treat .json files as .js
    autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
    " Treat .md files as Markdown
    autocmd BufNewFile,BufRead *.md setlocal filetype=markdown

    autocmd BufRead,BufNewFile *.html setfiletype html syntax=htmldjango
    autocmd BufRead,BufNewFile *.template setfiletype html template syntax=htmldjango
    autocmd BufRead,BufNewFile *.go setfiletype golang syntax=go
    autocmd BufRead,BufNewFile *.php setfiletype php syntax=go
    autocmd BufRead,BufNewFile Dockerfile* setfiletype Dockerfile syntax=go
    " Spell check and line wrap just for git commit messages
    autocmd Filetype gitcommit setlocal spell textwidth=80
endif


au GUIEnter * set vb t_vb=

if has('gui_running')
  set go =mt
  set guifont=Literation\ Mono\ for\ Powerline:h12,Literation_Mono_for_Powerline:h12,Inconsolata\ for\ Powerline:h10,Ubuntu\ Mono:h26,Consolas:h12,Courier:h12
endif