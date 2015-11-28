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
" NeoBundleLazy 'Markdown'
NeoBundle 'matchit.zip'
" NeoBundle 'airblade/vim-rooter'
" NeoBundle 'sudo.vim'
" NeoBundle 'kana/vim-fakeclip' 
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
NeoBundle 'tsukkee/unite-tag.git'
NeoBundle 'therubymug/vim-pyte'
NeoBundle 'alpaca-tc/alpaca_tags'
NeoBundle 'AndrewRadev/switch.vim'
NeoBundle 'tpope/vim-endwise'

NeoBundle 'shiracamus/vim-syntax-x86-objdump-d'
NeoBundle 'osyo-manga/vim-brightest'
NeoBundle 'cookie-s/vim-unite-disas'
NeoBundle 'honza/vim-snippets'


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

noremap <silent> <C-j> :bn<CR>
noremap <silent> <C-k> :bN<CR>

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
