" vim: foldmethod=marker

if !1 | finish | endif
if &compatible
    set nocompatible
endif

if v:version >= 800
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

    if has('vim_starting') && dein#check_install()
        call dein#install()
    endif
endif

filetype plugin indent on
syntax enable
set background=dark
colorscheme solarized " https://github.com/altercation/vim-colors-solarized

if has("patch-7.4-2201")
    set signcolumn=yes
endif

set number numberwidth=4
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
set mouse= " disable mouse

set backupdir=$HOME/.vimbackup
set directory=$HOME/.vimbackup

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

""" matchit
if !exists('loaded_matchit')
    runtime macros/matchit.vim
endif

""" switch {{{
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
"}}}

""" folding {{{
nnoremap  z[     :<C-u>call <SID>put_foldmarker(0)<CR>
nnoremap  z]     :<C-u>call <SID>put_foldmarker(1)<CR>
function! s:put_foldmarker(foldclose_p)
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

""" Jq {{{

command! -nargs=? Jq call s:Jq(<f-args>)
function! s:Jq(...)
    if 0 == a:0
        let l:arg = "."
    else
        let l:arg = a:1
    endif
    execute "%! jq \"" . l:arg . "\""
endfunction
"}}}

""" .vimrc.local
if filereadable(expand($HOME.'/.vimrc.local'))
  source $HOME/.vimrc.local
endif

autocmd VimEnter * call dein#call_hook('post_source')
