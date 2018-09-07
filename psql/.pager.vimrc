call plug#begin('~/.local/share/nvim/plugged')
Plug        '$HOME/.fzf'
Plug     'junegunn/fzf.vim'
Plug        'roxma/vim-tmux-clipboard'
Plug        'dim13/xedit.vim'
Plug  'vim-scripts/Mark--Karkat'
call plug#end()

" No compatibility – necessary for mappings to work.
set nocompatible

" Status line
set laststatus=0
set cmdheight=1
set nomodifiable " Only in version 6.0
" set readonly
set nowrap
set hlsearch                  " highlight search results
set incsearch                 " подсвечивать по мере поиска
set cursorline                " show cursor line
set cursorcolumn              " show cursor column
set mouse=a
" My xterms have a navy-blue background, so I need this line too.
"set background=dark
"set background=light

" Turn syntax on
syntax enable
colorscheme xedit

" Чтобы вертикальный ruler по цвету совпадал с ruler-ом от iterm
hi CursorLine cterm=NONE ctermbg=195
hi CursorColumn ctermbg=195
hi Normal ctermbg=255

" No menu bar and tool bar
set guioptions=aiMr

nmap q :q!<CR>

nmap <PageUp> 20<C-y>
nmap <PageDown> 20<C-e>

nmap <C-j> 20<C-e>
nmap <C-k> 20<C-y>
nmap <C-h> 50zh
nmap <C-l> 50zl

nmap <A-j> 20j
nmap <A-k> 20k
nmap <A-h> 50h
nmap <A-l> 50l

