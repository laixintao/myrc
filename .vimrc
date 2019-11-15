" ## Ussage
" 0. git clone https://github.com/gmarik/vundle.git
" 1. vim +PluginInstall +qall

" General settings --------------------{{{
set encoding=utf-8
let mapleader=','
syntax enable
set tabstop=4
set shiftwidth=4
set softtabstop=0              " 关闭softtabstop 永远不要将空格和tab混合输入
set expandtab
set nu
set hlsearch
set foldmethod=indent
set nofoldenable               " disable folding
set mouse=a                    " 支持鼠标
" Always show statusline
set laststatus=2
" Use 256 colours (Use this setting only if your terminal supports j
set t_Co=256
set backspace=2 " 删除键的问题
set background=dark
colorscheme molokai
set colorcolumn=80  " max line 80
set cursorline " 高亮光标所在行
set ignorecase
:highlight MatchParen ctermbg=DarkGray ctermfg=black
set incsearch

set wildignore+=*.swp,*.pyc

" 文件编码的猜测顺序
set fileencodings=ucs-bom,utf-8,cp936,gb18030,gb2312,big5,euc-jp,euc-kr,latin1
" }}}

" Key bindings --------------------{{{ 
nnoremap <leader>sp :split<CR>
nnoremap <leader>vs :vsplit<CR>
nnoremap <leader>st :tab split<CR>
" ,作为了leader key, 将\映射成反向查找
noremap \ ,
" }}}

" Plugins --------------------{{{
" let Vundle manage Vundle
" 可以通过以下四种方式指定插件的来源
" a) 指定Github中vim-scripts仓库中的插件，直接指定插件名称即可，插件明中的空格使用“-”代替。
" Plugin 'L9'
" b) 指定Github中其他用户仓库的插件，使用“用户名/插件名称”的方式指定
" Plugin 'tpope/vim-fugitive'
" Plugin 'Lokaltog/vim-easymotion'
" c) 指定非Github的Git仓库的插件，需要使用git地址
" Plugin 'git://git.wincent.com/command-t.git'
" d) 指定本地Git仓库中的插件
" Plugin 'file:///Users/gmarik/path/to/plugin'
set nocompatible               " be iMproved
filetype off                   " required!
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()
Plugin 'gmarik/vundle'                          " Vim Package management
Plugin 'The-NERD-tree'                          " file tree
Plugin 'mattn/emmet-vim'                        " zen coding
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
Plugin 'airblade/vim-gitgutter'                 " git diff
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'neomake/neomake'                        " lint async check
Plugin 'scrooloose/nerdcommenter'               " Quick comment
Plugin 'ruanyl/vim-gh-line'                     " 在Bitbucket或github快速打开当前代码行
Plugin 'ctrlpvim/ctrlp.vim'                     " 模糊查找
Plugin 'terryma/vim-multiple-cursors'           " 多光标编辑
Plugin 'tpope/vim-fugitive'                     " git插件 （Blame)
Plugin 'SirVer/ultisnips'                       " 代码片段
Plugin 'godlygeek/tabular'                      " 自动根据某个符号对其，用于json 字典 表格等
Plugin 'ambv/black'                             " Python code formatter
Plugin 'mechatroner/rainbow_csv'
Plugin 'tweekmonster/startuptime.vim'           " Vim start up time debug (figure out which script is slow)
Plugin 'dyng/ctrlsf.vim'                        " Ascyn use rg to find
Plugin 'majutsushi/tagbar'                      " show tags of codes
Plugin 'Vimjas/vim-python-pep8-indent'          " auto indent ()
Plugin 'tweekmonster/django-plus.vim'
Plugin 'spacewander/openresty-vim'
Plugin 'kien/rainbow_parentheses.vim'           " Rainbow Parentheses
Plugin 'cespare/vim-toml'
Plugin 'stephpy/vim-yaml'
Plugin 'nvie/vim-flake8'
Plugin 'slashmili/alchemist.vim'
Plugin 'mxw/vim-jsx'
Plugin 'elixir-editors/vim-elixir'              " Elixir
Plugin 'prabirshrestha/async.vim'               " Async complete with vim-lsp
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'prabirshrestha/vim-lsp'                 " LSP support
Plugin 'prabirshrestha/asyncomplete-lsp.vim'
Plugin 'prabirshrestha/asyncomplete-file.vim'
Plugin 'thomasfaingnaert/vim-lsp-snippets'      " LSP with ultisnips
Plugin 'thomasfaingnaert/vim-lsp-ultisnips'

