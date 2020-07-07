"Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-endwise'
Plugin 'ervandew/supertab'
Plugin 'jiangmiao/auto-pairs'
Plugin 'vim-scripts/vim-auto-save'
Plugin 'zivyangll/git-blame.vim'
Plugin 'jremmen/vim-ripgrep'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tpope/vim-obsession'
Plugin 'posva/vim-vue'

call vundle#end()
filetype plugin on
filetype indent on

" ================ General Config ====================
set number relativenumber       "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim

"turn on syntax highlighting
syntax on

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all 
" the plugins.
let mapleader=","
set timeout timeoutlen=1500

" ================= Additional Config =================
" Reference: http://items.sjbach.com/319/configuring-vim-right
" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
set hidden

" Scroll the viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>


" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo') && !isdirectory(expand('~').'/.vim/backups')
silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile
endif

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

"
" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set linebreak    "Wrap lines at convenient points

" ================ Custom Settings ========================

" Window pane resizing
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
" nnoremap <silent> <Leader>] :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
" nnoremap <silent> <Leader>[ :exe "vertical resize " . (winwidth(0) * 2/3)<CR>

" ========================================
"
" ctags setup
" Command in project folder for the first time: ctags -R *
" Make sure you have exuberant ctags installed.
" Make sure you put tags file in .gitignore.
set tags=./tags;
" set shortcut to update tags
map <Leader>ut :!ctags -R *<CR>
nnoremap <Leader>] :tn<CR>
nnoremap <Leader>[ :tp<CR>
"
"ctrlp.vim setup
let g:ctrlp_max_files=0
" Ignore some folders and files for CtrlP indexing
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|public$|log\|tmp$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$'
  \ }

" vim-ripgrep setup
" Make sure you have ripgrep installed
" set smartcase mode
let g:rg_command = 'rg --vimgrep -S'

" ctrlp ripgrep setup
" https://elliotekj.com/2016/11/22/setup-ctrlp-to-use-ripgrep-in-vim/
if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif
" ignore git and temp directories as well as Vim’s swap files
set wildignore+=*/.git/*,*/tmp/*,*.swp
" Show up to 100 results
" https://github.com/kien/ctrlp.vim/issues/187
let g:ctrlp_match_window = 'results:100'
" Set shortcut for searching tags
" https://www.freecodecamp.org/news/make-your-vim-smarter-using-ctrlp-and-ctags-846fc12178a4/
nnoremap <leader>. :CtrlPTag<cr>

"nerdtree setup
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeShowHidden=1
map <Leader>n :NERDTreeToggle<CR>
map <Leader>m :NERDTreeFind<CR>

"autosave setup
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_in_insert_mode = 0  " do not save while in insert mode

" Shortcut for copying and pasting to and from system clipboard
map <Leader>y "+y
map <Leader>d "+d
map <Leader>p "+p
map <Leader>P "+P

" Shortcut for git
map <Leader>gs :!git status<CR>
map <Leader>gd :!git diff<CR>
map <Leader>gt :!git diff --staged<CR>
map <Leader>ga :!git add .<CR>
map <Leader>gc :!git commit<CR>
map <Leader>gm :!git commit --amend<CR>
map <Leader>gl :!git log<CR>
map <Leader>gh :!git diff HEAD^<CR>
map <Leader>gf :!git push --force-with-lease<CR>
map <Leader>gp :!git push<CR>
" Shortcut for git blame
nnoremap <Leader>bm :<C-u>call gitblame#echo()<CR>
