if !1 | finish | endif
if has('vim_starting')
    if &compatible
        set nocompatible
    endif

    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'matchit.zip'
NeoBundle 'airblade/vim-rooter'
NeoBundle 'sudo.vim'
if version > 702
    NeoBundle 'Shougo/neocomplete'
    NeoBundle 'Shougo/neosnippet'
    NeoBundle 'Shougo/neosnippet-snippets'
    NeoBundle 'Shougo/unite.vim'
    NeoBundle 'Shougo/vimproc'
    NeoBundle 'Shougo/vinarise'
    NeoBundle 'Shougo/vimshell'
    NeoBundle 'Shougo/context_filetype.vim'
endif
"NeoBundle 't9md/vim-quickhl'
"NeoBundle 't9md/vim-textmanip'
"NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'
NeoBundle 'yuku-t/vim-ref-ri'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'nanotech/jellybeans.vim'

NeoBundle 'AndrewRadev/switch.vim'
NeoBundle 'tpope/vim-endwise'

NeoBundle 'shiracamus/vim-syntax-x86-objdump-d'
NeoBundle 'osyo-manga/vim-brightest'
NeoBundle 'cookie-s/vim-unite-disas'
NeoBundle 'honza/vim-snippets'

NeoBundle 'scrooloose/syntastic'
NeoBundle 'szw/vim-tags'


NeoBundleLazy 'alpaca-tc/alpaca_tags', {
            \ 'depends': ['Shougo/vimproc'],
            \ 'autoload' : {
            \   'commands' : [
            \     { 'name' : 'AlpacaTagsBundle', 'complete': 'customlist,alpaca_tags#complete_source' },
            \     { 'name' : 'AlpacaTagsUpdate', 'complete': 'customlist,alpaca_tags#complete_source' },
            \     'AlpacaTagsSet', 'AlpacaTagsCleanCache', 'AlpacaTagsEnable', 'AlpacaTagsDisable', 'AlpacaTagsKillProcess', 'AlpacaTagsProcessStatus',
            \ ],
            \ }}

call neobundle#end()


filetype plugin indent on
syntax enable

NeoBundleCheck

set number ruler
set fileencodings=iso-2022-jp,cp932,utf-8,euc-jp,default,latin
set ignorecase smartcase hlsearch incsearch wrapscan
set noshowmatch
set tabstop=4
set expandtab softtabstop=0
set cindent smarttab shiftwidth=4
set cursorline
set hidden
set visualbell
set laststatus=2

set backupdir=$HOME/.vimbackup
set directory=$HOME/.vimbackup

set background=dark
set t_Co=256
colorscheme hybrid


""" http://deris.hatenablog.jp/entry/2014/05/20/235807
noremap <silent> <C-p> :bn<CR>
noremap <silent> <C-n> :bN<CR>
nnoremap <Space>w :<C-u>w<CR>
nnoremap <Space>q :<C-u>q<CR>
nnoremap <Space>Q :<C-u>q!<CR>
nnoremap <silent> <Space>o  :<C-u>for i in range(v:count1) \| call append(line('.'), '') \| endfor<CR>
nnoremap <silent> <Space>O  :<C-u>for i in range(v:count1) \| call append(line('.')-1, '') \| endfor<CR>
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
inoremap jk <Esc> ""



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

""" vim-easymotion
let g:EasyMotion_keys='hjklasdfHJKLASDFgyurtGYURTopqweOPQWEnmzxcvbNMZXCVB'
let g:EasyMotion_leader_key=";"
let g:EasyMotion_grouping=1
hi EasyMotionTarget ctermbg=black ctermfg=red
hi EasyMotionShade  ctermbg=black ctermfg=blue


""" alpaca_tags
augroup AlpacaTags
    autocmd!
    if exists(':AlpacaTags')
        autocmd BufWritePost Gemfile AlpacaTagsBundle
        autocmd BufEnter * AlpacaTagsSet
        autocmd BufWritePost * AlpacaTagsUpdate
    endif
augroup END

let g:alpaca_tags#config = {
            \ '_' : '-R --sort=yes --languages=+Ruby --languages=-js,JavaScript',
            \ 'js' : '--languages=+js',
            \ '-js' : '--languages=-js,JavaScript',
            \ 'vim' : '--languages=+Vim,vim',
            \ 'php' : '--languages=+php',
            \ '-vim' : '--languages=-Vim,vim',
            \ '-style': '--languages=-css,scss,js,JavaScript,html',
            \ 'scss' : '--languages=+scss --languages=-css',
            \ 'css' : '--languages=+css',
            \ 'java' : '--languages=+java $JAVA_HOME/src',
            \ 'ruby': '--languages=+Ruby',
            \ 'coffee': '--languages=+coffee',
            \ '-coffee': '--languages=-coffee',
            \ 'bundle': '--languages=+Ruby',
            \ }

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
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()
hi Pmenu ctermbg=Gray
hi PmenuSel ctermbg=Red ctermfg=White
hi PmenuSbar ctermbg=Gray

""" snippet
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
imap <expr><TAB>
            \ pumvisible() ? "\<C-n>" :
            \ neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
let g:neosnippet#snippets_directory=['~/.vim/snippets/', '~/.vim/bundle/vim-snippets/snippets/']

if has('conceal')
    set conceallevel=2 concealcursor=niv
endif


""" matchit
if !exists('loaded_matchit')
    runtime macros/matchit.vim
endif


""" switch
function! s:separate_definition_to_each_filetypes(ft_dictionary) "{{{
    let result = {}

    for [filetypes, value] in items(a:ft_dictionary)
        for ft in split(filetypes, ',')
            if !has_key(result, ft)
                let result[ft] = []
            endif

            call extend(result[ft], copy(value))
        endfor
    endfor

    return result
endfunction"}}}
nnoremap - :Switch<CR>


""" brightest
let g:brightest#highlight = {
            \ "group" : "Cursor"
            \}
let g:brightest#enable_filetypes = {
            \"_" : 0,
            \"dis" : 1
            \}


""" unite-disas
nnoremap <silent> [unite]j :<C-u>Unite -buffer-name=disas disas<CR>


""" folding
nnoremap  z[     :<C-u>call <SID>put_foldmarker(0)<CR>
nnoremap  z]     :<C-u>call <SID>put_foldmarker(1)<CR>
function! s:put_foldmarker(foldclose_p) "{{{
    let crrstr = getline('.')
    let padding = crrstr=='' ? '' : crrstr=~'\s$' ? '' : ' '
    let [cms_start, cms_end] = ['', '']
    let outside_a_comment_p = synIDattr(synID(line('.'), col('$')-1, 1), 'name') !~? 'comment'
    if outside_a_comment_p
        let cms_start = matchstr(&cms,'\V\s\*\zs\.\+\ze%s')
        let cms_end = matchstr(&cms,'\V%s\zs\.\+')
    endif
    let fmr = split(&fmr, ',')[a:foldclose_p]. (v:count ? v:count : '')
    exe 'norm! A'. padding. cms_start. fmr. cms_end
endfunction
"}}}

""" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
