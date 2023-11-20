syntax on "Enable syntax highlighting
set nu "Enable line numbers
set relativenumber "Enable relative line numbers
set encoding=UTF-8
set smarttab
set smartindent "Indents for specific language
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab "Replaces tab characters with spaces
set re=0
set nowrap "No text wrapping
set noswapfile "Stop swapfiles from being created
set incsearch "Highlight text as searching with /
set scrolloff=8 "N lines at end 
set guicursor= "Same size cursor when going to INSERT mode

" Set the font to Hack Nerd Font
set guifont=Hack\ Nerd\ Font\ Mono:h12

"Vim-Plug Plugin Manager Install + Section:
"sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

call plug#begin()
  Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'ryanoasis/vim-devicons'
  Plug 'scrooloose/nerdcommenter'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'airblade/vim-gitgutter'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'preservim/nerdtree'
  Plug 'dense-analysis/ale'
  Plug 'vim-airline/vim-airline'
  Plug 'vwxyutarooo/nerdtree-devicons-syntax'
call plug#end()

" Colorscheme
colorscheme industry

" Start NERDTree. If a file is specified, move the cursor to its window.
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

let mapleader = " "
nnoremap <C-p> :Files<Cr>
nnoremap <Leader>f :Rg<Cr>
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

