call plug#begin('~/.local/share/nvim/plugged')
Plug        '$HOME/.fzf'
Plug     'junegunn/fzf.vim'
Plug       'm7onov/nerdtree'
Plug     'f4t-t0ny/nerdtree-hg-plugin'
Plug      'Xuyuanp/nerdtree-git-plugin'
Plug  'vim-airline/vim-airline'
Plug  'vim-airline/vim-airline-themes'
Plug        'roxma/vim-tmux-clipboard'
Plug        'tpope/vim-fugitive'
Plug     'airblade/vim-gitgutter'
Plug        'mhinz/vim-signify'
Plug      'will133/vim-dirdiff'
Plug 'maxbrunsfeld/vim-yankstack'
Plug   'lifepillar/pgsql.vim'
Plug     'Valloric/YouCompleteMe'
Plug   'majutsushi/tagbar'
Plug       'vadimr/bclose.vim'
Plug  'vim-scripts/Mark--Karkat'
Plug         'Houl/repmo-vim'
Plug    'godlygeek/tabular'
Plug     'chrisbra/csv.vim'
call plug#end()

"
" functions
" =============================
function! SyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction

function! AgCW(cmd)
  let cw = expand('<cword>')
  execute a:cmd cw
endfunction

function! NerdTreeFindFunc()
    NERDTreeFind
    NERDTreeFocusToggle
endfunction

"
" Basic vim config
" =============================
set t_Co=256                                " for airline
set number relativenumber                   " line numbers
set cursorcolumn                            " show cursor column
set cursorline                              " show cursor line
set hlsearch                                " highlight search results
set hidden
set incsearch                               " подсвечивать по мере поиска
set expandtab                               " заменять табы на пробелы, когда нажимается клавиша
set tabstop=2                               " сколько пробелов заменяют пробел
set shiftwidth=2                            " размер identation
set mouse=a
set wrap
set breakindent
set showbreak=>>
set list
set listchars=tab:-ͳ
set background=light
set fileencodings+=cp1251,koi8-r,cp866
set laststatus=2
set statusline+=%F                          "full path in statusline
set statusline+=%{SyntaxItem()}
set guioptions-=T                           "remove toolbar
set guioptions-=r                           "remove right-hand scroll bar
set guioptions-=L                           "remove left-hand scroll bar
set guifont=CodeNewRoman\ Nerd\ Font\ 9
set tags=./tags;,tags;
set complete+=k                             "complete config
set completeopt+=longest
set completeopt+=menu
set cscopequickfix=s-,c-,d-,i-,t-,e-,a-     "cscope config
set cscopetag
set cscopepathcomp=2
set guicursor=                              "https://github.com/neovim/neovim/issues/5990
set guifont=

source $HOME/.config/nvim/scripts/BufOnly.vim
source $HOME/.config/nvim/scripts/LessSpaceOnSave.vim
source $HOME/.config/nvim/scripts/CScope.vim

menu Encoding.koi8-r :e ++enc=koi8-r ++ff=unix<CR>
menu Encoding.windows-1251 :e ++enc=cp1251 ++ff=dos<CR>
menu Encoding.cp866 :e ++enc=cp866 ++ff=dos<CR>
menu Encoding.utf-8 :e ++enc=utf8<CR>
menu Encoding.koi8-u :e ++enc=koi8-u ++ff=unix<CR>

"
" Colors
" =============================
colorscheme xedit
highlight Special ctermfg=173
highlight String ctermfg=34
highlight Search ctermbg=129 ctermfg=15
highlight CursorLine cterm=NONE ctermbg=195
highlight CursorColumn ctermbg=195

"
" Autocommands
" =============================
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd BufNewFile,BufRead *.plpgsql   set filetype=sql
autocmd BufNewFile,BufRead *.plexor    set filetype=sql
autocmd BufNewFile,BufRead *.plpythonu set filetype=python
autocmd VimLeavePre * NERDTreeClose
autocmd VimLeave * mksession! ~/.last_session.vim
" Jump to the last position when reopening a file
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
autocmd FileType make setlocal noexpandtab
autocmd VimEnter * command! -nargs=* -bang Ag call s:ag_with_opts(<q-args>, <bang>0)