" post install (yarn install | npm install) then load plugin only for editing supported files
Plugin 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'html'] }
call vundle#end()
filetype on
filetype plugin on
filetype indent on
set autoindent
set smartindent
" }}}


let g:airline_theme='simple'
let g:airline_powerline_fonts = 1
let g:gist_open_browser_after_post = 1

" NerdComment
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
" vim 8 / neovim HEAD runtime: when ft==python, cms:=#\ %s
" "   -- when g:NERDSpaceDelims==1, then NERDComment results in double space
let g:NERDCustomDelimiters = {
            \ 'python': { 'left': '#', 'right': '' }
            \ }

" Completion settings --------------------{{{ 
let g:lsp_signs_enabled = 1         " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
inoremap <expr> <C-o> pumvisible() ? "\<C-y>" : "\<C-o>"
nmap <leader>dp :LspPeekDefinition<CR>
nmap <leader>gd :vs<cr> :LspDefinition<CR>

let g:lsp_signature_help_enabled = v:false
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'whitelist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))

" ------> LSP <-------
au User lsp_setup call lsp#register_server({
    \ 'name': 'bash-language-server',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
    \ 'whitelist': ['sh'],
    \ })

" Setup LSP
autocmd User lsp_setup call lsp#register_server({
    \ 'name': 'elixir-ls',
    \ 'cmd': {server_info->[&shell, &shellcmdflag, '/usr/local/elixir-ls/language_server.sh']},
    \ 'whitelist': ['elixir', 'eelixir'],
    \ })

" pip install python-language-server
au User lsp_setup call lsp#register_server({
    \ 'name': 'pyls',
    \ 'cmd': {server_info->['pyls']},
    \ 'whitelist': ['python'],
    \ })
" ------> LSP END <-------
" }}}

" CtrlSF
nnoremap <leader>f :CtrlSF 
nnoremap <leader>o :CtrlSFOpen<CR>
let g:ctrlsf_auto_focus = {
    \ "at": "start",
    \ }

" Elixir --------------------{{{ 
function SetupElixir()
    " Map keys for lsp
    nnoremap <buffer> <leader>= :LspDocumentFormat<cr>
endfunction

augroup elixir_lang
    autocmd!
    " See https://github.com/elixir-editors/vim-elixir/issues/121
    autocmd BufRead,BufNewFile *.ex,*.exs set filetype=elixir
    autocmd BufRead,BufNewFile *.eex set filetype=eelixir

    autocmd FileType elixir,eelixir :call SetupElixir()
augroup end
" }}}

" When neomake trigger a check
call neomake#configure#automake('w')
call neomake#configure#automake('nw', 300)
call neomake#configure#automake('rw', 300)
nnoremap <leader>lo :lopen<CR>
nnoremap <leader>lc :lclose<CR>
nnoremap <Leader>ln :lnext<CR>
nnoremap <Leader>lp :lprev<CR>
let g:neomake_tempfile_dir = '/tmp/neomake%:p:h'

nnoremap <leader>b :Gblame<CR>
" UltiSnips triggering
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

nnoremap <F8> :TagbarToggle<CR>

" Rainbow Parenthese --------------------{{{
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
" }}}

