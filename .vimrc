execute pathogen#infect()
syntax on
filetype on
filetype indent on
filetype plugin on
set omnifunc=syntaxcomplete#Complete
set t_Co=256
set t_ut=
"set term=rxvt-unicode
set encoding=utf-8
set wildmenu
set background=dark
set number
set scrolloff=8
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent
set hlsearch
set nocompatible
set ruler
set autochdir
set showbreak=↪
set smarttab
set backspace=indent,eol,start
set laststatus=2
set spell spelllang=en_us
set colorcolumn=89
set cursorline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_c = '%{getcwd()} %t'
let g:airline_enable_branch=1
let g:airline_enable_syntastic=1
let g:airline_theme='solarized'
set noshowmode
set ttimeoutlen=20

let g:neocomplete#enable_at_startup = 1
let g:syntastic_python_checkers=['flake8', 'pyflakes', 'pylint']
let g:syntastic_python_flake8_args='--ignore=E501'
"let g:syntastic_python_flake8_args="--select=W402,W403,W404,W405,W801,W802,W803,W804,W805,W806"
let g:gitgitter_sign_column_always=1
let g:solarized_termtrans=1
let g:solarized_termcolors=256
map <C-n> :NERDTreeToggle<CR>
colorscheme solarized
"highlight ColorColumn ctermbg=darkgrey guibg=darkgrey
"highlight SignColumn ctermbg=darkgrey guibg=darkgrey

" remember position
autocmd BufWinLeave * mkview
autocmd BufWinEnter * silent loadview

"Trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhiteSpace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

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

set tags+=~/src/beautifulmind/tags
