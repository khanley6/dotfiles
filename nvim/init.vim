" .vimrc
" Author: Kenneth Hanley <kennethhanley@gmail.com>
"
" A lot of this file has been copied from
" 		Steve Losh <steve@stevelosh.com>

" Vim-plug {{{
call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-journal'
Plug 'davinche/godown-vim'
Plug 'davidhalter/jedi-vim'
Plug 'vivien/vim-linux-coding-style'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'ervandew/supertab'
Plug 'godlygeek/tabular'
Plug 'vim-scripts/taglist.vim'
Plug 'jplaut/vim-arduino-ino'
"Plug 'justmao945/vim-clang'
Plug 'altercation/vim-colors-solarized'
Plug 'idanarye/vim-dutyl'
Plug 'junegunn/vim-easy-align'
Plug 'xolox/vim-easytags'
Plug 'fatih/vim-go'
Plug 'drmikehenry/vim-headerguard'
Plug 'xolox/vim-misc'
Plug 'terryma/vim-multiple-cursors'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'lervag/vimtex'
Plug 'tpope/vim-surround'
Plug 'xolox/vim-notes'
Plug 'heavenshell/vim-pydocstring'
Plug 'christoomey/vim-tmux-navigator'

Plug 'mhinz/vim-startify'
" sudo apt-get install fonts-powerline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
" sudo apt-get install build-essential python-dev cmake
Plug 'Valloric/YouCompleteMe'
Plug 'edkolev/tmuxline.vim'
Plug 'tpope/vim-fugitive'
Plug 'chrisbra/csv.vim'

Plug 'metakirby5/codi.vim'

call plug#end()
"}}}
" Basic Options {{{
filetype plugin indent on
" This prevents comments being continued on a new line
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

set encoding=utf-8
set autoindent
set nu
set cursorline
set foldmethod=marker
set list
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set title
set synmaxcol=400 "Don't highlight lines longer than 400 chars
let &titleold=getcwd()
set omnifunc=syntaxcomplete#Complete "Syntax completion
" Keep file name and path in statusline
set laststatus=2
set statusline+=%F
" Set column at 80 characters
set colorcolumn=80
highlight ColorColumn ctermbg=0
" Change default split placement
set splitbelow
" Wildmenu {{{
set wildmenu
set wildignore+=.git 								"Version control
set wildignore+=*.aux,*.out,*.toc 					"Latex files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg 		" binary images
set wildignore+=*.o,*.obj,*.exe 					" compiled object files
set wildignore+=*.sw? 								" Vim swap files
set wildignore+=*.pyc 								" Python byte code
"}}}
" Line Return {{{

" Make sure Vim returns to the same line when you reopen a file.
" Thanks, Amit
augroup line_return
	au!
	au BufReadPost *
				\ if line("'\"") > 0 && line("'\"") <= line("$") |
				\     execute 'normal! g`"zvzz' |
				\ endif
augroup END

" }}}
" Tabs, spaces, wrapping {{{
set tabstop=4
set shiftwidth=4
set softtabstop=4
"set expandtab
"set wrap
"set textwidth=80
"set formatoptions=qrn1j
"set colorcolumn=+1

" }}}
" Backups {{{

set backup                        " enable backups
"set noswapfile                    " it's 2013, Vim.

set undodir=~/.vimtmp/undo//     " undo files
set backupdir=~/.vimtmp/backup// " backups
set directory=~/.vimtmp/swap//   " swap files

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
	call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
	call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
	call mkdir(expand(&directory), "p")
endif

" }}}
"}}}
" Search and Movement {{{
set scrolloff=5


" Jumping to tags.
"
" Basically, <c-]> jumps to tags (like normal) and <c-\> opens the tag in a new
" split instead.
"
" Both of them will align the destination line to the upper middle part of the
" screen.  Both will pulse the cursor line so you can see where the hell you
" are.  <c-\> will also fold everything in the buffer and then unfold just
" enough for you to see the destination line.
function! JumpToTag()
	execute "normal! \<c-]>mzzvzz15\<c-e>"
	execute "keepjumps normal! `z"
	Pulse
endfunction
function! JumpToTagInSplit()
	execute "normal! \<c-w>v\<c-]>mzzMzvzz15\<c-e>"
	execute "keepjumps normal! `z"
	Pulse
