call plug#begin('~/.local/share/nvim/plugged')
Plug '$HOME/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'brentyi/nerdtree-hg-plugin'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'roxma/vim-tmux-clipboard'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-signify'
Plug 'will133/vim-dirdiff'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'lifepillar/pgsql.vim'
Plug 'majutsushi/tagbar'
Plug 'vadimr/bclose.vim'
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-mark'
Plug 'godlygeek/tabular'
Plug 'chrisbra/csv.vim'
Plug 'dim13/xedit.vim'
Plug 'nightsense/simplifysimplify'

Plug 'alvan/vim-closetag'
Plug 'Valloric/MatchTagAlways'
Plug 'mattn/emmet-vim'

Plug 'SirVer/ultisnips'
Plug 'Yggdroot/indentLine'

Plug 'davidhalter/jedi-vim'

Plug 'blueyed/vim-diminactive'
call plug#end()

"
" functions
" =============================
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

function! AgBCW(cmd)
  let cw = expand('<cword>')
  execute a:cmd fnameescape(expand('%')) . ' ' . cw
endfunction

function! AgCW(cmd)
  let cw = expand('<cword>')
  execute a:cmd cw
endfunction

"
" Basic vim config
" =============================
set t_Co=256                                " for airline
set number                                  " line numbers
" set relativenumber                        " relative line number
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
set linebreak
set breakindent
set showbreak=>>
set list
set listchars=tab:-ͳ
set fileencodings+=cp1251,koi8-r,cp866
set laststatus=2
set tags=./tags;,tags;
set complete+=k                             "complete config
set completeopt+=longest
set completeopt+=menu
set cscopequickfix=s-,c-,d-,i-,t-,e-,a-     "cscope config
set cscopetag
set cscopepathcomp=2
set termguicolors
set nofixendofline

let g:indentLine_enabled = 0

source $HOME/.config/nvim/scripts/BufOnly.vim
source $HOME/.config/nvim/scripts/LessSpaceOnSave.vim
source $HOME/.config/nvim/scripts/CScope.vim
source $HOME/.config/nvim/scripts/Json.vim
source $HOME/.config/nvim/scripts/Tmux.vim

menu Encoding.koi8-r :e ++enc=koi8-r ++ff=unix<CR>
menu Encoding.windows-1251 :e ++enc=cp1251 ++ff=dos<CR>
menu Encoding.cp866 :e ++enc=cp866 ++ff=dos<CR>
menu Encoding.utf-8 :e ++enc=utf8<CR>
menu Encoding.koi8-u :e ++enc=koi8-u ++ff=unix<CR>

"
" Colors
" =============================
colorscheme simplifysimplify-light
highlight MatchParen guibg=#E0E0E0
highlight CursorColumn guibg=#F6F6F7
highlight CursorLine guibg=#F6F6F7
highlight Visual guibg=#F0E68C
highlight NonText guifg=#B7FDD3
highlight Search guibg=#B7FDD3
highlight CursorColumn guibg=#FFE4C4
highlight CursorLine guibg=#FFE4C4


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
let NERDTreeBookmarksSort = 1
let NERDTreeIgnore = ['\.pyc$', '\.o$', '\.swp$', 'data$[[dir]]', 'tests$[[dir]]']
let NERDTreeShowHidden = 0
let NERDTreeShowLineNumbers=1
let NERDTreeMinimalUI = 0
let NERDTreeDirArrows = 0
let NERDTreeMapActivateNode='<space>'
let g:NERDTreeWinSize = 60
let g:NERDTreeFlagsAtTheEnd = 1
let g:NERDTreeUpdateOnWrite = 0


let g:airline_theme='powerlineish' " good ones - powerlineish tomorrow base16 papercolor
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
" let g:airline_section_c = '%F'
" ### vim-signify
let g:signify_vcs_list = [ 'git', 'hg' ]
let g:signify_realtime = 1
let g:signify_cursorhold_normal = 0
let g:signify_cursorhold_insert = 0
" ### fzf
let g:fzf_layout = { 'down': '~50%' }
let g:fzf_files_options = '--preview "head -200 {}"'
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
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
  let ag_opts = join(add(filter(copy(tokens), 'v:val =~ "^-"'), '--color-path="1;35"'))
  let query   = join(filter(copy(tokens), 'v:val !~ "^-"'))
  call fzf#vim#ag(query,
    \             ag_opts,
    \             a:bang ? fzf#vim#with_preview('up:60%')
    \                    : fzf#vim#with_preview('right:60%:hidden', '?'),
    \             a:bang)
endfunction
" ### gitgutter
let g:gitgutter_map_keys = 0
" ### dirdiff
let g:DirDiffExcludes = ".DS_Store,.hg,.hgignore,_dev,_tests,patches,tests"
let g:DirDiffWindowSize = 25
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
nmap <leader>t :NERDTreeFind<CR>
map <F2> :up<CR>
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
nnoremap <M-Left> <C-O>
nnoremap <M-Right> <C-I>
inoremap <leader>fn <C-R>=expand("%:t:r")<CR>
map <C-A-H> :History<CR>
map <C-h> :Buffers<CR>
map <C-h> <Esc>:Buffers<CR>
map <C-p> :Files<CR>
nnoremap <CR> i<CR><Esc>
nnoremap <Leader>h :set hlsearch!<CR>:set hlsearch?<CR>
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste
nnoremap <A-s> :call AgCW('Ag')<CR>
nnoremap <A-f> :call fzf#vim#files(getcwd() , {'options': '-q '.shellescape(expand('<cword>'))})<CR>
nnoremap <A-b> :BLines <CR>

vmap <F9> y:silent call SendSelectionToPSQLTmuxPane()<CR>gv
nmap <F9> m`vipy:silent call SendSelectionToPSQLTmuxPane()<CR>``
vnoremap // y/<C-R>"<CR>
" навигация по quickfix списку
map <A-Down> :cn<CR>
map <A-Up> :cp<CR>
" не добавлять пробел при склейке строк
nnoremap J gJ

let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'vue' : 1
    \}
nnoremap <leader>% :MtaJumpToOtherTag<cr>

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.vue'
noremap <C-Y>k vat<Esc>da>`<da>

" Скрывать status bar
let s:hidden_all = 0
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction

command! -bang -nargs=* History
  \ call fzf#vim#history({'options': '--no-sort'})

let g:diminactive_use_colorcolumn = 0
let g:diminactive_use_syntax = 1