" NerdTree Settings --------------------{{{
augroup nerdtree_settings
    autocmd!
    " NERDDTree快捷键
    map <leader>t :NERDTreeToggle<CR>
    map <C-n> :NERDTreeToggle<CR>
    nnoremap <leader>r :NERDTreeFind<cr>
    " 显示行号
    " let NERDTreeShowLineNumbers=1
    " let NERDTreeAutoCenter=1
    " 是否显示隐藏文件
    let NERDTreeShowHidden=1
    " 设置宽度
    let NERDTreeWinSize=30
    " 在终端启动vim时，共享NERDTree
    let g:nerdtree_tabs_open_on_console_startup=1
    " 忽略一下文件的显示
    let NERDTreeIgnore=['\.pyc','\~$',
                \ '\.swp',
                \ '.DS_Store',
                \ '\.orig$',
                \ '@neomake_',
                \ '__pycache__$[[dir]]',
                \ '.pytest_cache$[[dir]]',
                \ '.git[[dir]]',
                \ '.idea[[dir]]',
                \ '.vscode[[dir]]',
                \ 'htmlcov[[dir]]',
                \ 'test-reports[[dir]]',
                \ '.egg-info$[[dir]]']
    " 显示书签列表
    let NERDTreeShowBookmarks=1
    " 改变nerdtree的箭头
    " let g:NERDTreeDirArrowExpandable = '?'
    " let g:NERDTreeDirArrowCollapsible = '?'
    " vim不指定具体文件打开是，自动使用nerdtree
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree |endif

    " 当vim打开一个目录时，nerdtree自动使用
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
    " 打开新的窗口，focus在buffer里而不是NerdTree里
    autocmd VimEnter * :wincmd l

    " 当vim中没有其他文件，值剩下nerdtree的时候，自动关闭窗口
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif
augroup END
" }}}

" InsertMode Quick Edit --------------------{{{
" use emacs shortcut in INSERT mode
imap <C-e> <END>
imap <C-a> <HOME>
imap <C-f> <Right>
imap <C-b> <Left>
augroup relative_numbser
    autocmd!
    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber
augroup END
" }}}

