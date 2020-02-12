" ViM config by <zordsdavini@gmail.com>, 2020

""""""""""
"  INIT  "
""""""""""

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"""""""""""""
"  PLUGINS  "
"""""""""""""

call plug#begin()

Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'easymotion/vim-easymotion'
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-startify'
Plug 'godlygeek/tabular'

Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}
Plug 'StanAngeloff/php.vim'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

Plug 'dense-analysis/ale'
Plug 'maximbaz/lightline-ale'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make' }
Plug 'kristijanhusak/deoplete-phpactor'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
Plug 'djoshea/vim-autoread'
Plug 'andymass/vim-matchup'
Plug 'kkoomen/vim-doge'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'ludovicchabant/vim-gutentags'
Plug 'kshenoy/vim-signature'
Plug 'mbbill/undotree'

Plug 'itchyny/lightline.vim'
Plug 'ap/vim-css-color'
Plug 'morhetz/gruvbox'
Plug 'luochen1990/rainbow'

call plug#end()

" TODO
" autocmd FileType c          nnoremap <buffer> <C-]> :YcmCompleter GoTo<CR>
" autocmd FileType javascript nnoremap <buffer> <C-]> :TernDef<CR>

"""""""""""""
"  GENERAL  "
"""""""""""""

let mapleader='\'

set autoindent
set smartindent
set expandtab
set smarttab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set textwidth=130
set updatetime=100
set signcolumn=yes
set colorcolumn=80,130
set termguicolors              " Enable true-color support
set history=1000
set undolevels=1000
set noswapfile

autocmd Filetype json setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

set number                     " Show current line number
set relativenumber             " Show relative line numbers
set mouse=a

let &titlestring = "[ViM] " . fnamemodify(v:this_session, ':t') . " " . @%
set title

syntax on

set wildmenu                    " Show the nice autocomplete menu
set wildmode=longest,full       " Set full autocompletion

" Enable persistent undo
set undodir=~/.vimundo/
set undofile

colorscheme gruvbox


" Clipboard functionality (paste from system)
vnoremap  <leader>y "+y
nnoremap  <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>p "+p

nnoremap  <leader>s :source $MYVIMRC<CR>
nnoremap  <leader>e :e $MYVIMRC<CR>

" move in tabs
nnoremap <A-Left> :tabprev<CR>
nnoremap <A-Right> :tabnext<CR>

" Force saving files that require root permission
cnoremap w!! w !sudo tee > /dev/null %

" disable Ex mode
map Q <Nop>


" FZF {
    nnoremap <leader>[ :<c-u>FZF<CR>
    nnoremap <leader>] :<c-u>FZF src<CR>
    nnoremap <leader>} :<c-u>FZF assets<CR>
    nnoremap <leader>b :<c-u>Buffers<CR>
    nnoremap <leader>n :<c-u>History<CR>

    " Open FZF for directory of current file.
    nnoremap <leader>f :<c-u>FZF %:h<CR>

    " [Buffers] Jump to the existing window if possible
    let g:fzf_buffers_jump = 1

    autocmd FileType php setlocal omnifunc=phpactor#Complete
" }

" { NERDTREE
    map <C-e> :NERDTreeToggle<CR>
    map <leader>r :NERDTreeFind<cr>
" }

" { NERDTREE-GIT
    let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
" }

