" change runtime path
set runtimepath=,$VIMRUNTIME,$VIM/vimfiles,~/Tools/vim


execute pathogen#infect()
execute pathogen#helptags()


set omnifunc=syntaxcomplete#Complete

"we don't want vi compatibility AKA Make Vim more useful
set nocompatible 

" color schemes
colorscheme hickop "jellybeans 
"hickop
"pablo
"torte
"slate
"evening
"darkblue
"desert
"base16-flat
"inkpot
"jellybeans
"liquidcarbon
"molokai
"moria
"pinksea
"sonofobsidian
"vividchalk
"wombat256mod
"evening
"koehler
"morning
"elflord

let mapleader = ","

map <Space> :noh<CR>
map <leader>w :buffers<CR>
map <leader>q :buffer#<CR>

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


" pane resizing
nnoremap <C-w> :resize -2<Cr>
nnoremap <C-s> :resize +2<Cr>
nnoremap <C-a> :vertical resize +2<Cr>
nnoremap <C-d> :vertical resize -2<Cr>

"pane movements
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

map <leader>x :%s/\s\+$//<CR>:noh<Cr>
map <leader>v :tabedit ~/.vimrc<CR>
map <F1> <Nop>

" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

set noswapfile
set autoread
set selection=exclusive
set ttimeoutlen=50
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
set encoding=utf-8 "nobomb
" Change mapleader
let mapleader=","
" Don't add empty newlines at the end of files
set binary
set noeol
set history=500  " Number of things to remember in history.
set t_Co=256

" Centralize backups, swapfiles and undo history
if exists("&backupdir")
  set backupdir=~/Tools/vim/backups
endif
if exists("&directory")
  set directory=~/Tools/vim/swaps
endif
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
" Use relative line numbers
if exists("&relativenumber")
  set relativenumber
  au BufReadPost * set relativenumber
endif
" Start scrolling three lines before the horizontal window border
set scrolloff=4


" vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
 
"
au FileType go nmap <Leader>r <Plug>(go-rename)

" show type info 
au FileType go nmap <Leader>i <Plug>(go-info)

" go def
au FileType go nmap <Leader>di <Plug>(go-def-split)
au FileType go nmap <Leader>ds <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

" go docs
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gs <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)

" ctrl p
let g:ctrlp_map = '<C-P>'

let g:go_disable_autoinstall = 0  
let g:ctrlp_working_path_mode = 2

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

" Enable file type detection
filetype plugin on
filetype on

" Automatic commands
if has("autocmd")
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
	" Treat .md files as Markdown
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown

  autocmd BufRead,BufNewFile *.aspx setfiletype apsx syntax=htmldjango
  autocmd BufRead,BufNewFile *.ascx setfiletype ascx syntax=htmldjango
  autocmd BufRead,BufNewFile *.spark setfiletype spark syntax=htmldjango
  autocmd BufRead,BufNewFile *.html setfiletype html syntax=htmldjango
  autocmd BufRead,BufNewFile *.template setfiletype html template syntax=htmldjango
  autocmd BufRead,BufNewFile *.iced setfiletype icedcoffee syntax=coffee
  autocmd BufRead,BufNewFile *.go setfiletype golang syntax=go
endif


au GUIEnter * set vb t_vb=

" Strip trailing whitespace (,ss)
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>


if has('gui_running')
  set go =mt
  set guifont=Literation\ Mono\ for\ Powerline:h12,Literation_Mono_for_Powerline:h12,Inconsolata\ for\ Powerline:h10,Ubuntu\ Mono:h26,Consolas:h12,Courier:h12
endif

let g:ruby_path = ':C:\ruby193\bin'