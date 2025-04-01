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
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
call plug#end()            " required

filetype plugin indent on    " required

" reload vimrc on change
augroup vimrc_autoreload
    autocmd!
    autocmd BufWritePost .vimrc :so ~/.vimrc
augroup END

" Set title on X window
set title
set hlsearch                        " Highlight matches.
set visualbell                      " No beeping.
let mapleader = ","                 " redifinition of map leader
set nobackup                        " Don't make a backup before overwriting a file.
set nowritebackup                   " And again.
set noswapfile                      " Use an SCM instead of swap files
set wrap                            " Turn on line wrapping.
set completeopt=menuone,menu,longest,preview " use a popup for completion
if version >= 730
  set noundofile                  " Don't keep a persistent undofile
endif

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
hi Normal ctermfg=white ctermbg=black
colorscheme solarized

" pull word under cursor into LHS of a substitute (for quick search and replace)
nmap <leader>zs :%s/<C-r>=expand("<cword>")<CR>/

" Search highlight
set incsearch                       " Highlight matches as you type.
set hlsearch                        " Highlight matches.
" Clear search highlight (set hlsearch)
map <silent> <leader>/ :let @/=""<CR>:echo "Cleared search register."<cr>

" create directory if not exists
au BufWrite * :call <SID>MkdirsIfNotExists(expand('<afile>:h'))
function! <SID>MkdirsIfNotExists(directory)
    if(!isdirectory(a:directory))
        call system('mkdir -p '.shellescape(a:directory))
    endif
endfunction
