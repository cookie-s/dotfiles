if !1 | finish | endif
if &compatible
    set nocompatible
endif

let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
execute 'set rtp+=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    let s:rc_dir    = expand('~/.vim/rc')
    let s:toml      = s:rc_dir . '/dein.toml'
    let s:lazy_toml = s:rc_dir . '/dein_lazy.toml'

    call dein#load_toml(s:toml,      {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})

    call dein#end()
    call dein#save_state()
endif

if !has('vim_starting') && dein#check_install()
    call dein#install()
endif

filetype plugin indent on
syntax enable

set number numberwidth=4
set signcolumn=yes
set ruler
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,iso-2022-jp,cp932,default,latin
set ignorecase smartcase hlsearch incsearch wrapscan
set noshowmatch
set noshowmode
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

let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

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

""" denite
nnoremap [denite] <Nop>
nmap <Space>u [denite]
nnoremap <silent> [denite]b :<C-u>Denite -buffer-name=buffer buffer<CR>
nnoremap <silent> [denite]f :<C-u>Denite -buffer-name=files file<CR>

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
            \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
            \ 'ruby': ['solargraph', 'stdio'],
            \ 'python': ['pyls'],
            \}
let g:LanguageClient_autoStart = 1
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

""" tag-bar
let g:tagbar_width = 40
nn <silent> <leader>t :TagbarToggle<CR>

""" Jq
command! -nargs=? Jq call s:Jq(<f-args>)
function! s:Jq(...)
    if 0 == a:0
        let l:arg = "."
    else
        let l:arg = a:1
    endif
    execute "%! jq \"" . l:arg . "\""
endfunction
