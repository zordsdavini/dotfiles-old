" INIT {
    if empty(glob('~/.config/nvim/autoload/plug.vim'))
      silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
" }

" PLUGINS {
    call plug#begin()

    Plug 'junegunn/fzf.vim'
    Plug 'scrooloose/nerdtree'
    Plug 'easymotion/vim-easymotion'
    Plug 'majutsushi/tagbar'
    Plug 'mhinz/vim-startify'

    Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}
    Plug 'StanAngeloff/php.vim'
    Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'djoshea/vim-autoread'

    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'ludovicchabant/vim-gutentags'

    Plug 'itchyny/lightline.vim'
    Plug 'ap/vim-css-color'
    Plug 'morhetz/gruvbox'

    call plug#end()
" }

" TODO
" autocmd FileType c          nnoremap <buffer> <C-]> :YcmCompleter GoTo<CR>
" autocmd FileType javascript nnoremap <buffer> <C-]> :TernDef<CR>

" GENERAL {
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

    set number                     " Show current line number
    set relativenumber             " Show relative line numbers
    set mouse=a

    syntax on

    colorscheme gruvbox

    " Clipboard functionality (paste from system)
    vnoremap  <leader>y "+y
    nnoremap  <leader>y "+y
    nnoremap <leader>p "+p
    vnoremap <leader>p "+p

    nnoremap  <leader>s :source $MYVIMRC<CR>
    nnoremap  <leader>e :e $MYVIMRC<CR>
" }

" FZF {
    let g:phpactorBranch = "develop"

    nnoremap <leader>] :<c-u>FZF<CR>
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
" }

" PHPACTOR {
    let g:phpactorPhpBin = 'php'
    let g:phpactorBranch = 'develop'
    let g:phpactorOmniAutoClassImport = v:true

    " Include use statement
    nmap <Leader>u :call phpactor#UseAdd()<CR>

    " Invoke the context menu
    nmap <Leader>mm :call phpactor#ContextMenu()<CR>

    " Invoke the navigation menu
    nmap <Leader>nn :call phpactor#Navigate()<CR>

    " Goto definition of class or class member under the cursor
    nmap <a-]> :call phpactor#GotoDefinition()<CR>
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

" LIGHTLINE {
    let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }
" }

" STARTIFY {
    
" }
