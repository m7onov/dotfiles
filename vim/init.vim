call plug#begin('~/.local/share/nvim/plugged')

Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lifepillar/pgsql.vim'
Plug 'f4t-t0ny/nerdtree-hg-plugin'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-signify'
Plug 'vadimr/bclose.vim'
Plug 'vim-scripts/Mark--Karkat'
" Fuzzy Finder
Plug '$HOME/.fzf'
Plug 'junegunn/fzf.vim'
" DirDiff
Plug 'will133/vim-dirdiff'
" Repeat motions for which a count was given
Plug 'Houl/repmo-vim'
" Tmux clipboard integration
Plug 'roxma/vim-tmux-clipboard'
" yank stack
Plug 'maxbrunsfeld/vim-yankstack'
" YouCompleteMe
Plug 'Valloric/YouCompleteMe'


call plug#end()

set t_Co=256                  " for airline
set number relativenumber     " line numbers
set cursorcolumn              " show cursor column
set cursorline                " show cursor line
set hlsearch                  " highlight search results
set hidden                    "
set incsearch                 " подсвечивать по мере поиска
set expandtab                 " заменять табы на пробелы, когда нажимается клавиша
set tabstop=2                 " сколько пробелов заменяют пробел
set shiftwidth=2              " размер identation
set mouse=a
set wrap
set breakindent
set showbreak=>>

set list
set listchars=tab:-ͳ

colorscheme xedit
set background=light

" Чтобы вертикальный ruler по цвету совпадал с ruler-ом от iterm
hi CursorLine cterm=NONE ctermbg=195
hi CursorColumn ctermbg=195

let g:sql_type_default = 'pgsql'

" Показать окно символов; найти текущий символ
map <F8> :TagbarToggle<CR>
map <S-F8> :TagbarShowTag<CR>

" Показать/скрыть дерево файлов
nmap <leader>f :NERDTreeToggle<CR>
nmap <leader>t :call NerdTreeFindFunc()<CR>:NERDTreeFocusToggle<CR>

" Прыжки по словам. В отличие от "w" и "b" прыгает только по alphanumeric символа
" (https://vi.stackexchange.com/questions/12026/ammend-w-behavior-ignore-operators-and-brackets/12027)
" что-то особо не использую
" nnoremap <silent> <C-l> :call search('\<\w', 'W')<cr>
" nnoremap <silent> <C-h> :call search('\<\w', 'bW')<cr>

"FIXME: Сохранение файла (нужно что-то более удобное)
nnoremap `` :up<CR>

" Закрыть буффер
nnoremap <leader>q :Bclose<CR>
" Закрыть буффер без сохранения
nnoremap <leader>d :Bclose!<CR>

" Новый таб
nnoremap <C-t> :enew<CR>

" Комбинации для выхода из insert-mode при движении курсора
inoremap hh <Esc>
inoremap jj <Esc>
inoremap kk <Esc>

" Быстрая навигация
nmap <A-j> 10<C-e>
nmap <A-k> 10<C-y>
nmap <A-h> 10zh
nmap <A-l> 10zl

" Вставка пробелов в normal mode
nnoremap <Tab> i<Tab><Esc>l
" для вставки пробела в normal режиме. Часто бывает нужно
nnoremap <Space> i<Space><Esc>l

" Вставить имя файла
inoremap \fn <C-R>=expand("%:t:r")<CR>

nmap <C-_> :Buffers<CR>
imap <C-_> <Esc>:Buffers<CR>

" Маппинги для FZF
map <C-p> :Files<CR>

"FIXME: доработать таким образом, чтобы курсор устанавливался на ту же
"колонку в новой строке (или по выравниванию)
nnoremap <CR> i<CR><Esc>

function! NerdTreeFindFunc()
    NERDTreeFind
    NERDTreeFocusToggle
endfunction

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

let g:NERDTreeWinSize = 30

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

" The value of this option influences when the last window will have a status
" line. 2 - always
set laststatus=2

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd BufNewFile,BufRead *.plpgsql   set filetype=sql
autocmd BufNewFile,BufRead *.plexor    set filetype=sql
autocmd BufNewFile,BufRead *.plpythonu set filetype=python

" Установка title для окна
" https://vi.stackexchange.com/a/7520
let my_asciictrl = nr2char(127)
let my_unisubst = "␡"
for i in range(1, 31)
  let my_asciictrl .= nr2char(i)
  let my_unisubst  .= nr2char(0x2400 + i, 1)
endfor
augroup termTitle
  au!
  " autocmd BufEnter,BufRead,BufWrite * let &titlestring = tr(expand("%:t"), my_asciictrl, my_unisubst) .
  autocmd BufEnter,BufRead,BufWrite * set title
augroup END

" Save session on quitting Vim
autocmd VimLeavePre * NERDTreeClose
autocmd VimLeave * mksession! ~/.last_session.vim

