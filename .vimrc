" ## Ussage
" install vim-plug( https://github.com/junegunn/vim-plug )
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Run: PlugInstall

" General settings --------------------{{{
set encoding=utf-8
let mapleader=','
syntax enable
set tabstop=4
set shiftwidth=4
set softtabstop=0              " 关闭softtabstop 永远不要将空格和tab混合输入
set expandtab
set nu
set foldmethod=indent
set nofoldenable               " disable folding
set mouse=a                    " 支持鼠标
" Always show statusline
set laststatus=2
" Use 256 colours (Use this setting only if your terminal supports j
set t_Co=256
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

set backspace=2 " 删除键的问题
set colorcolumn=80  " max line 80
set cursorline " 高亮光标所在行

" search
set ignorecase
set incsearch
set hlsearch
set smartcase

set linebreak

set wildignore+=*.swp,*.pyc
set nocompatible               " be iMproved

filetype on
filetype plugin on
filetype indent on
set autoindent
set smartindent
set shiftround

" 文件编码的猜测顺序
set fileencodings=ucs-bom,utf-8,cp936,gb18030,gb2312,big5,euc-jp,euc-kr,latin1
" }}}

" https://superuser.com/questions/302186/vim-scrolls-very-slowly-when-a-line-is-too-long
" Syntax coloring lines that are too long just slows down the world
set synmaxcol=500

set scrolloff=3

" Key bindings --------------------{{{
nnoremap <leader>sp :split<CR>
nnoremap <leader>vs :vsplit<CR>
nnoremap <leader>st :tab split<CR>
" ,作为了leader key, 将\映射成反向查找
noremap \ ,
" use q to exit help window
autocmd FileType help noremap <buffer> q :q<cr>

" <Leader>[1-9] move to tab [1-9]
" from: https://github.com/liuchengxu/dotfiles/blob/master/vimrc#L74
for s:i in range(1, 9)
  execute 'nnoremap <Leader>' . s:i . ' ' . s:i . 'gt'
endfor

" }}}

" Plugins --------------------{{{
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'mattn/emmet-vim'                        " zen coding
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'airblade/vim-gitgutter'                 " git diff
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter'               " Quick comment
Plug 'ruanyl/vim-gh-line'                     " 在Bitbucket或github快速打开当前代码行
Plug 'ctrlpvim/ctrlp.vim'                     " 模糊查找
Plug 'terryma/vim-multiple-cursors'           " 多光标编辑
Plug 'tpope/vim-fugitive'                     " git插件 （Blame)
Plug 'SirVer/ultisnips'                       " 代码片段
Plug 'godlygeek/tabular'                      " 自动根据某个符号对其，用于json 字典 表格等
Plug 'tweekmonster/startuptime.vim'           " Vim start up time debug (figure out which script is slow)
Plug 'dyng/ctrlsf.vim'                        " Ascyn use rg to find
Plug 'majutsushi/tagbar'                      " show tags of codes
Plug 'Vimjas/vim-python-pep8-indent'          " auto indent ()
Plug 'tweekmonster/django-plus.vim'
Plug 'spacewander/openresty-vim'
Plug 'kien/rainbow_parentheses.vim'           " Rainbow Parentheses
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'nvie/vim-flake8'
Plug 'slashmili/alchemist.vim'
Plug 'mxw/vim-jsx'
Plug 'elixir-editors/vim-elixir'              " Elixir
Plug 'mzlogin/vim-markdown-toc'
Plug 'gabrielelana/vim-markdown'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'benmills/vimux'
Plug 'flazz/vim-colorschemes'
" On-demand lazy load
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

call plug#end()

" }}}

set background=dark
colorscheme molokai

let g:airline_theme='simple'
let g:airline_powerline_fonts = 1
let g:gist_open_browser_after_post = 1

" Vim WhichKey --------------------{{{
nnoremap <silent> <leader> :WhichKey ','<CR>
" }}}


" vim 8 / neovim HEAD runtime: when ft==python, cms:=#\ %s
" "   -- when g:NERDSpaceDelims==1, then NERDComment results in double space
let g:NERDCustomDelimiters = {
            \ 'python': { 'left': '#', 'right': '' }
            \ }

" NerdComment
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
nnoremap <leader>cp :%s/\(print(.*)\)/# \1/g<CR>
nnoremap <leader>cq :%s/# \(print(.*)\)/\1/g<CR>



" CtrlSF
nmap     <leader>ff <Plug>CtrlSFPrompt
vmap     <leader>ff <Plug>CtrlSFVwordPath
vmap     <leader>fF <Plug>CtrlSFVwordExec
nmap     <leader>fn <Plug>CtrlSFCwordPath

