" INIT {
    if empty(glob('~/.config/nvim/autoload/plug.vim'))
      silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
" }

" PLUGINS {
    call plug#begin()
    Plug 'junegunn/fzf.vim'                                             " fzf
    Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}  " php
    Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }                 " go
    Plug 'vim-airline/vim-airline'                                      " status bar
    call plug#end()
" }

" GENERAL {
    syn
    let mapleader='\'

    set autoindent
    set smartindent
    set expandtab
    set smarttab
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set textwidth=130

    set number                     " Show current line number
    set relativenumber             " Show relative line numbers
" }

" FZF {
    nnoremap <leader>\ :<c-u>FZF<CR>
    nnoremap <leader>b :<c-u>Buffers<CR>
    nnoremap <leader>n :<c-u>History<CR>

    " Open FZF for directory of current file.
    nnoremap <leader>f :<c-u>FZF %:h<CR>

    " [Buffers] Jump to the existing window if possible
    let g:fzf_buffers_jump = 1
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
    nmap <Leader>o :call phpactor#GotoDefinition()<CR>

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


