call plug#begin('~/.nvim/plugged')

" Make sure you use single quotes
" Plug 'junegunn/seoul256.vim'
Plug 'junegunn/vim-easy-align'
Plug 'romainl/apprentice'
Plug 'nanotech/jellybeans.vim'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-endwise'
Plug 'Raimondi/delimitMate'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-cucumber'
Plug 'scrooloose/syntastic'
Plug 'itchyny/lightline.vim'
Plug 'floobits/floobits-neovim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-unimpaired'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'unblevable/quick-scope'
Plug 'Valloric/YouCompleteMe'
" Plug 'tomtom/tcomment_vim'
" Plug 'jistr/vim-nerdtree-tabs'
" Plug 'Shougo/unite.vim'
" Plug 'Shougo/vimfiler.vim'
" Plug 'bling/vim-airline'

" Group dependencies, vim-snippets depends on ultisnips
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using git URL
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }

" Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'

" Add plugins to &runtimepath
call plug#end()

" Plugin Settings
"
" vim-airline
"set laststatus=2 " Always on
"set noshowmode " Hide default mode text below status line
"let g:airline_powerline_fonts = 1 " Use powerline fonts
"let g:airline#extensions#tabline#enabled = 1 " Show buffers

" lightline.vim
set laststatus=2 " Always on
set noshowmode   " Hide mode from default input bar

let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'component': {
      \   'readonly': '%{&readonly?"":""}',
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

function! LightLineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightLineFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let _ = fugitive#head()
      return strlen(_) ? mark._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
      \ 'main': 'CtrlPStatusFunc_1',
      \ 'prog': 'CtrlPStatusFunc_2',
      \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
  let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

" GitGutter
set shell=/bin/bash " Use bash shell

" quick-scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_ruby_checkers = ['rubocop'] "Use rubocop for ruby linting

" ctrlp.vim
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

" Functions

" Keymappings
vmap     <Enter> <Plug>(EasyAlign)
nmap     ga      <Plug>(EasyAlign)
nmap     <F7>    :NERDTreeToggle<CR>
tnoremap <Esc>   <C-\><C-n>
tnoremap <A-w>   <C-\><C-n><C-w>w
tnoremap <A-r>   <C-\><C-n><C-w>t<C-w>H<C-w>b<C-w>K
tnoremap <A-h>   <C-\><C-n><C-w>h
tnoremap <A-j>   <C-\><C-n><C-w>j
tnoremap <A-k>   <C-\><C-n><C-w>k
tnoremap <A-l>   <C-\><C-n><C-w>l
nnoremap <A-w>   <C-w>w
nnoremap <A-r>   <C-w>t<C-w>H<C-w>b<C-w>K
nnoremap <A-h>   <C-w>h
nnoremap <A-j>   <C-w>j
nnoremap <A-k>   <C-w>k
nnoremap <A-l>   <C-w>l
map      <C-w>gt :tabnew<CR>

" Syntax highlighting
autocmd BufRead,BufNewFile     *.qc set filetype=quakec
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Default indenting
set expandtab
set shiftwidth=2
set softtabstop=2

" Show line numbers
set number

" Add cursor line
set cursorline

" Keep edit line centered
set so=3

" Show invisibles
set list
set listchars=tab:▸\ 

" Open splits below and vsplits to the right
set splitbelow
set splitright

" Draw a line on the 81st column
set colorcolumn=81

" Treat numbers as decimals (affects <C-a> on numbers with leading zeros)
set nrformats=

" Don't close terminal buffers when switched
autocmd TermOpen * set bufhidden=hide

" Change curser in insert mode
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" Use true color
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Load color scheme, should be towards end of file
colorscheme jellybeans

" Custom highlights
hi colorcolumn guibg=#1C1C1C