nnoremap <leader>fo :CtrlSFOpen<CR>
nnoremap <leader>ft :CtrlSFToggle<CR>
inoremap <leader>ft <Esc>:CtrlSFToggle<CR>
nnoremap <silent> <leader>fj :CtrlSFFocus<CR>

let g:ctrlsf_auto_focus = {
    \ "at": "start",
    \ }

" CLang --------------------{{{
" Register ccls C++ lanuage server.
   " au User lsp_setup call lsp#register_server({
   "    \ 'name': 'ccls',
   "    \ 'cmd': {server_info->['ccls']},
   "    \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
   "    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
   "    \ })
" }}}

" Elixir --------------------{{{
augroup elixir_lang
    autocmd!
    " See https://github.com/elixir-editors/vim-elixir/issues/121
    autocmd BufRead,BufNewFile *.ex,*.exs set filetype=elixir
    autocmd BufRead,BufNewFile *.eex set filetype=eelixir
augroup end
" }}}


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
    nnoremap <leader>d :NERDTreeFind<cr>
    " 是否显示隐藏文件
    let NERDTreeShowHidden=1
    " 设置宽度
    let NERDTreeWinSize=30
    " 在终端启动vim时，共享NERDTree
    let g:nerdtree_tabs_open_on_console_startup=1
    " 忽略一下文件的显示
    let NERDTreeIgnore=['\.pyc','\~$',
                \ '\.swp',
                \ '\.o',
                \ '.DS_Store',
                \ '\.orig$',
                \ '@neomake_',
                \ '.coverage.',
                \ '__pycache__$[[dir]]',
                \ '.pytest_cache$[[dir]]',
                \ '.git$[[dir]]',
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
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END
" }}}

" vimux settings --------------------{{{
nnoremap <leader>rp :w!<CR>:VimuxRunCommand("clear; python3 " . bufname("%"))<CR>
" Prompt for a command to run
nnoremap <Leader>ri :VimuxPromptCommand<CR>
" Close vim tmux runner opened by VimuxRunCommand
nnoremap <Leader>rc :VimuxCloseRunner<CR>
nnoremap <Leader>rl :VimuxRunLastCommand<CR>
"}}}

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


" Javascript-like Language --------------------{{{

augroup javascript_lang
    autocmd!
    autocmd BufNewFile,BufRead *.html setlocal nowrap
    autocmd FileType javascript set filetype=javascript.jsx

    command! -nargs=0 Prettier :CocCommand prettier.formatFile
    autocmd FileType coffee,html,css,xml,yaml,json,js,javascript,dot,gv,typescriptreact vmap <leader>=  <Plug>(coc-format-selected)
    autocmd FileType coffee,html,css,xml,yaml,json,js,javascript,dot,gv,typescriptreact nmap <leader>=  <Plug>(coc-format-selected)
    autocmd FileType coffee,html,css,xml,yaml,json,js,javascript,dot,gv,typescriptreact set sw=2 ts=2
augroup end
" }}}

" Python --------------------{{{ 
augroup python_lang
    autocmd FileType python nmap <leader>=  <Plug>(coc-format)
augroup end
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


" ]p to paste into a newline
" [p to paste into the line upon cursor
" https://github.com/tpope/vim-unimpaired/blob/master/plugin/unimpaired.vim#L343
function! s:putline(how, map) abort
  let [body, type] = [getreg(v:register), getregtype(v:register)]
  if type ==# 'V'
    exe 'normal! "'.v:register.a:how
  else
    call setreg(v:register, body, 'l')
    exe 'normal! "'.v:register.a:how
    call setreg(v:register, body, type)
  endif
  silent! call repeat#set("\<Plug>unimpairedPut".a:map)
endfunction

nnoremap <silent> [p :call <SID>putline('[p', 'Above')<CR>
nnoremap <silent> ]p :call <SID>putline(']p', 'Below')<CR>
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
    autocmd BufNewFile,BufRead *.dot,*.gz nnoremap <leader>p :call OpenGraphviz()<cr>
    autocmd BufNewFile,BufRead *.dot,*.gz nnoremap <leader>c :call CompileGraphviz()<cr>
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

autocmd SwapExists * let v:swapchoice = "o"
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git|test-reports\|htmlcov\'


augroup vagrant
  au!
  au BufRead,BufNewFile Vagrantfile set filetype=ruby
augroup END


let g:gh_gitlab_domain= "gitlab.alipay-inc.com"


" Copy leetcode solution into system clipboard
nnoremap <leader>l /class Solution:<CR>V/\n\n\n<CR>"+y


" Ref
" For C/C++ https://gist.github.com/rocarvaj/2513367


" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
