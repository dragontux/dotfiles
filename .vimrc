filetype plugin on
filetype indent on

" General appearance
set number
set background=dark
set noerrorbells
set title
set nocompatible
set lazyredraw
set cul

" Searching
set ignorecase
set wildmenu
set wildmode=full
set incsearch

" Indenting stuffs
set autoindent
set smarttab

" Scroll offsets
set scrolloff=8
set sidescrolloff=8

" Backup settings
set nobackup
set nowritebackup
set noswapfile
set autoread
" let maplocalleader = ","

" Fold settings
autocmd FileType c setlocal foldmethod=syntax
autocmd FileType css setlocal foldmethod=syntax
autocmd FileType python setlocal foldmethod=indent

set foldnestmax=10
set nofoldenable
set foldlevel=3

" Autocomplete settings
autocmd FileType text exe "set dictionary+=/usr/share/dict/words"
autocmd FileType text exe "set complete+=k"

" C tab settings
autocmd FileType c exe "set tabstop=4"
autocmd FileType c exe "set shiftwidth=4"
autocmd FileType cpp exe "set tabstop=4"
autocmd FileType cpp exe "set shiftwidth=4"

" Settings for assembly code...
autocmd FileType asm exe "set tabstop=4"
autocmd FileType asm exe "set shiftwidth=4"
autocmd FileType asm exe "set expandtab"

" Settings for scheme
autocmd FileType scheme exe "set tabstop=4"
autocmd FileType scheme exe "set shiftwidth=4"
autocmd FileType scheme exe "set expandtab"

" Filetype-specific plugins
source ~/.vim/genmacros.vim
source ~/.vim/gpg.vim
autocmd FileType c source ~/.vim/cmacros.vim
autocmd FileType cpp source ~/.vim/cmacros.vim
autocmd FileType java source ~/.vim/javamacros.vim
autocmd FileType scheme source ~/.vim/schememacros.vim

" General plugins
source ~/.vim/plugins/showmarks.vim
source ~/.vim/plugins/surround.vim

" Colorscheme
if has('syntax')
	syntax on
	if &term == 'rxvt-unicode' || &term == 'putty' || &term == 'xterm'
		set t_Co=256
	endif

	if &t_Co == 256
		"colorscheme xoria256
		colorscheme jellybeans
	else
		colorscheme delek
	endif
endif

" Keybindings
" Map ii to escape
inoremap ij <C-[>

" Better bindings for window management
noremap <LocalLeader>l <C-w>l
noremap <LocalLeader>h <C-w>h
noremap <LocalLeader>j <C-w>j
noremap <LocalLeader>k <C-w>k
noremap <LocalLeader>= <C-w>=
noremap <LocalLeader>< <C-w><
noremap <LocalLeader>> <C-w>>
noremap <LocalLeader>- <C-w>-
noremap <LocalLeader>+ <C-w>+

" Tab bindings
noremap <LocalLeader>1 1gt
noremap <LocalLeader>2 2gt
noremap <LocalLeader>3 3gt
noremap <LocalLeader>4 4gt
noremap <LocalLeader>5 5gt
noremap <LocalLeader>6 6gt
noremap <LocalLeader>7 7gt
noremap <LocalLeader>8 8gt
noremap <LocalLeader>9 9gt
