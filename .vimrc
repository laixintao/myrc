" Note:
" ## Ussage
" 1. go in vim, do :BundleInstall
" 2. go ~/.vim/bundle/YouCompleteMe do ./install.sh (some problems: do not use
" mac port python ,use system python
    set nocompatible              " be iMproved  
    filetype  on                 " required!  
      
    set rtp+=~/.vim/bundle/vundle/  
    call vundle#rc()  
    let mapleader=','
      
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
    Bundle 'The-NERD-Commenter'
    Bundle 'majutsushi/tagbar'  
    Plugin 'godlygeek/tabular'
    Plugin 'plasticboy/vim-markdown'
    nmap <F8> :TagbarToggle<CR>
    " NERDTree
    autocmd VimEnter * NERDTree " 启动的时候自动开启NERDTree
    let NERDTREEShowBookmarks=1
    " coffee script支持 
    Plugin 'kchmck/vim-coffee-script'
    syntax enable
    filetype plugin indent on
    Bundle 'carlosvillu/coffeScript-VIM-Snippets'
    au BufNewFile,BufRead *.coffee set ft=coffee

    " Global
    set ts=4
    set expandtab
    set autoindent " 以上三行，设置tab的作用是打印出4个空格
    
    " 为不同的文件类型设置不同的空格数替换TAB
    autocmd FileType php,python,c,java,perl,shell,bash,vim,ruby,cpp set ai
    autocmd FileType php,python,c,java,perl,shell,bash,vim,ruby,cpp set sw=4
    autocmd FileType php,python,c,java,perl,shell,bash,vim,ruby,cpp set ts=4
    autocmd FileType php,python,c,java,perl,shell,bash,vim,ruby,cpp set sts=4
    autocmd FileType coffee,javascript,html,css,xml set ai
    autocmd FileType coffee,javascript,html,css,xml set sw=2
    autocmd FileType coffee,javascript,html,css,xml set ts=2
    autocmd FileType coffee,javascript,html,css,xml set sts=2

    set nu!
    autocmd VimEnter * wincmd p " 进入vim时，focus在右侧，而不是NERDTree http://stackoverflow.com/questions/4277808/nerdtree-auto-focus-to-file-when-opened-in-new-tab
    " html 自动补全 
    Bundle 'docunext/closetag.vim'
    let g:closetag_html_style=1
    " 设置缩进高亮显示
    Bundle 'git@github.com:nathanaelkane/vim-indent-guides.git'
    " todo 开启vim自动加载
