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
Plugin 'w0rp/ale'
Plugin 'morhetz/gruvbox'
Plugin 'janko/vim-test'
Plugin 'mudge/runspec.vim'
Plugin 'fatih/vim-go'
Plugin 'zivyangll/git-blame.vim'

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

"set theme
color gruvbox
set background=dark

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

" Enable extended % matching for if/elsif/else/end, def/end, do/end, etc
runtime macros/matchit.vim

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
nnoremap <silent> <Leader>[ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>] :exe "resize " . (winheight(0) * 2/3)<CR>

" ========= Seeing Is Believing =========
" " Assumes you have a Ruby with SiB available in the PATH
" " If it doesn't work, you may need to `gem install seeing_is_believing -v
" 3.0.0.beta.6`
" " ...yeah, current release is a beta, which won't auto-install
"
" " Annotate every line
"
nmap <leader>b :%!seeing_is_believing --timeout 12 --line-length 500 --number-of-captures 300 --alignment-strategy chunk<CR>;
"
"  " Remove annotations
"
nmap <leader>c :%.!seeing_is_believing --clean<CR>;
"
" ========================================
" 
"ctrlp.vim setup
let g:ctrlp_show_hidden = 1
" Ignore some folders and files for CtrlP indexing
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|public$|log\|tmp$',
  \ 'file': '\.so$\|\.dat$|\.DS_Store$'
  \ }
" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

"nerdtree setup
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeShowHidden=1
map <Leader>n :NERDTreeToggle<CR>
map <Leader>m :NERDTreeFind<CR>

"autosave setup
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_in_insert_mode = 0  " do not save while in insert mode

"ale setup
highlight ALEWarning cterm=underline
highlight ALEError ctermbg=Red cterm=underline
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" RSpec.vim settings
let test#ruby#rspec#options = '--tag ~sql_view'
map <Leader>t :TestFile<CR>
map <Leader>s :TestNearest<CR>
map <Leader>l :TestLast<CR>
map <Leader>a :TestSuite<CR>
map <Leader>v :TestVisit<CR>

" For Running plain Ruby test scripts
map <Leader>r <Plug>RunSpecRun
" Switch between spec and corresponding code
map <Leader>w <Plug>RunSpecToggle 
" nnoremap <leader>r :RunSpec<CR>
" nnoremap <leader>l :RunSpecLine<CR>
" nnoremap <leader>e :RunSpecLastRun<CR>
" nnoremap <leader>cr :RunSpecCloseResult<CR>

" Shortcut for copying and pasting to and from system clipboard
map <Leader>y "+y
map <Leader>d "+d
map <Leader>p "+p

" Shortcut for git
map <Leader>gs :!git status<CR>
map <Leader>gd :!git diff<CR>
map <Leader>gl :!git log<CR>

" Vim Tmux Navigator setting
" let g:tmux_navigator_no_mappings = 1
" 
" nnoremap <silent> {Left-mapping} :TmuxNavigateLeft<cr>
" nnoremap <silent> {Down-Mapping} :TmuxNavigateDown<cr>
" nnoremap <silent> {Up-Mapping} :TmuxNavigateUp<cr>
" nnoremap <silent> {Right-Mapping} :TmuxNavigateRight<cr>
" nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>
"
" let g:spec_runner_dispatcher = "VtrSendCommand! {command}"
"
" nnoremap <leader>irb :VtrOpenRunner {'orientation': 'h', 'percentage': 50, 'cmd': 'irb'}<cr>
"
" Do profiling to see what slows vim down, command ':profile pause' when vim
" starts to slow down, and see profile.log
" profile start profile.log
" profile func *
" profile file *
