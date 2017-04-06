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
"   export TERM=xterm-256color； source .vimrc
" 4. git clone git://github.com/sigurdga/gnome-terminal-colors-solarized.git
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
" }}}

" Indent --------------------{{{ 
let g:indent_guides_auto_colors = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 0
" }}}

" Plugins --------------------{{{ 
" let Vundle manage Vundle  
" 可以通过以下四种方式指定插件的来源  
" a) 指定Github中vim-scripts仓库中的插件，直接指定插件名称即可，插件明中的空格使用“-”代替。      " Bundle 'L9'  
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
" autopep8
Bundle 'tell-k/vim-autopep8'
map <leader>p :Autopep8 <CR>
" git diff
Plugin 'airblade/vim-gitgutter'
" indent
Bundle 'git://github.com/nathanaelkane/vim-indent-guides.git'
" airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
let g:airline_theme='simple'
" }}}

" NerdTree Settings --------------------{{{ 
augroup nerdtree_settings
    autocmd!
    " NERDDTree快捷键
    map <leader>t :NERDTreeToggle<CR>
    map <C-n> :NERDTreeToggle<CR>
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
    let NERDTreeIgnore=['\.pyc','\~$','\.swp']
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
    
    " 当vim中没有其他文件，值剩下nerdtree的时候，自动关闭窗口
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif
augroup END
" }}}

" Tab Set --------------------{{{ 
augroup tab_set
    autocmd!
    autocmd FileType php,python,c,java,perl,shell,bash,vim,ruby,cpp set ai
    autocmd FileType php,python,c,java,perl,shell,bash,vim,ruby,cpp set sw=4
    autocmd FileType php,python,c,java,perl,shell,bash,vim,ruby,cpp set ts=4
    autocmd FileType php,python,c,java,perl,shell,bash,vim,ruby,cpp set sts=4
    autocmd FileType coffee,javascript,html,css,xml set ai
    autocmd FileType coffee,javascript,html,css,xml set sw=2
    autocmd FileType coffee,javascript,html,css,xml set ts=2
    autocmd FileType coffee,javascript,html,css,xml set sts=2
augroup END
" }}}

" InsertMode Quick Edit --------------------{{{ 
" use emacs shortcut in INSERT mode
imap <C-e> <END>
imap <C-a> <HOME>
imap <C-f> <Right>
imap <C-b> <Left>
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
" }}}