endfunction
nnoremap <c-]> :silent! call JumpToTag()<cr>
nnoremap <c-\> :silent! call JumpToTagInSplit()<cr>

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz
nnoremap <c-o> <c-o>zz

" Easier to type, and I never use the default behavior.
noremap H ^
noremap L $
vnoremap L g_

inoremap <c-a> <esc>I
inoremap <c-e> <esc>A
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" Insert line above/below without insert mode
"nnoremap <C-J> mao<Esc>`a
"nnoremap <C-K> maO<Esc>`a

nnoremap <PageUp> <Nop>
nnoremap <PageDown> <Nop>

inoremap <PageUp> <Nop>
inoremap <PageDown> <Nop>
vnoremap <PageUp> <Nop>
vnoremap <PageDown> <Nop>
"}}}
" Folding {{{
set foldlevelstart=0

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Make zO recursively open whatever fold we're in, even if it's partially open.
nnoremap zO zczO

function! MyFoldText()
	return repeat(' ', indent(v:foldstart)).foldtext()
endfunction

set foldtext=MyFoldText()
"}}}
" Filetypes {{{
" Arduino {{{
autocmd BufRead,BufNewFile *.pde,*.ino set filetype=arduino
au BufNewFile *.ino,*.pde 0r ~/.vim/skel/arduino.skel
"}}}
" Assembly {{{
au BufNewFile,BufRead *.asm set filetype=nasm
"}}}
" C {{{
au BufNewFile,BufRead *.i set filetype=c
au BufNewFile *.c 0r ~/.vim/skel/c.skel

autocmd filetype c map <leader>d :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
"}}}
" C++ {{{
au BufNewFile,BufRead *.h++ set filetype=cpp
au BufNewFile *.cpp 0r ~/.vim/skel/cpp.skel
au BufNewFile *.cc 0r ~/.vim/skel/cpp.skel

au BufRead * if search('\M-*- C++ -*-', 'n', 1) | setlocal ft=cpp | endif
"}}}
" D {{{
au BufNewFile *.d 0r ~/.vim/skel/d.skel

" This is probably a mistake... But it works to open function definition in a split
autocmd filetype d map <leader>d : DUsjump<CR>
"}}}
" Docs {{{
autocmd BufReadPost *.doc,*.docx,*.rtf,*.odp,*.odt silent %!pandoc "%" -tplain -o /dev/stdout
"}}}
" Go {{{
"au BufNewFile *.go 0r ~/.vim/skel/go.skel

" This is probably a mistake... But it works to open function definition in a split
au FileType go nmap <Leader>d <Plug>(go-def-split)
"}}}
" HTML {{{
au BufNewFile,BufRead *.handlebars set filetype=html
"}}}
" vim-journal {{{
"au BufNewFile,BufRead *.vj set filetype=journal
"}}}
" Python {{{
au BufNewFile,BufRead *.py set filetype=python
"au BufNewFile *.py 0r ~/.vim/skel/py.skel
au FileType python setl foldmethod=indent foldlevel=99

"}}}
" Yorick {{{
"}}}
" Text {{{
"}}}
"}}}
" Quick Editing {{{
nnoremap <leader>ev :tabnew $MYVIMRC<cr>
nnoremap <leader>eb :tabnew ~/.bashrc<cr>
nnoremap <leader>ei :tabnew ~/.i3/config<cr>
nnoremap <leader>et :tabnew ~/.tmux.conf<cr>
nnoremap <leader>ez :tabnew ~/.zshrc<cr>
"}}}
" Convenience {{{
" Tabs {{{
"Setings for tabs"
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>
nnoremap tt  :tabnew<Space>
nnoremap tn  :tabnext<CR>
nnoremap tm  :tabm<Space>
nnoremap td  :tabclose<CR>
"}}}
" Shortcuts {{{
"Clear whitespace
nnoremap <leader>lwr  :%s/^\s\+
nnoremap <leader>twr mz:%s/\s\+$//<cr>:let @/=''<cr>`z

"Add whitespace for daily programmer
nnoremap <leader>lwa :%s/^/    /g

"Split line
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

"Sudo write - when you forget to sudo vim"
cnoremap sudow w !sudo tee % >/dev/null

