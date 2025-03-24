if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

set nocompatible              " be iMproved, required
filetype off                  " required
set shell=/bin/zsh            " Use zsh as shell

" Install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'altercation/vim-colors-solarized'
call plug#end()            " required

filetype plugin indent on    " required

" reload vimrc on change
augroup vimrc_autoreload
    autocmd!
    autocmd BufWritePost .vimrc :so ~/.vimrc
augroup END

" Set title on X window
set title

if g:os == "Linux"
    language en_US.UTF8                  " set user interface anguage to en
elseif g:os == "Darwin"
    language en_US.UTF-8                 " set user interface anguage to en
endif

set number                          " Show line numbers.
set ruler                           " Show cursor position.
set cursorline                      " Highlight current line.
let &t_Co=256
let g:solarized_termcolors=256
set background=dark
colorscheme solarized
