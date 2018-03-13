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
" 1. go in vim, do :BundleInstall
" 2. go ~/.vim/bundle/YouCompleteMe do ./install.sh (some problems: do not use mac port python ,use system python

" General settings --------------------{{{ 
set nocompatible             " be iMproved  
filetype  on                 " required!  
filetype plugin on
filetype indent on
set rtp+=~/.vim/bundle/vundle/  
call vundle#rc()  
let mapleader=','
syntax enable
set ts=4
set expandtab
set autoindent " 以上三行，设置tab的作用是打印出4个空格
set nu
set hlsearch
set foldmethod=indent
set mouse=a " 支持鼠标
" powerline
set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
" Always show statusline
set laststatus=2
" Use 256 colours (Use this setting only if your terminal supports j
set t_Co=256
let g:airline_powerline_fonts = 1
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

" }}}

" Indent --------------------{{{ 
let g:indent_guides_auto_colors = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 0
" }}}

" Plugins --------------------{{{ 
" let Vundle manage Vundle  
" 可以通过以下四种方式指定插件的来源  
" a) 指定Github中vim-scripts仓库中的插件，直接指定插件名称即可，插件明中的空格使用“-”代替。      
" Bundle 'L9'  
" b) 指定Github中其他用户仓库的插件，使用“用户名/插件名称”的方式指定  
" Bundle 'tpope/vim-fugitive'  
" Bundle 'Lokaltog/vim-easymotion'  
" c) 指定非Github的Git仓库的插件，需要使用git地址  
" Bundle 'git://git.wincent.com/command-t.git'  
" d) 指定本地Git仓库中的插件  
" Bundle 'file:///Users/gmarik/path/to/plugin'  

Bundle 'gmarik/vundle'  

Bundle 'Valloric/YouCompleteMe'

Bundle 'The-NERD-tree'
Bundle 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'kchmck/vim-coffee-script'
Bundle 'carlosvillu/coffeScript-VIM-Snippets'
autocmd BufNewFile,BufRead *.coffee set ft=coffee

" zen coding
Plugin 'mattn/emmet-vim'

" autopep8(use vim-flake8 and syntastic would be better
" Bundle 'tell-k/vim-autopep8'
" map <leader>p :Autopep8 <CR>
" Plugin 'scrooloose/syntastic' " pip install pylint
" Plugin 'nvie/vim-flake8' " pip install python-flake8
" let g:syntastic_error_symbol='>>'
" let g:syntastic_warning_symbol='>'
" let g:syntastic_check_on_open=1
" let g:syntastic_enable_signs=1
" let g:syntastic_check_on_wq=0
" let g:syntastic_enable_highlighting=1
" let g:syntastic_python_checkers=['pylint'] " 使用pyflakes,速度比pylint快

" to see error location list
" let g:syntastic_always_populate_loc_list = 0
" let g:syntastic_auto_loc_list = 0
" let g:syntastic_loc_list_height = 5
" function! ToggleErrors()
"     let old_last_winnr = winnr('$')
"     lclose
"     if old_last_winnr == winnr('$')
"         " Nothing was closed, open syntastic error location panel
"         Errors
"     endif
" endfunction
" nnoremap <Leader>l :call ToggleErrors()<cr>
" nnoremap <Leader>sn :lnext<cr>
" nnoremap <Leader>sp :lprevious<cr>

" git diff
Plugin 'airblade/vim-gitgutter'

" indent
Bundle 'git://github.com/nathanaelkane/vim-indent-guides.git'
" airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
let g:airline_theme='simple'

" Gist
Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'
let g:gist_open_browser_after_post = 1

" for code style!
Plugin 'neomake/neomake'
" function! MyOnBattery()
"   return readfile('/sys/class/power_supply/AC/online') == ['0']
" endfunction
" 
" if MyOnBattery()
"   call neomake#configure#automake('w')
" else
"   call neomake#configure#automake('nw', 1000)
" endif

call neomake#configure#automake('nw', 100)

" start page
"  git clone https://github.com/mhinz/vim-startify ~/.vim/bundle/vim-startify

Bundle 'scrooloose/nerdcommenter'
" 注释的时候自动加个空格, 强迫症必配
let g:NERDSpaceDelims=1

" 快速在bitbucket打开代码
Plugin 'ruanyl/vim-gh-line'

" 快速查找
" https://kien.github.io/ctrlp.vim/
Plugin 'ctrlpvim/ctrlp.vim'

" Gundo
Bundle 'sjl/gundo.vim'
nnoremap <F5> :GundoToggle<CR>

Plugin 'terryma/vim-multiple-cursors'

Plugin 'tpope/vim-fugitive'
nnoremap <leader>b :Gblame<CR>

" UltiSnips triggering
Plugin 'SirVer/ultisnips'
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
    autocmd FileType php,python,c,java,perl,shell,bash,vim,ruby,cpp,javascript set ai
    autocmd FileType php,python,c,java,perl,shell,bash,vim,ruby,cpp,javascript set sw=4
    autocmd FileType php,python,c,java,perl,shell,bash,vim,ruby,cpp,javascript set ts=4
    autocmd FileType php,python,c,java,perl,shell,bash,vim,ruby,cpp,javascript set sts=4
    autocmd FileType coffee,html,css,xml set ai
    autocmd FileType coffee,html,css,xml set sw=2
    autocmd FileType coffee,html,css,xml set ts=2
    autocmd FileType coffee,html,css,xml set sts=2
    autocmd FileType yaml setlocal tabstop=2 expandtab shiftwidth=2 softtabstop=2 smarttab
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
