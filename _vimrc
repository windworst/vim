" <Setting>

set nocompatible
set nobackup
set noswapfile
set writebackup
set smartindent
set expandtab                                         "Tab=>Space
set tabstop=2                                         "tab width
set shiftwidth=2                                      "tab = 2 space
set smarttab                                          "backspace will delete shiftwidth space
set autochdir
set autoindent

" set list
set backspace=2                                       "BackSpace enable
set spelllang=en_GB.UTF-8                             "Spell Check
set nu                                                "Line Number"

" File Encoding
set encoding=utf-8
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
set fileformat=unix
set fileformats=unix,dos,mac

" Interface Configure
set laststatus=2                                      " Enable Status Message
set cmdheight=2
set cursorline

" set nowrap
set shortmess=atI                                     "remove welcome-page
set incsearch                                         "vim Realtime-match during search
set hlsearch                                          " HighLight Search result

syntax enable
syntax on

source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

language messages zh_CN.utf-8

" <Config>

if has("gui_win32")
  set guifont=Consolas:h10
elseif has("gui_gtk2")
  set guifont=DejaVu\ Sans\ Mono\ 11
end

let g:isGUI = has("gui_running")
if g:isGUI
  colorscheme zellner
else
  colorscheme elflord
end

let g:vim_cfg_dir = expand($HOME.'/.vim/')
if has('nvim')
  let g:vim_cfg_dir = expand($HOME.'/.config/nvim/')
end

" <Key Mapping>

map <silent> <C-c> "+y<CR>
map! <silent> <C-c> <ESC><C-c>
map <silent> <D-c> <C-c>
map! <silent> <D-c> <ESC><D-c>

map <silent> <C-v> :set paste<CR>"+p<CR>:set nopaste<CR>
map! <silent> <C-v> <ESC><C-v>
map <silent> <D-v> <C-v>
map! <silent> <D-v> <ESC><D-v>

map <silent> <C-x> "+x<CR>
map! <silent> <C-x> <ESC><C-x>
map <silent> <D-x> <C-x>
map! <silent> <D-x> <ESC><D-x>

map <silent> <C-z> u
map! <silent> <C-z> <ESC><C-z>
map <silent> <D-z> <C-z>
map! <silent> <D-z> <ESC><D-z>

map <silent> <C-s> :w!<CR>
map! <silent> <C-s> <ESC><C-s>
map <silent> <D-s> <C-s>
map! <silent> <D-s> <ESC><D-s>

map <silent> <C-a> ggVG
map! <silent> <C-a> <ESC><C-a>
map <silent> <D-a> <C-a>
map! <silent> <D-a> <ESC><D-a>

map <silent> <C-n> :split<CR>
map! <silent> <C-n> <ESC><C-n>

map <silent> <C-j> :vsplit<CR>
map! <silent> <C-j> <ESC><C-j>

map <silent> <F12> :e $MYVIMRC<CR>
map! <silent> <F12> <ESC><F12>
map <silent> <C-F12> :so $MYVIMRC<CR>
map! <silent> <C-F12> <ESC><C-F12>
map <silent> <leader>ec <F12><CR>
map <silent> <leader>lc <C-F12><CR>

map <silent> <leader>w :w!<CR>
map! <silent> <leader>w :w!<CR>

" <Show/Hide Menu Toolbar RollLink>

func! HideMenu()
  set guioptions-=m
  set guioptions-=T
endf
func! ShowMenu()
  set guioptions+=m
  set guioptions+=T
endf
func! ToggleMenu()
  if &guioptions =~# 'm'
    :call HideMenu()
  else
    :call ShowMenu()
  end
endf
:call HideMenu()
map <silent> <F11> :call ToggleMenu()<CR>

" <Extends>

func! ExtendsLoad(needUpdate)
  let extends_manager_file = expand(g:vim_cfg_dir.'autoload/plug.vim')
  if a:needUpdate && !filereadable(extends_manager_file)
    :execute "!curl -fLo ".extends_manager_file." --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  end
  if filereadable(extends_manager_file)
    call OnInit(a:needUpdate)
  end
endf

map <silent> <leader>lo :call ExtendsLoad(0)<CR>
map <silent> <leader>lu :call ExtendsLoad(1)<CR>

" Plugins And Configs Write Here
func! OnInit(needUpdate)
  call plug#begin(g:vim_cfg_dir.'plugged')

  Plug 'rakr/vim-one'
  Plug 'preservim/nerdcommenter'
  Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
  Plug 'Yggdroot/indentLine'
  Plug 'bronson/vim-trailing-whitespace'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'tpope/vim-fugitive'

  call plug#end()

  if a:needUpdate
    :PlugUpdate
  end

  if g:isGUI
    set background=light
  else
    set background=dark
  end
  colorscheme one

  map <silent> <F5> :NERDTreeToggle<CR>
  map! <silent> <F5> <ESC><F5><CR>
  map <silent> <leader>tr <F5><CR>
endf

" Load Extends Vim package on init
call ExtendsLoad(0)