" PHPACTOR {
    let g:phpactorPhpBin = 'php'
    let g:phpactorBranch = 'develop'
    let g:phpactorOmniAutoClassImport = v:true
    let g:phpactorInputListStrategy = 'fzf'

    " Include use statement
    nmap <Leader>u :call phpactor#UseAdd()<CR>

    " Invoke the context menu
    nmap <Leader>mm :call phpactor#ContextMenu()<CR>

    " Invoke the navigation menu
    nmap <Leader>nn :call phpactor#Navigate()<CR>

    " Goto definition of class or class member under the cursor
    nmap <a-]> :call phpactor#GotoDefinition()<CR>
    nmap <Leader>oh :call phpactor#GotoDefinitionHsplit()<CR>
    nmap <Leader>ov :call phpactor#GotoDefinitionVsplit()<CR>
    nmap <Leader>ot :call phpactor#GotoDefinitionTab()<CR>
    " List find references
    nmap <a-[> :call phpactor#FindReferences()<CR>

    " Show brief information about the symbol under the cursor
    nmap <Leader>K :call phpactor#Hover()<CR>

    " Transform the classes in the current file
    nmap <Leader>tt :call phpactor#Transform()<CR>

    " Generate a new class (replacing the current file)
    nmap <Leader>cc :call phpactor#ClassNew()<CR>

    " Extract expression (normal mode)
    nmap <silent><Leader>ee :call phpactor#ExtractExpression(v:false)<CR>

    " Extract expression from selection
    vmap <silent><Leader>ee :<C-U>call phpactor#ExtractExpression(v:true)<CR>

    " Extract method from selection
    vmap <silent><Leader>em :<C-U>call phpactor#ExtractMethod()<CR>
" }

" { TAGBAR
    nmap <leader>t :TagbarToggle<CR>
" }

" { GITGUTER
    " You can jump between hunks with [c and ]c.
    " You can preview, stage, and undo hunks with <leader>hp, <leader>hs, and <leader>hu respectively.
" }

" { STARTIFY

    " " show NerdTree on startup
    " autocmd VimEnter *
    "         \   if !argc()
    "         \ |   Startify
    "         \ |   NERDTree
    "         \ |   wincmd w
    "         \ | endif

    let g:startify_lists = [
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ ]
    let g:startify_session_before_save = [
      \ 'echo "Cleaning up before saving.."',
      \ 'silent! NERDTreeTabsClose'
      \ ]
    let g:startify_session_persistence = 1
    let g:startify_change_to_vcs_root = 1
    let g:startify_fortune_use_unicode = 1
    let g:startify_custom_header = 'startify#pad(startify#fortune#cowsay())'
" }

" LIGHTLINE {
    set noshowmode    " MODE is shown in lightline
    let g:lightline = {
      \   'colorscheme': 'seoul256',
      \   'active': {
      \     'left': [ [ 'mode', 'paste' ],
      \               [ 'readonly', 'filename', 'modified' ] ],
      \     'right': [ [ 'lineinfo' ],
      \                [ 'percent' ],
      \                [ 'gitbranch' ],
      \                [ 'fileencoding', 'filetype', 'charvaluehex' ],
      \                [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ] ],
      \   },
      \   'component': {
      \     'charvaluehex': '0x%B'
      \   },
      \ }
    let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \  'gitbranch': 'fugitive#head'
      \ }
    let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \     'gitbranch': 'error',
      \ }
" }

" ALE {
    let g:ale_php_phpcs_executable = '/home/arnas/out/phutils/vendor/bin/phpcs'
    let g:ale_php_phpcs_options = '--standard=/home/arnas/out/phutils/build/phpcs.xml'

    let g:ale_php_cs_fixer_options = '--config=/home/arnas/.php_cs'

    let g:ale_php_phpstan_executable = './vendor/bin/phpstan'
    let g:ale_php_phpstan_level = '7'
    let g:ale_php_phpstan_configuration = './vendor/boozt/phutil/build/phpstan.neon'

    let g:ale_linters = {
    \   'php': ['php', 'phpcs', 'phpstan'],
    \   'python': ['flake8'],
    \   'go': ['gofmt'],
    \}
    let g:ale_fixers = {
    \   '*': ['remove_trailing_lines', 'trim_whitespace'],
    \   'javascript': ['eslint'],
    \   'php': ['phpcbf', 'php_cs_fixer'],
    \}

    nmap <silent> <C-k> <Plug>(ale_previous_wrap)
    nmap <silent> <C-j> <Plug>(ale_next_wrap)

    let g:ale_fix_on_save = 1
    let g:ale_lint_on_save = 1
    " let g:ale_lint_on_text_changed = 0
" }

" DEOPLETE {
    let g:deoplete#enable_at_startup = 1
" }

" DOGE {
    let g:doge_enable_mappings = 1
" }

" RAINBOW {
    let g:rainbow_active = 1
" }

" ULTISNIPS {
    " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<c-b>"
    let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" }

"""""""""""""
"  Tabular  "
"""""""""""""

vmap <silent><Leader><Leader>d :Tabularize /\$\w*<CR>

"""""""""""""
"  Abolish  "
"""""""""""""

" Want to turn fooBar into foo_bar? Press crs (coerce to snake_case). MixedCase (crm), camelCase (crc), snake_case (crs),
" UPPER_CASE (cru), dash-case (cr-), dot.case (cr.), space case (cr<space>), and Title Case (crt) are all just 3 keystrokes away.
