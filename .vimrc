if !1 | finish | endif
if &compatible
    set nocompatible
endif
set runtimepath+=~/.vim/bundle/repos/github.com/Shougo/dein.vim/

if dein#load_state('~/.vim/bundle')
    call dein#begin('~/.vim/bundle')

    call dein#add('~/.vim/bundle/repos/github.com/Shougo/dein.vim')

    call dein#add('vim-scripts/sudo.vim')
    call dein#add('Shougo/neosnippet')
    call dein#add('Shougo/neosnippet-snippets')
    call dein#add('Shougo/vimproc')
    call dein#add('Shougo/vinarise')
    call dein#add('Shougo/neco-vim')
    call dein#add('Shougo/neoinclude.vim')
    call dein#add('Shougo/vimshell')

    call dein#add('Shougo/unite.vim')

    call dein#add('airblade/vim-rooter')
    call dein#add('cookie-s/project.vim')
    call dein#add('thinca/vim-quickrun')
    call dein#add('w0ng/vim-hybrid')

    call dein#add('Lokaltog/vim-easymotion')
    call dein#add('vim-scripts/matchit.zip')
    call dein#add('slim-template/vim-slim')
    call dein#add('embear/vim-localvimrc')

    call dein#add('AndrewRadev/switch.vim')
    call dein#add('tpope/vim-endwise')
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')

    call dein#add('shiracamus/vim-syntax-x86-objdump-d')
    call dein#add('osyo-manga/vim-brightest')
    call dein#add('cookie-s/vim-unite-disas')
    call dein#add('scrooloose/syntastic')

    call dein#add("majutsushi/tagbar")
    call dein#add('alpaca-tc/alpaca_tags')
    call dein#add('stephpy/vim-php-cs-fixer')
    call dein#add('editorconfig/editorconfig-vim')
    call dein#add('leafgarland/typescript-vim')

    if has('python3')
        call dein#add('Shougo/deoplete.nvim')
        if !has('nvim')
            call dein#add('roxma/nvim-yarp')
            call dein#add('roxma/vim-hug-neovim-rpc')
        endif
        call dein#add('autozimu/LanguageClient-neovim')
    endif
    call dein#add('Shougo/denite.nvim')
    call dein#add('Shougo/echodoc.vim')

    call dein#add('fatih/vim-go')

    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable

set number ruler
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,iso-2022-jp,cp932,default,latin
set ignorecase smartcase hlsearch incsearch wrapscan
set noshowmatch
set tabstop=4
set expandtab softtabstop=0
set smartindent smarttab shiftwidth=4
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

autocmd BufRead,BufNewFile *.ts set filetype=typescript

""" http://deris.hatenablog.jp/entry/2014/05/20/235807
nnoremap <silent> <C-p> :bN<CR>
nnoremap <silent> <C-n> :bn<CR>
nnoremap <Space>w :<C-u>w<CR>
nnoremap <Space>q :<C-u>q<CR>
nnoremap <Space>Q :<C-u>q!<CR>
nnoremap <silent> <Space>o  :<C-u>for i in range(v:count1) \| call append(line('.'), '') \| endfor<CR>
nnoremap <silent> <Space>O  :<C-u>for i in range(v:count1) \| call append(line('.')-1, '') \| endfor<CR>
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
inoremap jk <Esc> ""

nnoremap === gg=G<C-o><C-o>
hi MatchParen ctermbg=red


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
            \ },
            \ 'ocaml' : {
            \   'command' : 'ocaml',
            \ },
            \}
let g:quickrun_no_default_key_mappings = 1
nnoremap \r :cclose<CR>:QuickRun -mode n<CR>
xnoremap \r :<C-U>cclose<CR>gv:QuickRun -mode v<CR>


""" project.vim
let g:proj_flags = "imstcS"
nmap \p <Plug>ToggleProject
nnoremap \P :Project .vimproject<CR>
autocmd BufAdd .vimproject silent! %foldopen!
autocmd BufAdd .vimprojects silent! %foldopen!
if getcwd() != $HOME
    if filereadable(getcwd() . '/.vimproject')
        autocmd VimEnter * Project .vimproject
    endif
endif


""" vim-easymotion
let g:EasyMotion_keys='hjklasdfHJKLASDFgyurtGYURTopqweOPQWEnmzxcvbNMZXCVB'
let g:EasyMotion_leader_key=";"
let g:EasyMotion_grouping=1
hi EasyMotionTarget ctermbg=black ctermfg=red
hi EasyMotionShade  ctermbg=black ctermfg=blue

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
function! s:separate_definition_to_each_filetypes(ft_dictionary)
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
endfunction
nnoremap <silent> - :Switch<CR>

""" alpaca_tags
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
augroup AlpacaTags
    autocmd!
    autocmd BufWritePost Gemfile AlpacaTagsBundle
    autocmd BufEnter * AlpacaTagsSet
    autocmd BufWritePost * if isdirectory(glob(getcwd() . '/.git')) | AlpacaTagsUpdate -R | endif
augroup END

""" unite
nnoremap [unite] <Nop>
nmap ,u [unite]
nnoremap <silent> [unite]b :<C-u>Unite -buffer-name=buffer buffer<CR>
nnoremap <silent> [unite]f :<C-u>Unite -buffer-name=files file<CR>

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

""" ocaml
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute 'set rtp+=' . g:opamshare . '/merlin/vim'
execute 'set rtp^=' . g:opamshare . '/ocp-indent/vim'

""" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs = 1
let g:syntastic_echo_current_error = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_enable_highlighting = 1
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_mode_map = {
            \ 'mode': 'active',
            \ 'active_filetypes': ['php']
            \}
let g:syntastic_php_checkers = ['phpcs']
let g:syntastic_php_phpcs_args = '--standard=psr2'

let g:syntastic_ocaml_checkers = [g:opamshare . '/bin/ocamlmerlin']

""" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='luna'

""" vim-localvimrc
let g:localvimrc_ask = 0


""" vim-php-cs-fixer
let g:php_cs_fixer_level = "symfony"
let g:php_cs_fixer_config = "default"

let g:php_cs_fixer_rules = "@Symfony"
let g:php_cs_fixer_cache = ".php_cs.cache"

let g:php_cs_fixer_php_path = "php"
let g:php_cs_fixer_enable_default_mapping = 0
let g:php_cs_fixer_dry_run = 1
let g:php_cs_fixer_verbose = 1

nnoremap <silent><leader>pcd :call PhpCsFixerFixDirectory()<CR>
nnoremap <silent><leader>pcf :call PhpCsFixerFixFile()<CR>

""" vim-rooter
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_manual_only = 1
let g:rooter_use_lcd = 1

""" language-server
let g:LanguageClient_serverCommands = {
            \ 'rust' : ['rustup', 'run', 'nightly', 'rls'],
            \ 'ruby' : ['language_server-ruby'],
            \ 'python' : ['pyls'],
            \}
let g:LanguageClient_autoStart = 1
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

""" vim-brightest
let g:brightest#highlight = {
            \ "group" : "Cursor"
            \}
let g:brightest#enable_filetypes = {
            \ "_"   : 0,
            \ "dis" : 1,
            \}


""" deoplete.nvim
let g:deoplete#enable_at_startup = 1

""" tag-bar
let g:tagbar_width = 40
nn <silent> <leader>t :TagbarToggle<CR>



if (filereadable(expand('~/.vimrc.local')))
    so ~/.vimrc.local
endif

