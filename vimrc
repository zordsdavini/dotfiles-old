" Pathogen plugin to handle bundles.
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

set nocompatible    " no compatible
if has("syntax")
  syntax on
endif

set novisualbell
"Backup files
set backup
set backupdir=~/.vim/backup
set directory=/tmp

" tell it to use an undo file
set undofile
" set a directory to store the undo history
set undodir=~/.vim/undo/

"TAB simbolių kiekis
set autoindent
set smartindent
set expandtab
set smarttab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set textwidth=0

"Encoding
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,latin1

"GUI {
    "Always display status line
    set laststatus=2
"}

"Search
set hlsearch
set incsearch
set ignorecase
set cursorline

""""""""""""""""""""""""""""""
" Visual
""""""""""""""""""""""""""""""
" From an idea by Michael Naumann
function! VisualSearch(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"
  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")
  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  else
    execute "normal /" . l:pattern . "^M"
  endif
  let @/ = l:pattern
  let @" = l:saved_reg
endfunction
"Basically you press * or # to search for the current selection !! Really useful
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

"Etc
set tags=./tags,./../tags,./../../tags,tags,$VIM/tags,$VIM/phptags,~/tags

" Do not wrap lines automatically
set nowrap
" Show cursor position
set ruler

"Set to auto read when a file is changed from the outside
set autoread

"Set mapleader
let mapleader = ","
let g:mapleader = ","

"Fast saving
nmap <leader>w :w!<cr>
nmap <leader>f :find<cr>

"Copy file path into clipboard
nmap <leader>p :let @+ = expand("%:p")<cr> :let @" = expand("%:p")<cr>
"Copy relative path into clipboard
nmap <leader>r :let @+ = expand("%")<cr> :let @" = expand("%")<cr>
"Copy file name into clipboard
nmap <leader>f :let @+ = expand("%:t")<cr> :let @" = expand("%:t")<cr>

"Fast reloading of the .vimrc
map <leader>s :source ~/.vimrc<cr>
"Fast editing of .vimrc
map <leader>e :e! ~/.vimrc<cr>
"When .vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/vim_local/vimrc

set mouse=a
set nocp
set vb t_vb=
set exrc
set number
set numberwidth=8

function! ToggleGUICruft()
  if &guioptions=='i'
    exec('set guioptions=imTrL')
  else
    exec('set guioptions=i')
  endif
endfunction

"Colors
set background=dark
if has("gui_running")
    colors vividchalk 
    set guifont=Monospace\ 9
    " by default, hide gui menus
    set guioptions=i
    map <F11> <Esc>:call ToggleGUICruft()<cr>
else
    set t_Co=256
    colors vividchalk
endif

" Startify
autocmd User Startified setlocal cursorline

let g:startify_enable_special         = 1
let g:startify_files_number           = 8
let g:startify_relative_path          = 1
let g:startify_change_to_dir          = 1
let g:startify_session_autoload       = 1
let g:startify_session_persistence    = 1
let g:startify_session_delete_buffers = 1

let g:startify_list_order = [
  \ ['   Sessions:'],
  \ 'sessions',
  \ ['   Bookmarks:'],
  \ 'bookmarks',
  \ ['   LRU:'],
  \ 'files',
  \ ['   LRU within this dir:'],
  \ 'dir',
  \ ]

let g:startify_skiplist = [
            \ 'COMMIT_EDITMSG',
            \ $VIMRUNTIME .'/doc',
            \ 'bundle/.*/doc',
            \ ]

let g:startify_bookmarks = [
            \ '~/.vimrc',
            \ '~/.config/qtile/config.py',
            \ ]

let g:startify_custom_header =
      \ map(split(system('fortune | cowsay'), '\n'), '"   ". v:val') + ['']

"hi StartifyBracket ctermfg=240
"hi StartifyFile    ctermfg=147
"hi StartifyFooter  ctermfg=240
"hi StartifyHeader  ctermfg=114
"hi StartifyNumber  ctermfg=215
"hi StartifyPath    ctermfg=245
"hi StartifySlash   ctermfg=240
"hi StartifySpecial ctermfg=240

" Status line

function! CurDir()
   let curdir = substitute(getcwd(), "/home/zordsdavini", "~/", "g")
   return curdir
endfunction

function! CurSession()                                                                       
  let curSession = fnamemodify(v:this_session, ":t:r")                                        
  return curSession                                                                           
endfunction

set statusline=%<CWD:\ %r%{CurDir()}%h\ \ \ \%f\ \ \ %h%m%r%{fugitive#statusline()}\ \ \ %r%{CurSession()}%h%=%-14.(%l,%c%V%)\ %P

"Tab configuration
map <leader>tn :tabnew %<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
try
  set switchbuf=usetab
  set stal=2
catch
endtry

"Moving fast to front, back and 2 sides ;)
imap <m-$> <esc>$a
imap <m-0> <esc>0i
imap <D-$> <esc>$a
imap <D-0> <esc>0i

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key mapping
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <F6> :make test FILE=%:p<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PHP
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" The completion dictionary is provided by Rasmus:
" http://lerdorf.com/funclist.txt
" set dictionary-=~/.vim/dictionaries/phpfunclist dictionary+=~/.vim/dictionaries/phpfunclist
" Use the dictionary completion. Use CTRL+N or CTRL+P while in INSERT mode to call completion.
" set complete-=k complete+=k

" highlights interpolated variables in sql strings and does sql-syntax highlighting. yay
autocmd FileType php let php_sql_query=1
" does exactly that. highlights html inside of php strings
autocmd FileType php let php_htmlInStrings=1
" discourages use oh short tags. c'mon its deprecated remember
autocmd FileType php let php_noShortTags=0
" automagically folds functions & methods. this is getting IDE-like isn't it?
autocmd FileType php let php_folding=0

" set auto-highlighting of matching brackets for php only
autocmd FileType php DoMatchParen
autocmd FileType php hi MatchParen ctermbg=blue guibg=lightblue

" Twig uses same templates style as Django
autocmd BufRead,BufNewFile *.twig set filetype=htmldjango.html


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MARKDOWN
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufRead,BufNewFile *.md set filetype=markdown

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DJANGO + PYTHON
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType python set ft=python.django " For SnipMate
autocmd FileType html set ft=htmldjango.html " For SnipMate
autocmd FileType htm set ft=htmldjango.html " For SnipMate


" autocomplete funcs and identifiers for languages
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

set rtp+=$GOROOT/misc/vim

set spell
set spelllang=lt,en

filetype on
filetype plugin indent on
" Repair wired terminal/vim settings
set backspace=indent,start,eol

"Bbackspace and cursor keys wrap to
set whichwrap+=<,>,h,l

"Set magic on
set magic

"show matching bracets
set showmatch

"How many tenths of a second to blink
set mat=2

" Syntax {
autocmd! BufNewFile,BufRead *.pde setlocal ft=arduino "Arduino syntax highlighting.
autocmd BufRead,BufNewFile *.log set syntax=log4j
" }


" Panaikintė tarpus galė
autocmd FileType c,cpp,php,python,ruby,java autocmd BufWritePre <buffer> :%s/\s\+$//e

"
" Autocomplete
"
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap { <c-r>=OpenBracket()<CR>
inoremap } <c-r>=CloseBracket()<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

if !exists("*ClosePair")
    function ClosePair(char)
      if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
      else
        return a:char
      endif
    endf
endif

if !exists("*OpenBracket")
    function OpenBracket()
      if len(getline('.')) == col('.') - 1
        return "{}\<ESC>i"
      else
        return "{}\<ESC>i"
      endif
    endf
endif
if !exists("*CloseBracket")
    function CloseBracket()
      if len(getline('.')) == col('.') - 1
        return "}\<ESC>k$"
      else
        return "}"
      endif
    endf
endif

if !exists("*QuoteDelim")
    function QuoteDelim(char)
      let line = getline('.')
      let col = col('.')
      if line[col - 2] == "\\"
        "Inserting a quoted quotation mark into the string
        return a:char
      elseif line[col - 1] == a:char
        "Escaping out of the string
        return "\<Right>"
      else
        "Starting a string
        return a:char.a:char."\<ESC>i"
      endif
    endf
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fileformats
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Favorite filetypes
set ffs=unix,dos,mac

nmap <leader>fd :se ff=dos<cr>
nmap <leader>fu :se ff=unix<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PHP Documentor
source ~/.vim/ftplugin/php-doc.vim 
inoremap <C-C> <ESC>:call PhpDocSingle()<CR>i 
nnoremap <C-C> :call PhpDocSingle()<CR> 
vnoremap <C-C> :call PhpDocRange()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ZenCoding
let g:user_zen_expandabbr_key = '<c-e>'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FuzzyFinder
let g:fuf_file_exclude = '\v\~$|\.(o|exe|dll|bak|orig|swp)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
let g:fuf_modesDisable = []
let g:fuf_mrufile_maxItem = 100
let g:fuf_mrucmd_maxItem = 100

noremap ~ :FufRenewCache<CR>:FufFileWithCurrentBufferDir<CR>
noremap <C-A-m> :FufMruFile<CR>
noremap <C-A-o> :FufFile<CR>
noremap <C-A-Space> :FufBuffer<CR>
noremap <C-A-n> :FufBuffer<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NerdTree
map <C-E> <plug>NERDTreeTabsToggle<CR>
"map <C-e> :NERDTreeToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabular
" AddTabularPattern! phpComment /\$\w*

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gundo
let g:gundo_preview_bottom = 1
let g:gundo_right = 0
let g:gundo_width = 45
let g:gundo_preview_height = 15
map <leader>m :GundoToggle<cr>

nmap <F8> :TagbarToggle<CR>

filetype plugin on
set ofu=syntaxcomplete#Complete

" Enable wildmenu on command mode autocomplete.
set wildmenu
set wildmode=full"

" Conque
let g:ConqueTerm_Color = 1

" Scratch
set hidden
let g:scratch_autohide = &hidden
nmap <F2> :ScratchPreview<CR>
