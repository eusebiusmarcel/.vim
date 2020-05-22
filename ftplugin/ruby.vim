" ========= Seeing Is Believing =========
" " Assumes you have a Ruby with SiB available in the PATH
" " If it doesn't work, you may need to `gem install seeing_is_believing -v
" 3.0.0.beta.6`
" " ...yeah, current release is a beta, which won't auto-install
"
" " Annotate every line
"
nmap <buffer> <leader>b :%!seeing_is_believing --timeout 12 --line-length 500 --number-of-captures 300 --alignment-strategy chunk<CR>;
"
"  " Remove annotations
"
nmap <buffer> <leader>c :%.!seeing_is_believing --clean<CR>;
"
" RSpec.vim settings
" let test#ruby#rspec#options = '--tag ~sql_view --tag ~gcs --tag ~flaky --tag ~deprecated'
let test#ruby#bundle_exec = 0

map <buffer> <Leader>t :TestFile<CR>
map <buffer> <Leader>s :TestNearest<CR>
map <buffer> <Leader>l :TestLast<CR>
map <buffer> <Leader>a :TestSuite<CR>
map <buffer> <Leader>v :TestVisit<CR>

" For Running plain Ruby test scripts
map <buffer> <Leader>r <Plug>RunSpecRun
" Switch between spec and corresponding code
map <buffer> <Leader>w <Plug>RunSpecToggle 
" nnoremap <leader>r :RunSpec<CR>
" nnoremap <leader>l :RunSpecLine<CR>
" nnoremap <leader>e :RunSpecLastRun<CR>
" nnoremap <leader>cr :RunSpecCloseResult<CR>

