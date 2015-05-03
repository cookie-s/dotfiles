if !1 | finish | endif
if has('vim_starting')
    if &compatible
        set nocompatible
    endif

    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'

" NeoBundle 'project.tar.gz'
" NeoBundle 'Lokaltog/vim-easymotion'
" NeoBundle 'rhysd/clever-f.vim'
"NeoBundleLazy 'Markdown'
" NeoBundle 'matchit.zip'
" NeoBundle 'airblade/vim-rooter'
" NeoBundle 'sudo.vim'
" NeoBundle 'kana/vim-fakeclip' 
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vinarise'
"NeoBundle 't9md/vim-quickhl'
" NeoBundle 't9md/vim-textmanip'
"NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'
NeoBundle 'tsukkee/unite-tag.git'
NeoBundle 'therubymug/vim-pyte'
NeoBundleLazy 'alpaca-tc/alpaca_tags', {
            \ 'depends': ['Shougo/vimproc', 'Shougo/unite.vim'],
            \ 'autoload' : {
            \   'commands' : ['Tags', 'TagsUpdate', 'TagsSet', 'TagsBundle', 'TagsCleanCache'],
            \   'unite_sources' : ['tags']
            \ }}

call neobundle#end()


filetype plugin indent on
syntax on

NeoBundleCheck

set number
set fileencodings=iso-2022-jp,cp932,utf-8,euc-jp,default,latin
set ignorecase smartcase hlsearch incsearch wrapscan
set showmatch
set smartindent shiftwidth=4 autoindent
set smarttab tabstop=4 expandtab
set cursorline
set hidden
set visualbell

set backupdir=$HOME/.vimbackup
set directory=$HOME/.vimbackup

set background=dark
set t_Co=256

colorscheme darkblue
" colorscheme pyte

""" quickrun
let g:quickrun_config = {}
let g:quickrun_config._ = {'runner' : 'vimproc'}


""" unite.vim
let g:unite_enable_start_insert=1
nnoremap [unite] <Nop>
nmap ,u [unite]
" バッファ一覧
nnoremap <silent> [unite]b :<C-u>Unite -buffer-name=buffer buffer<CR>
" ファイル一覧
nnoremap <silent> [unite]f :<C-u>Unite -buffer-name=files file<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q
au FileType ruby set nowrap tabstop=2 shiftwidth=2
augroup AlpacaTags
    autocmd!
    if exists(':Tags')
        autocmd BufWritePost * TagsUpdate ruby
        autocmd BufWritePost Gemfile TagsBundle
        autocmd BufEnter * TagsSet
    endif
augroup END


""" vim-easymotion
let g:EasyMotion_keys='hjklasdfHJKLASDFgyurtGYURTopqweOPQWEnmzxcvbNMZXCVB'
let g:EasyMotion_leader_key=";"
let g:EasyMotion_grouping=1
hi EasyMotionTarget ctermbg=black ctermfg=red
hi EasyMotionShade  ctermbg=black ctermfg=blue


""" alpaca_tags
let g:alpaca_tags_config = {
            \ '_' : '-R --sort=yes --languages=+Ruby --languages=-js,html,css',
            \ 'ruby': '--languages=+Ruby',
            \ }
let g:alpaca_tags_ctags_bin = '/usr/bin/ctags'
nnoremap <silent> <expr> [unite]t ':<C-u>Unite tag -horizontal -buffer-name=tags -input='.expand("<cword>").'<CR>'
autocmd BufEnter *
            \   if empty(&buftype)
            \|      nnoremap <buffer> <C-]> :<C-u>UniteWithCursorWord -immediately tag<CR>
            \|  endif


""" neocomplete
let g:acp_enableAtStartup=0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()
hi Pmenu ctermbg=Gray
hi PmenuSel ctermbg=Red ctermfg=White
hi PmenuSbar ctermbg=Gray
