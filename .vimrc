" 我对vimrc文件的态度是：
" 1. 只配置可以让你少按键的东西（例如不要配置自动格式化代码）
" 2. Don't put anything in your .vimrc you don't understand! (check :help)
" ## Note:
" 1. vim字体受终端的限制，所以如果不是gvim， set guifont是无效的
" 2. 需要安装配色方案，还需要对终端进行配置，如果只安装了Vim的，Vim会看起来雾蒙蒙的一片
"
" 终端配色安装:
" 1. 设置Termial配色：git clone git://github.com/seebi/dircolors-solarized.git
" 2. 注意第二个参数是dircolor是的文件夹
"   cp ~/dircolors-solarized/dircolors.256dark ~/.dircolors
"   eval 'dircolors .dircolors'
" 3. 使设置生效

" cd gnome-terminal-colors-solarized
" ./set_dark.sh 或./set_light.sh
"
" ## Ussage
" 0. Install Vundle: git clone https://github.com/gmarik/vundle.git
" ~/.vim/bundle/vundle
" 1. go in vim, do :PluginInstall
" 2. go ~/.vim/bundle/YouCompleteMe do ./install.sh (some problems: do not use mac port python ,use system python

" General settings --------------------{{{
set nocompatible               " be iMproved
filetype  on                   " required!
filetype plugin on
filetype indent on
set rtp+=/Users/laixintao/.vim/bundle/Vundle.vim
call vundle#rc()
let mapleader=','
syntax enable
set tabstop=4
set shiftwidth=4
set autoindent
set expandtab
set softtabstop=0              " 关闭softtabstop 永远不要将空格和tab混合输入
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
set cursorline " 高亮光标所在行
" 括号颜色
:highlight MatchParen ctermbg=DarkGray ctermfg=black
set incsearch
nnoremap <Leader>p :pc<cr>
set pastetoggle=<F2>
" 80行 120行之后设置为灰色背景
" let &colorcolumn="80,".join(range(120,999),",")
" highlight ColorColumn ctermbg=235 guibg=#2c2d27

set wildignore+=*.swp,*.pyc

" 文件编码的猜测顺序
set fileencodings=ucs-bom,utf-8,cp936,gb18030,gb2312,big5,euc-jp,euc-kr,latin1

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

Plugin 'gmarik/vundle'
Plugin 'Valloric/YouCompleteMe'
Plugin 'The-NERD-tree'
Plugin 'plasticboy/vim-markdown'
Plugin 'mattn/emmet-vim'                                      " zen coding
Plugin 'airblade/vim-gitgutter'                               " git diff
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
Plugin 'neomake/neomake'
Plugin 'scrooloose/nerdcommenter'
Plugin 'ruanyl/vim-gh-line'                                   " 在Bitbucket或github快速打开当前代码行
Plugin 'ctrlpvim/ctrlp.vim'                                   " 模糊查找
Plugin 'sjl/gundo.vim'
Plugin 'terryma/vim-multiple-cursors'                         " 多光标编辑
Plugin 'tpope/vim-fugitive'                                   " git插件 （Blame)
Plugin 'SirVer/ultisnips'                                     " 代码片段
Plugin 'godlygeek/tabular'                                    " 自动根据某个符号对其，用于json 字典 表格等
Plugin 'vimwiki/vimwiki'
Plugin 'ambv/black'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   Unused Awesome Plugins                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" salt sandbox .sls file
"Plugin 'git://github.com/saltstack/salt-vim.git'

" start page
" git clone https://github.com/mhinz/vim-startify ~/.vim/bundle/vim-startify


let g:airline_theme='simple'
let g:airline_powerline_fonts = 1
let g:gist_open_browser_after_post = 1

call neomake#configure#automake('nw', 100)
nnoremap <leader>l :lopen<CR>
nnoremap <leader>lc :lclose<CR>
nnoremap <Leader>ln :lnext<CR>
nnoremap <Leader>lp :lprev<CR>

" 注释的时候自动加个空格, 强迫症必配
let g:NERDSpaceDelims=1

nnoremap <F5> :GundoToggle<CR>
nnoremap <leader>b :Gblame<CR>
" UltiSnips triggering
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

" }}}

" YCM Settings --------------------{{{
augroup ycm_settings:
    autocmd!
    let g:ycm_autoclose_preview_window_after_insertion = 1
    let g:ycm_autoclose_preview_window_after_completion = 1
    let g:ycm_goto_buffer_command = 'horizontal-split'
    let g:ycm_python_binary_path = 'python'
    nnoremap <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
augroup END
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
                \ '.git[[dir]]',
                \ '.cache[[dir]]',
                \ '.idea[[dir]]',
                \ '.vscode[[dir]]',
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

" Tab Set --------------------{{{
augroup tab_set
    autocmd!
    autocmd FileType coffee,html,css,xml,yaml,json,js,javascript set sw=2 ts=2
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
    :onoremap in( :<c-u>normal! f(vi(<cr>
augroup END
" }}}

" Iabbrev --------------------{{{
augroup iabbrevs
    autocmd!
    " long comment
    :autocmd FileType python,coffee :iabbrev <buffer> #-- #-----------<left><left><left><left><left><left>
    :autocmd FileType coffee :iabbrev <buffer> cl console.log
augroup END
" }}}

" Lisp --------------------{{{
augroup lisp_lang
    autocmd!
    " for scheme
    let g:lisp_rainbow=1   "（这个是设置括号的颜色）
augroup END
" }}}

" Python --------------------{{{
augroup python_lang
    autocmd!
    autocmd BufNewFile *.py exec ":call SetPythonEncoding()"
    function! SetPythonEncoding()
       call setline(1, "# -*- coding: utf-8 -*-")
    endfunc
    " ------------------- 缩写 -----------------
    " 使用ipdb自动设置断点
    autocmd FileType python :iabbrev ipdb import ipdb; ipdb.set_trace()<ESC>:w<CR>
    func! RunPython()
        exec 'w'
        exec '!python' shellescape(@%, 1)
    endfunc
    autocmd FileType python nnoremap <buffer> <F5> :call RunPython() <cr>
augroup END
" }}}

" HTML --------------------{{{
augroup html_lang
    autocmd!
    :autocmd BufNewFile,BufRead *.html setlocal nowrap
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
nnoremap <leader>f :call FoldColumnToggle()<cr>

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


autocmd BufNewFile,BufRead *.mapping set ft=json
autocmd BufNewFile,BufRead *.sls set ft=yaml
autocmd BufNewFile,BufRead *.coffee set ft=coffee

let g:vimwiki_list = [{
            \ 'path'             : '/Users/laixintao/Program/laixintao-wikibot.github.io/wiki',
            \ 'path_html'        : '/Users/laixintao/Program/laixintao-wikibot.github.io/html',
            \ 'template_path'    : '/Users/laixintao/Program/laixintao-wikibot.github.io/html/assets',
            \ 'template_default' : 'default',
            \ 'template_ext'     : '.tpl',
            \ 'auto_export'      : 0}]
autocmd SwapExists * let v:swapchoice = "o"
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'


augroup vagrant
  au!
  au BufRead,BufNewFile Vagrantfile set filetype=ruby
augroup END
