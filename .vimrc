" change runtime path
set runtimepath=~/Tools/vim,$VIM/vimfiles,$VIMRUNTIME
let g:ruby_path = ':C:\ruby193\bin'

"call pathogen#runtime_append_all_bundles()
call pathogen#infect()
call pathogen#helptags()

colorscheme vividchalk
"inkpot
"jellybeans
"liquidcarbon
"molokai
"moria
"pinksea
"sonofobsidian
"vividchalk
"wombat256mod

"we don't want vi compatibility AKA Make Vim more useful
" set nocompatible 
set noswapfile
set autoread
set selection=exclusive
set ttimeoutlen=50

let mapleader = ","
let g:ctrlp_map = '<c-p>'
let g:ctrlp_working_path_mode = 2

map <Space> :noh<CR>

imap <C-h> <C-O><C-w>h
imap <C-j> <C-O><C-w>j
imap <C-k> <C-O><C-w>k
imap <C-l> <C-O><C-w>l
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <A-k> <C-w>+
map <A-j> <C-w>-
map <A-l> <C-w>>
map <A-h> <C-w><

map <leader>x :%s/\s\+$//<CR>:noh<Cr>
map <leader>v :tabedit ~/.vimrc<CR>

map <leader><leader> :b#<cr>

map <F1> <Nop>

nmap <leader>n :NERDTreeToggle %:p:h<CR>
nmap <leader>m :NERDTreeClose<CR>:NERDTreeFind<CR>
nmap <leader>t :TlistToggle<CR>
map <leader>T 0f<ca<

noremap ;; :%s:::g<Left><Left><Left>
cmap ;\ \(\)<Left><Left>

syntax enable

"airline config
" the separator used on the left side >
let g:airline_left_sep='>'

" the separator used on the right side >
let g:airline_right_sep='<'

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
" let g:airline_theme=

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
let g:airline_powerline_fonts=0

" define the set of text to display for each mode.  
let g:airline_mode_map = {} " see source for the defaults

  " or copy paste the following into your vimrc for shortform text
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


" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
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
set encoding=utf-8 nobomb
" Change mapleader
let mapleader=","
" Don’t add empty newlines at the end of files
set binary
set noeol

" Centralize backups, swapfiles and undo history
set backupdir=~/Tools/vim/backups
set directory=~/Tools/vim/swaps
set history=256  " Number of things to remember in history.
set t_Co=256

if exists("&undodir")
	set undodir=~/Tools/vim/undo
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
" Make tabs as wide as two spaces
set tabstop=2
set expandtab
set shiftwidth=2
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
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd
" Use relative line numbers
if exists("&relativenumber")
	set relativenumber
	au BufReadPost * set relativenumber
endif
" Start scrolling three lines before the horizontal window border
set scrolloff=3

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Automatic commands
if has("autocmd")
	" Enable file type detection
	filetype on
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
endif


au BufRead,BufNewFile *.jade setfiletype jade
au BufRead,BufNewFile *.markdown setfiletype markdown
au BufRead,BufNewFile *.xaml setfiletype xml
au BufRead,BufNewFile *.spark setfiletype html
au BufRead,BufNewFile *.ps1 setfiletype ps1
au BufRead,BufNewFile *.scala setfiletype scala
au BufRead,BufNewFile *.less setfiletype css
au BufRead,BufNewFile *.go setfiletype go
au BufRead,BufNewFile *.js setfiletype javascript
au BufRead,BufNewFile *.coffee setfiletype coffee
au BufRead,BufNewFile *.iced setfiletype coffee
au BufRead,BufNewFile *.html setfiletype htmldjango
au GUIEnter * set vb t_vb=

if has('gui_running')
  set guioptions -=m
  set guioptions -=T
  set guioptions -=r
  set guioptions -=L
  set guifont=Ubuntu\ Mono:h26,Consolas:h12
endif

let g:ruby_path = ':C:\ruby193\bin'