"
" plugins configurations
" =============================
" ### pgsql
let g:sql_type_default = 'pgsql'
" ### nerdtree
let NERDTreeMarkBookmarks = 1
let NERDTreeShowBookmarks = 1
let NERDTreeBookmarksSort = 0
let NERDTreeIgnore = ['\.pyc$', '\.o$', '\.swp$', 'data$[[dir]]', 'tests$[[dir]]']
let NERDTreeShowHidden = 0
let NERDTreeBookmarksSort = 1
let NERDTreeShowLineNumbers=1
let NERDTreeMinimalUI = 0
let NERDTreeDirArrows = 0
let NERDTreeMapActivateNode='<space>'
let g:NERDTreeWinSize = 50
let g:NERDTreeFlagsAtTheEnd = 1
let g:NERDTreeUpdateOnWrite = 0
let g:airline_theme='dark_minimal'
let g:airline_powerline_fonts = 0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#exclude_preview = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#buffer_idx_mode = 0
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_nr_format = '%s: '
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline_section_c = '%F'
" ### vim-signify
let g:signify_vcs_list = [ 'git', 'hg' ]
let g:signify_realtime = 1
" ### Mark-karkat
nmap <Plug>IgnoreMarkSearchNext <Plug>MarkSearchNext
nmap <Plug>IgnoreMarkSearchPrev <Plug>MarkSearchPrev
" ### fzf
let g:fzf_layout = { 'down': '~50%' }
let g:fzf_files_options = '--preview "head -200 {}"'
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
" https://github.com/junegunn/fzf.vim/issues/92#issuecomment-191248596
function! s:ag_with_opts(arg, bang)
  let tokens  = split(a:arg)
  let ag_opts = join(filter(copy(tokens), 'v:val =~ "^-"'))
  let query   = join(filter(copy(tokens), 'v:val !~ "^-"'))
  call fzf#vim#ag(a:arg,
    \             ag_opts,
    \             a:bang ? fzf#vim#with_preview('up:60%')
    \                    : fzf#vim#with_preview('right:70%:hidden', '?'),
    \             a:bang)
endfunction
" ### gitgutter
let g:gitgutter_map_keys = 0
" ### dirdiff
let g:DirDiffExcludes = ".DS_Store,.hg,.hgignore,_dev,_tests,patches,tests"
let g:DirDiffWindowSize = 25
" ### ycm
" https://github.com/Valloric/YouCompleteMe#the-gycm_seed_identifiers_with_syntax-option
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_key_list_select_completion=['<C-j>', '<TAB>', '<Down>']
let g:ycm_key_list_previous_completion=['<C-k>', '<S-TAB>', '<Up>']
" ### csv
let g:csv_highlight_column = 'n'
let b:csv_arrange_align = 'l*'

"
" keys configurations
" =============================
map <F7> :emenu Encoding.
map <F8> :TagbarToggle<CR>
map <S-F8> :TagbarShowTag<CR>
nmap <leader>f :NERDTreeToggle<CR>
nmap <leader>t :call NerdTreeFindFunc()<CR>:NERDTreeFocusToggle<CR>
nnoremap `` :up<CR>
nnoremap <leader>q :Bclose<CR>
nnoremap <leader>d :Bclose!<CR>
nnoremap <C-t> :enew<CR>
inoremap hh <Esc>
inoremap jj <Esc>
inoremap kk <Esc>
nmap <C-j> 20<C-e>
nmap <C-k> 20<C-y>
nmap <C-h> 50zh
nmap <C-l> 50zl
nmap <A-j> 10<C-e>
nmap <A-k> 10<C-y>
nmap <A-h> 10zh
nmap <A-l> 10zl
nnoremap <Tab> i<Tab><Esc>l
nnoremap <Space> i<Space><Esc>l
inoremap <leader>fn <C-R>=expand("%:t:r")<CR>
nmap <C-_> :Buffers<CR>
imap <C-_> <Esc>:Buffers<CR>
map <C-p> :Files<CR>
nnoremap <CR> i<CR><Esc>
nnoremap <Leader>h :set hlsearch!<CR>:set hlsearch?<CR>
" search matching mapping
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
" Buffer switching keys
nnoremap - :bp<CR>
nnoremap = :bn<CR>
" map a motion and its reverse motion:
noremap <expr> h repmo#SelfKey('h', 'l')|sunmap h
noremap <expr> l repmo#SelfKey('l', 'h')|sunmap l
" if you like `:noremap j gj', you can keep that:
noremap <expr> j repmo#Key('gj', 'gk')|sunmap j
noremap <expr> k repmo#Key('gk', 'gj')|sunmap k
" repeat the last [count]motion or the last zap-key:
map <expr> ; repmo#LastKey(';')|sunmap ;
map <expr> , repmo#LastRevKey(',')|sunmap ,
" add these mappings when repeating with `;' or `,':
noremap <expr> f repmo#ZapKey('f')|sunmap f
noremap <expr> F repmo#ZapKey('F')|sunmap F
noremap <expr> t repmo#ZapKey('t')|sunmap t
noremap <expr> T repmo#ZapKey('T')|sunmap T
" Scroll commands
noremap <expr> <C-E> repmo#SelfKey('<C-E>', '<C-Y>')
noremap <expr> <C-Y> repmo#SelfKey('<C-Y>', '<C-E>')
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste
nnoremap <A-s> :call AgCW('Ag')<CR>
nnoremap <A-f> :call fzf#vim#files(getcwd() , {'options': '-q '.shellescape(expand('<cword>'))})<CR>
nnoremap <C-g> :YcmCompleter GoTo<CR>


