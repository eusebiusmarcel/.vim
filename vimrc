"Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off
let mapleader=","

" vim-plug (plugin manager)
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
Plug 'szw/vim-maximizer'
Plug 'ervandew/supertab'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-scripts/vim-auto-save'
Plug 'dense-analysis/ale'
Plug 'morhetz/gruvbox'
Plug 'janko/vim-test'
Plug 'zivyangll/git-blame.vim'
Plug 'jremmen/vim-ripgrep'
Plug 'metakirby5/codi.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-obsession'
Plug 'mattn/emmet-vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
"Javascript indentation is set to be 4 with typescript-vim
"Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'mudge/runspec.vim', { 'for': 'ruby' }
Plug 'fatih/vim-go', { 'for': 'go', 'tag': 'v1.22', 'do': ':GoUpdateBinaries' }
Plug 'posva/vim-vue', { 'for': 'vue' }
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
call plug#end()

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
set termguicolors               "Use 256 colors"

"turn on syntax highlighting
syntax on

"set theme
colorscheme gruvbox
set background=light

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

set timeout timeoutlen=1500

" ================= Language Client Config =================
let g:LanguageClient_serverCommands = {
    \ 'javascript': ['tcp://127.0.0.1:2089'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'typescript': ['tcp://127.0.0.1:2089'],
    \ }

let g:LanguageClient_rootMarkers = {
    \ 'javascript': ['jsconfig.json'],
    \ 'typescript': ['tsconfig.json'],
    \ }

" note that if you are using Plug mapping you should not use `noremap` mappings.
nmap <F5> <Plug>(lcn-menu)
" Or map each action separately
nmap <silent>K <Plug>(lcn-hover)
nmap <silent> gd <Plug>(lcn-definition)
nmap <silent> <F2> <Plug>(lcn-rename)

 let g:LanguageClient_rootMarkers = {
     \ 'javascript': ['tsconfig.json'],
     \ 'typescript': ['tsconfig.json'],
     \ }

let g:LanguageClient_diagnosticsEnable=0

" ================= Autocompletion Setup =================
let g:deoplete#enable_at_startup = 1
let g:SuperTabDefaultCompletionType = "<c-n>"

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

" ========================================
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

"nerdtree setup
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeShowHidden=1

"autosave setup
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_in_insert_mode = 0  " do not save while in insert mode

"emmet config
let g:user_emmet_leader_key=';'
let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\}

le setup
let g:ale_fixers = {
  \    'javascript': ['eslint'],
  \    'typescript': ['tslint'],
  \    'vue': ['eslint'],
  \    'scss': ['prettier'],
  \    'html': ['prettier'],
  \    'reason': ['refmt']
\}
nmap <F8> <Plug>(ale_fix)
let g:ale_fix_on_save = 0
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_sign_column_always = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
highlight ALEWarning guibg=#282828 guifg=#ff9966 cterm=italic
highlight ALEError guifg=#282828 guibg=#fb4934
highlight ALEWarningSign guifg=#ff9966 guibg=#3c3836

" ================ Leader Shortcuts ========================

" Window pane resizing
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <Leader>] :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <Leader>[ :exe "vertical resize " . (winwidth(0) * 2/3)<CR>

" Ale
nmap <silent> <Leader>k <Plug>(ale_previous_wrap)
nmap <silent> <Leader>j <Plug>(ale_next_wrap)

" Nerdtree
map <Leader>n :NERDTreeToggle<CR>
map <Leader>m :NERDTreeFind<CR>

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

" Shortcut for console.log
" Console log from insert mode; Puts focus inside parentheses
imap <Leader>cl console.log(': ', );<Esc><S-f>,la
imap <Leader>cj console.log(JSON.stringify({  }, null, 2));<Esc><S-f>{la
" Console log from visual mode on next line, puts visual selection inside parentheses
vmap <Leader>cl yo<Leader>cl<Esc>p<S-f>:<Esc>P
vmap <Leader>cj yo<Leader>cj<Esc>p
" Console log from normal mode, inserted on next line with word your on inside parentheses
nmap <Leader>cl yiwo<Leader>cl<Esc>p<S-f>:<Esc>P
nmap <Leader>cj yiwo<Leader>cj<Esc>p

nnoremap <silent><C-w>z :MaximizerToggle<CR>
vnoremap <silent><C-w>z :MaximizerToggle<CR>gv
inoremap <silent><C-w>z <C-o>:MaximizerToggle<CR>

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