" ShortCuts --------------------{{{
augroup shortcuts
    autocmd!
    " alias Vres to resize screen
    command! -nargs=? Vres vertical res <args>
    nnoremap <leader>a ggvG
    onoremap in( :<c-u>normal! f(vi(<cr>
augroup END
" }}}

" Iabbrev --------------------{{{
augroup iabbrevs
    autocmd!
    " long comment
    autocmd FileType python,coffee :iabbrev <buffer> #-- #-----------<left><left><left><left><left><left>
    autocmd FileType coffee :iabbrev <buffer> cl console.log
augroup END
" }}}

" Lisp --------------------{{{
augroup lisp_lang
    autocmd!
    " for scheme
    let g:lisp_rainbow=1   "（这个是设置括号的颜色）
    autocmd FileType scheme RainbowParenthesesToggle
augroup END
" }}}

" Python --------------------{{{
augroup python_lang
    autocmd!
    autocmd BufNewFile *.py exec ":call SetPythonEncoding()"
    function! SetPythonEncoding()
       call setline(1, "# -*- coding: utf-8 -*-")
    endfunc
    " Python using black
    autocmd FileType python nnoremap <buffer> <leader>= :Black <cr>
augroup END
" }}}

" Javascript-like Language --------------------{{{
function SetupJavascript()
    set sw=2 ts=2
    " Javascript-like language --> Prettier
    " default <leader>p
    let g:prettier#config#parser = 'babylon'
    nmap <Leader>= <Plug>(Prettier)
endfunction

augroup html_lang
    autocmd!
    autocmd BufNewFile,BufRead *.html setlocal nowrap
    autocmd FileType javascript set filetype=javascript.jsx
    autocmd FileType coffee,html,css,xml,yaml,json,js,javascript,dot,gv :call SetupJavascript()
augroup END
" }}}

" VimScript file settings --------------------{{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    " edit vimrc
    :nnoremap <leader>ev :vsplit $MYVIMRC<cr>
    :nnoremap <leader>sv :source $MYVIMRC<cr>
    autocmd FileType vim :iabbrev <buffer> --- --------------------{{{
augroup END
" }}} }}}

" Custome functions --------------------{{{

function! FoldColumnToggle()
    if &foldcolumn
        setlocal foldcolumn=0
    else
        setlocal foldcolumn=4
    endif
endfunction

nnoremap <leader>q :call QuickFixToggle()<cr>

let g:quickfix_is_open = 0

function! QuickFixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
    else
        copen
        let g:quickfix_is_open = 1
    endif
endfunction

function! MoveToPrevTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() != 1
    close!
    if l:tab_nr == tabpagenr('$')
      tabprev
    endif
    sp
  else
    close!
    exe "0tabnew"
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc

function! MoveToNextTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() < tab_nr
    close!
    if l:tab_nr == tabpagenr('$')
      tabnext
    endif
    sp
  else
    close!
    tabnew
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc
nnoremap mt :call MoveToNextTab()<cr>
nnoremap mT :call MoveToPrevTab()<cr>

function! FormatMongodoc2Python() range
    " 将mongo复制过来的doc修改成Python的代码
    let l:delete_lines = []
    for line in range(a:firstline, a:lastline)
        let l:oldline = getline(line)

        if l:oldline =~ "updated_at" || l:oldline =~ "ObjectId"
            let l:delete_lines = add(l:delete_lines, line)
        else
            let l:oldline = substitute(l:oldline, ' :', ':', "g")  " 删除:前面的空格
            let l:oldline = substitute(l:oldline, 'true', 'True', "g")  " true替换
            call setline(line, l:oldline)
        endif
            " execute line 'delete _'
    endfor
    for line in l:delete_lines
        execute line 'delete _'
    endfor
endfunction

nnoremap <leader>m :.,$call FormatMongodoc2Python()<cr>
" }}}

" .tmux.conf --------------------{{{
augroup filetype_tmux_conf
    autocmd!
    autocmd FileType tmux setlocal foldmethod=marker
    autocmd FileType tmux :iabbrev <buffer> --- --------------------{{{
augroup END
" }}}

" graphviz --------------------{{{
augroup graphviz
    autocmd BufNewFile,BufRead *.dot,*.gz nnoremap <leader>dp :call OpenGraphviz()<cr>
    autocmd BufNewFile,BufRead *.dot,*.gz nnoremap <leader>dc :call CompileGraphviz()<cr>
    function! CompileGraphviz()
        execute ":w"
        execute "Compile dot file and then open it."
        execute ":silent !dot -Tsvg -o %:r.svg %"
        execute "redraw!"
    endfunction

    function! OpenGraphviz()
        call CompileGraphviz()
        execute ":silent !open %:r.svg"
        execute "redraw!"
    endfunction
augroup END
" }}}

" nginx --------------------{{{
augroup nginx
    autocmd BufRead,BufNewFile *nginx*.conf* set filetype=nginx
augroup END
" }}}

" clang --------------------{{{
map <F9> : !gcc % && ./a.out <CR>
" }}}


autocmd BufNewFile,BufRead *.mapping set ft=json
autocmd BufNewFile,BufRead *.sls set ft=yaml
autocmd BufNewFile,BufRead *.coffee set ft=coffee
autocmd BufNewFile,BufRead *.toml set ft=TOML

let g:vimwiki_list = [{
            \ 'path'             : '/Users/laixintao/Program/laixintao-wikibot.github.io/wiki',
            \ 'path_html'        : '/Users/laixintao/Program/laixintao-wikibot.github.io/html',
            \ 'template_path'    : '/Users/laixintao/Program/laixintao-wikibot.github.io/html/assets',
            \ 'template_default' : 'default',
            \ 'template_ext'     : '.tpl',
            \ 'auto_export'      : 0}]
autocmd SwapExists * let v:swapchoice = "o"
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git|test-reports\|htmlcov\'


augroup vagrant
  au!
  au BufRead,BufNewFile Vagrantfile set filetype=ruby
augroup END


let g:gh_gitlab_domain= "gitlab.alipay-inc.com"


" Ref
" For C/C++ https://gist.github.com/rocarvaj/2513367
"