"FIXME: сейчас отключено, потому что окно мерцает при переключении режима, что дико бесит
"" Change background on enter/leave insert mode
"autocmd InsertEnter * hi Normal ctermbg=15
"" Must be the same as main backgroung color
"autocmd InsertLeave * hi Normal ctermbg=255

" Jump to the last position when reopening a file
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" не изпользовать замену табов на пробелы в makefile
autocmd FileType make setlocal noexpandtab

let g:signify_vcs_list = [ 'git', 'hg' ]
let g:signify_realtime = 1

let g:nerdtree_tabs_open_on_console_startup=0

set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set guifont=CodeNewRoman\ Nerd\ Font\ 9

set tags=./tags;,tags;

let g:indentLine_enabled = 0

highlight Special ctermfg=173
highlight String ctermfg=34

" Fuzzy finder options
let g:fzf_layout = { 'down': '~50%' }
let g:fzf_files_options = '--preview "head -200 {}"'
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Customize fzf colors to match your color scheme
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

" Augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], preview window, [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
" command! -bang -nargs=* Ag
"   \ call fzf#vim#ag(<q-args>,
"   \                 <bang>0 ? fzf#vim#with_preview('up:60%')
"   \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
"   \                 <bang>0)

" https://github.com/junegunn/fzf.vim/issues/92#issuecomment-191248596
" это чтобы добавить параметры вызова к ag, чтобы он лишнего не выводил
function! s:ag_with_opts(arg, bang)
  let tokens  = split(a:arg)
  " call insert(tokens, '-c')
  let ag_opts = join(filter(copy(tokens), 'v:val =~ "^-"'))
  let query   = join(filter(copy(tokens), 'v:val !~ "^-"'))
  call fzf#vim#ag(a:arg,
    \             ag_opts,
    \             a:bang ? fzf#vim#with_preview('up:60%')
    \                    : fzf#vim#with_preview('right:70%:hidden', '?'),
    \             a:bang)
endfunction

autocmd VimEnter * command! -nargs=* -bang Ag call s:ag_with_opts(<q-args>, <bang>0)

" https://github.com/junegunn/fzf.vim/issues/27#issuecomment-185761539
" ag в указанно директории
" :AgIn blablabla /sdfsdf/sdfsd/path
" function! s:ag_in(...)
"   call fzf#vim#ag(a:1,
"     \             extend({'dir': join(a:000[1:], ' ')},
"     \                    fzf#vim#with_preview('right:50%:hidden', '?')))
" endfunction
" command! -nargs=+ -complete=dir AgIn call s:ag_in(<f-args>)

" Buffer switching keys
nnoremap - :bp<CR>
nnoremap = :bn<CR>

" DirDiff config
let g:DirDiffExcludes = ".DS_Store,.hg,.hgignore,_dev,_tests,patches,tests"
let g:DirDiffWindowSize = 25

so $HOME/.config/nvim/scripts/BufOnly.vim
so $HOME/.config/nvim/scripts/LessSpaceOnSave.vim
so $HOME/.config/nvim/scripts/CScope.vim

" Замена unicode-escape последовательностей на нормальные символы
" %s/\\u\(\x\{4\}\)/\=nr2char('0x'.submatch(1),1)/g

" filetype plugin on
set complete+=k
set completeopt+=longest
set completeopt+=menu

" -----------------------------------------------------------------------------------------------
" Repmo config
" -----------------------------------------------------------------------------------------------
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

" -----------------------------------------------------------------------------------------------
" EXPERIMENTS
" -----------------------------------------------------------------------------------------------
" cscope config
set cscopequickfix=s-,c-,d-,i-,t-,e-,a-
set cst
set cspc=2

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

"https://github.com/neovim/neovim/issues/5990
set guicursor=
set guifont=

" Show file full path in status line
set statusline+=%F

function! SyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction

set statusline+=%{SyntaxItem()}

let g:syntastic_quiet_messages = {
    \ "!level":  "errors",
    \ "type":    "style",
    \ "regex":   '\m\[C03\d\d\]',
    \ "file:p":  ['\m^/usr/include/', '\m\c\.h$'] }

" Поиск текущего слова через Ag
function! AgCW(cmd)
  let cw = expand('<cword>')
  execute a:cmd cw
endfunction

" search current word in fzf :Ag
nnoremap <A-s> :call AgCW('Ag')<CR>
" search current word in fzf :Files
nnoremap <A-f> :call fzf#vim#files(getcwd() , {'options': '-q '.shellescape(expand('<cword>'))})<CR>

" https://github.com/Valloric/YouCompleteMe#the-gycm_seed_identifiers_with_syntax-option
nnoremap <C-g> :YcmCompleter GoTo<CR>
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_key_list_select_completion=['<C-j>', '<TAB>', '<Down>']
let g:ycm_key_list_previous_completion=['<C-k>', '<S-TAB>', '<Up>']
let g:ycm_key_list_stop_completion=['<CR>']





