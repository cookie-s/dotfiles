if !1 | finish | endif
if has('vim_starting')
    if &compatible
        set nocompatible
    endif

    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'sudo.vim'
if version > 702
    NeoBundle 'Shougo/neocomplete'
    NeoBundle 'Shougo/neosnippet'
    NeoBundle 'Shougo/neosnippet-snippets'
    NeoBundle 'Shougo/unite.vim'
    NeoBundle 'Shougo/vimproc'
    NeoBundle 'Shougo/vinarise'
    NeoBundle 'Shougo/vimshell'
    NeoBundle 'Shougo/neco-vim'
    NeoBundle 'Shougo/context_filetype.vim'
endif
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'
NeoBundle 'yuku-t/vim-ref-ri'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'altercation/vim-colors-solarized'

NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'matchit.zip'
NeoBundle 'airblade/vim-rooter'

NeoBundle 'lervag/vimtex'
NeoBundle 'AndrewRadev/switch.vim'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'todesking/ruby_hl_lvar.vim'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'osyo-manga/vim-monster'

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
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,iso-2022-jp,cp932,default,latin
set ignorecase smartcase hlsearch incsearch wrapscan
set noshowmatch
set tabstop=4
set expandtab softtabstop=0
set smartindent cindent smarttab shiftwidth=4
set cursorline
set hidden
set lazyredraw
set visualbell
set laststatus=2

set updatetime=3000
set backupdir=$HOME/.vimbackup
set directory=$HOME/.vimbackup

set background=dark
set t_Co=256
colorscheme hybrid
hi Pmenu ctermbg=8
hi PmenuSel ctermbg=12
hi PmenuSbar ctermbg=0


nnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <Tab> >>
vnoremap <S-Tab> <<
nnoremap p ]p

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
let g:quickrun_config = {
            \ '_' : {
            \   'runner' : 'vimproc',
            \   'runner/vimproc/updatetime' : 60,
            \   'outputter' : 'error',
            \   'outputter/error/success' : 'buffer',
            \   'outputter/error/error' : 'quickfix',
            \   'outputter/buffer/split' : ':rightbelow 8sp',
            \   'outputter/buffer/close_on_empty' : 1,
            \ },
            \ 'tex' : {
            \   'command' : 'latexmk',
            \   'outputter' : 'error',
            \   'outputter/error/success' : 'null',
            \   'outputter/error/error' : 'quickfix',
            \   'srcfile' : expand("%"),
            \   'hook/sweep/files' : [
            \       '%S:p:r.aux',
            \       '%S:p:r.bbl',
            \       '%S:p:r.blg',
            \       '%S:p:r.dvi',
            \       '%S:p:r.fdb_latexmk',
            \       '%S:p:r.fls',
            \       '%S:p:r.synctex.gz',
            \       ],
            \   'exec' : '%c %o %a %s'
            \   },
            \ 'scheme' : {
            \   'command' : 'guile',
            \ }
            \}


""" unite.vim
let g:unite_enable_start_insert=1
nnoremap [unite] <Nop>
nmap ,u [unite]
" $B%P%C%U%!0lMw(B
nnoremap <silent> [unite]b :<C-u>Unite -buffer-name=buffer buffer<CR>
" $B%U%!%$%k0lMw(B
nnoremap <silent> [unite]f :<C-u>Unite -buffer-name=files file<CR>
" $B%&%#%s%I%&$rJ,3d$7$F3+$/(B
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESC$B%-!<$r(B2$B2s2!$9$H=*N;$9$k(B
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
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:monster#completion#rcodetools#backend = "async_rct_complete"
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
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

""" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='luna'
