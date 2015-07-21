" init the package manager
execute pathogen#infect()

" Some standard settings...
set nocompatible
syntax enable
filetype on
filetype indent on
filetype plugin on
set encoding=utf-8
set wildmenu " bottom menubar
set background=dark
set number " line numbers
set scrolloff=8 " Top/Bottom scroll threshold
set expandtab " Use spaces instead of tabs
set tabstop=4 " Default tab width
set shiftwidth=4
set smarttab
set softtabstop=4
set autoindent
set smartindent
set hlsearch
set ruler
set autochdir
set showbreak=↪
set backspace=indent,eol,start
set spell spelllang=en_us
set colorcolumn=89 "To help limit max line length
set cursorline " Highlight row with cursor

set noshowmode
set ttimeoutlen=20

" Plugin settings
set laststatus=2 " For airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_c = '%{getcwd()} %t'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline_theme='solarized'

set omnifunc=syntaxcomplete#Complete
let g:neocomplete#enable_at_startup = 1

let g:syntastic_python_checkers=['flake8', 'pyflakes', 'pylint']
let g:syntastic_python_flake8_args='--ignore=E501'

let g:gitgitter_sign_column_always=1

let g:solarized_termtrans=1
let g:solarized_termcolors=256

" Terminal color settings
set t_Co=256
set t_ut=
colorscheme solarized

map <C-n> :NERDTreeToggle<CR>

" remember position
autocmd BufWinLeave ?* mkview
autocmd BufWinEnter ?* silent loadview

"Trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhiteSpace /\s\+$/
autocmd BufWinEnter ?* match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave ?* call clearmatches()

function! TrimWhiteSpace()
        %s/\s\+$//e
endfunction
autocmd BufWritePre *.py :call TrimWhiteSpace()

" whitespace
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=4 sts=4 sw=4
autocmd Filetype python setlocal ts=4 sts=4 sw=4

" persistent undo
set undodir=~/.vim/undodir
set undofile

" ctrlp
set runtimepath^=~/.vim/bundle/ctrlp.vim

" ctags
set tags+=~/src/beautifulmind/tags

"autocmd setf htmldjango