"Moves char cursor to the end of line
nnoremap zl :let @z=@"<cr>x$p:let @"=@z<cr>

"Add semicolon to the end of the line
nnoremap <leader>; meA;<Esc>`e

" Paste from clilpboard
nnoremap <leader>p :r !xsel -bp<cr>

" Wrap text to split
nnoremap <leader>wr :set wrap linebreak nolist
" Insert Mode Completion {{{

inoremap <c-f> <c-x><c-f>
inoremap <c-]> <c-x><c-]>
inoremap <c-l> <c-x><c-l>

" }}}
"}}}
"}}}
" Abbreviations {{{
iabbrev ldis ಠ_ಠ
"}}}
" Formatting {{{
"Settings for LinuxFormatting"
nnoremap <silent> <leader>k :LinuxCodingStyle<cr>
let g:linuxsty_patterns = [ "/linux/", "/Linux/", "/kernel/", "/Kernel/" ]
"}}}
" Environment {{{
if &diff
	colorscheme skittles_berry
endif
"}}}
" Plugins {{{
" Ctags {{{
"Highlight structs on file save using easy-tags
:let g:easytags_events = ['BufWritePost']
:set tags=./.tags
:let g:easytags_dynamic_files = 2

"Setings for ctags"
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
"}}}
" fzf.vim {{{
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-o> :Lines<CR>
"}}}
" Jedi-vim {{{
" open definitions in tabs
let g:jedi#use_splits_not_buffers = "bottom"

" disables the scratch window at the top of the screen
autocmd FileType python setlocal completeopt-=preview
"}}}
" NERDTree {{{
nnoremap <silent> <leader>nn :NERDTree<cr>
nnoremap <silent> <leader>nm :NERDTreeMirror<cr>
"}}}
" SuperTab {{{

"let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabDefaultCompletionType = "<c-x><c-o>" "Call omnicomplete

"}}}
" Tlist {{{
"Settings for taglist"
let Tlist_Use_Right_Window = 1
nnoremap <silent> <leader>tt :Tlist<CR>
"}}}
" Vim-airline {{{
let g:airline_powerline_fonts = 1
let g:airline_theme = "jellybeans"
"}}}
" Vim-Clang {{{

let g:clang_c_options = '-std=gnu11'
let g:clang_cpp_options = '-std=c++14'

"}}}
" Vim-Dutyl {{{

let g:dutyl_stdImportPaths=['/home/kenneth/Documents/dlang/install/dmd-2.080.1/src/phobos', '/home/kenneth/Documents/dlang/install/dmd-2.080.1/src/druntime/import']

"}}}
" Vim-Easy-Align {{{

nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

"}}}
" Vim-headerguard {{{
nnoremap <silent> <leader>h :HeaderguardAdd<CR>
"}}}
" Vim-multiple-cursors {{{

let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-m>'
let g:multi_cursor_quit_key='<Esc>'

"}}}
" Vim-Notes {{{
let g:notes_directories = ['~/Dropbox/Notes']
"}}}
" YouCompleteMe {{{
let g:ycm_autoclose_preview_window_after_completion=1

let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_python_interpreter_path = '/usr/bin/python3'
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = [
  \  'g:ycm_python_interpreter_path',
  \  'g:ycm_python_sys_path'
  \]
let g:ycm_global_ycm_extra_conf = '~/.global_extra_conf.py'
let g:ycm_confirm_extra_conf = 0
"}}}
"}}}
" Mini-plugins {{{
"Settings to move splits"
function! MarkWindowSwap()
	let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
	"Mark destination
	let curNum = winnr()
	let curBuf = bufnr( "%" )
	exe g:markedWinNum . "wincmd w"
	"Switch to source and shuffle dest->source
	let markedBuf = bufnr( "%" )
	"Hide and open so that we aren't prompted and keep history
	exe 'hide buf' curBuf
	"Switch to dest and shuffle source->dest
	exe curNum . "wincmd w"
	"Hide and open so that we aren't prompted and keep history
	exe 'hide buf' markedBuf
endfunction

nmap <silent> <leader>mw :call MarkWindowSwap()<CR>
nmap <silent> <leader>pw :call DoWindowSwap()<CR>
"}}}
