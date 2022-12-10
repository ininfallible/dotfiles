" :inoremap " ""<left>
" :inoremap ' ''<left>
" :inoremap ( ()<left>
" :inoremap [ []<left>
" :inoremap { {}<left>
" :inoremap {<CR> {<CR>}<ESC>O
" :inoremap {;<CR> {<CR>};<ESC>O
"
:set number
:set tabstop=4
:set shiftwidth=4
:set noshowmode
:set colorcolumn=81
:set cursorline
:set undodir=~/.config/nvim/undo-dir
:set undofile
" conceal stuff for markdown
:set conceallevel=2
hi ColorColumn ctermbg=DarkGray
hi CursorLine term=bold cterm=none ctermbg=DarkGray

" Python support
let g:python3_host_prog='/bin/python3'
let g:python_host_prog='/bin/python'

" extensions I use
call plug#begin()
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'rbgrouleff/bclose.vim'
Plug 'junegunn/goyo.vim'
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
"Plug 'calviken/vim-gdscript3'
"Plug 'scrooloose/nerdtree'
"Plug 'ycm-core/YouCompleteMe'
"Plug 'ycm-core/YouCompleteMe', {'do': './install.py'}
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" open CHADTree with a shortcut
map <C-n> :CHADopen<CR>
