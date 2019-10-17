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
call plug#end()
" }

" GENERAL {
let mapleader='\'
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


set number                     " Show current line number
set relativenumber             " Show relative line numbers
