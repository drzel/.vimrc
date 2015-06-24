set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

"" The following are examples of different formats supported.
"" Keep Plugin commands between vundle#begin/end.
"" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
Plugin 'junegunn/goyo.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'
Plugin 'romainl/Apprentice.git'
Plugin 'xolox/vim-colorscheme-switcher'
Plugin 'xolox/vim-misc'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-sensible'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-endwise'
Plugin 'Raimondi/delimitMate'

"" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
"" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
"" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
"" The sparkup vim script is in a subdirectory of this repo called vim.
"" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Use syntax highlighting
set syntax=on

" Show line numbers
set number

" Status bar always displayed
set laststatus=2

" Show 256 colors
set t_Co=256

" Set colorscheme
colorscheme apprentice

" Add cursor line
set cursorline

" Set indent size
set shiftwidth=2
set tabstop=2
set expandtab

" Use markdown syntax highlighting for .md files
au BufRead,BufNewFile *.md set filetype=markdown

" Keymappings
nmap <F7> :NERDTreeToggle<CR>

" Show invisibles
set list
set listchars=tab:▸\  
", eol:↵

" Convert markdown to HTML
nmap <leader>md :%!/usr/local/bin/Markdown.pl --html4tags <cr>

" Open new vsplits on the right
:set splitright

" Turn off splash screen
set shortmess=I

" Add line at 80 colums
execute "set colorcolumn=" . join(range(81,335), ',')
hi colorcolumn ctermbg=black guibg=#1C1C1C

" GUI settings
if has("gui_running")
  set lines=32 columns=118
  set guioptions-=r  "remove right-hand scroll bar
  set guioptions-=L  "remove left-hand scroll bar in split windows
  set guioptions-=T  "remove toolbar
  hi NonText guibg=#1C1C1C
  if has("gui_gnome")
    set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 14
  elseif has("gui_win32")
    set guifont=Consolas:h13:cANSI
  endif
endif

" Add powerline
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
