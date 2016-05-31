"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible
filetype off

if has('win32')
    set rtp+=$VIM/vimfiles/bundle/vundle/
    call vundle#begin('$VIM/vimfiles/bundle/')
else
    set rtp+=~/.vim/bundle/vundle/
    call vundle#begin()
endif

" let Vundle manage Vundle
" required!
Plugin 'gmarik/vundle'
Plugin 'tpope/vim-fugitive'
Plugin 'mileszs/ack.vim'
Plugin 'rking/ag.vim'
Plugin 'kien/ctrlp.vim'

Plugin 'godlygeek/tabular'
Plugin 'Chiel92/vim-autoformat'
Plugin 'editorconfig/editorconfig-vim'

Plugin 'jlanzarotta/bufexplorer'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'

Plugin 'majutsushi/tagbar'
Plugin 'gtags.vim'

Plugin 'bling/vim-airline'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'morhetz/gruvbox'

"Plugin 'klen/python-mode'
Plugin 'fatih/vim-go'
Plugin 'wting/rust.vim'
Plugin 'cespare/vim-toml'

Plugin 'rfc-syntax'
Plugin 'tpope/vim-speeddating'
Plugin 'jceb/vim-orgmode'

Plugin 'plasticboy/vim-markdown'
Plugin 'vimwiki/vimwiki'

"Plugin 'wookiehangover/jshint.vim'
Plugin 'mattn/emmet-vim'
Plugin 'digitaltoad/vim-jade'
Plugin 'pangloss/vim-javascript'
Plugin 'moll/vim-node'
Plugin 'kchmck/vim-coffee-script'

Plugin 'scrooloose/syntastic'

Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

Plugin 'OmniCppComplete'

if has('win32')
Plugin 'ervandew/supertab'
Plugin 'Shougo/neocomplete.vim'
else
Plugin 'valloric/YouCompleteMe'
endif

Plugin 'Raimondi/delimitMate'

call vundle#end()

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"store lots of :cmdline history
set history=1000

set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom
set number      "show line numbers

"display tabs and trailing spaces
"set list
set listchars=tab:>-,trail:-,nbsp:.,eol:$

set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default

set wrap        "dont wrap lines
set linebreak   "wrap lines at convenient points

if v:version >= 703
    "undo settings
    set undodir=~/.vim/undofiles
    set undofile

    set colorcolumn=+1 "mark the ideal max text width
endif

"default indent settings
set shiftwidth=4
set softtabstop=4
set tabstop=4
set autoindent
set copyindent " copy the previous indentation on autoindenting

" disable sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

set formatoptions-=o "dont continue comments when pushing o/O

"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

"load ftplugins and indent files
filetype plugin on
filetype indent on

"turn on syntax highlighting
syntax on

"some stuff to get the mouse going in term
"set mouse=a
"set ttymouse=xterm2

"tell the term has 256 colors
set t_Co=256

"hide buffers when not displayed
set hidden

set nobackup " no *~ backup files

"colorscheme for solarized
if has('mac')
    let g:solarized_termtrans=1
    let g:solarized_termcolors=256
endif
"let g:solarized_contrast="high"
"let g:solarized_visibility="high"
colorscheme desert
colorscheme solarized
" set background=dark
set background=light

"colorscheme for molokai
"colorscheme molokai

" hilight function name
autocmd BufNewFile,BufRead * :syntax match cfunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>[^()]*)("me=e-2
autocmd BufNewFile,BufRead * :syntax match cfunctions "\<[a-zA-Z_][a-zA-Z_0-9]*\>\s*("me=e-1
highlight cfunctions ctermfg=81
highlight Type ctermfg=120 cterm=none
highlight Structure ctermfg=120 cterm=none
highlight Macro ctermfg=161 cterm=bold
highlight PreCondit ctermfg=161 cterm=bold
highlight CursorLine cterm=underline
set cursorline


"---------------------------------------------------------------------------
" ENCODING SETTINGS
"---------------------------------------------------------------------------
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gbk,gb18030,big5,latin1
set fileformat=unix
set fileformats=unix,dos,mac
if has('win32')
    source $VIMRUNTIME/mswin.vim
    behave mswin
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    language messages zh_CN.utf-8
    "set fileformats=unix
    set guifont=Lucida_Console:h12:cANSI
endif

if has('mac')
    set guifont=Monaco:h19
endif

autocmd FileType ruby,javascript,css,html,jade,coffee
      \ set expandtab | set softtabstop=2 | set shiftwidth=2

"statusline setup
set laststatus=2

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")

        if !&modifiable
            let b:statusline_trailing_space_warning = ''
            return b:statusline_trailing_space_warning
        endif

        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction


"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let b:statusline_tab_warning = ''

        if !&modifiable
            return b:statusline_tab_warning
        endif

        let tabs = search('^\t', 'nw') != 0

        "find spaces that arent used as alignment in the first indent column
        let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        endif
    endif
    return b:statusline_tab_warning
endfunction

"recalculate the long line warning when idle and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

"return a warning for "long lines" where "long" is either &textwidth or 80 (if
"no &textwidth is set)
"
"return '' if no long lines
"return '[#x,my,$z] if long lines are found, were x is the number of long
"lines, y is the median length of the long lines and z is the length of the
"longest line
function! StatuslineLongLineWarning()
    if !exists("b:statusline_long_line_warning")

        if !&modifiable
            let b:statusline_long_line_warning = ''
            return b:statusline_long_line_warning
        endif

        let long_line_lens = s:LongLines()

        if len(long_line_lens) > 0
            let b:statusline_long_line_warning = "[" .
                        \ '#' . len(long_line_lens) . "," .
                        \ 'm' . s:Median(long_line_lens) . "," .
                        \ '$' . max(long_line_lens) . "]"
        else
            let b:statusline_long_line_warning = ""
        endif
    endif
    return b:statusline_long_line_warning
endfunction

"return a list containing the lengths of the long lines in this buffer
function! s:LongLines()
    let threshold = (&tw ? &tw : 80)
    let spaces = repeat(" ", &ts)
    let line_lens = map(getline(1,'$'), 'len(substitute(v:val, "\\t", spaces, "g"))')
    return filter(line_lens, 'v:val > threshold')
endfunction

"find the median of the given array of numbers
function! s:Median(nums)
    let nums = sort(a:nums)
    let l = len(nums)

    if l % 2 == 1
        let i = (l-1) / 2
        return nums[i]
    else
        return (nums[l/2] + nums[(l/2)-1]) / 2
    endif
endfunction

"nerdtree settings
let g:NERDTreeMouseMode = 2
let g:NERDTreeWinSize = 40

"explorer mappings
nnoremap <f1> :BufExplorer<cr>
nnoremap <f2> :NERDTreeToggle<cr>
nnoremap <f3> :TagbarToggle<cr>
nnoremap <f4> :Gtags<SPACE>
nnoremap <silent> <f5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<cr>

" set focus to TagBar when opening it
let g:tagbar_autofocus = 1

"source project specific config files
runtime! projects/**/*.vim

"dont load csapprox if we no gui support - silences an annoying warning
if !has("gui")
    let g:CSApprox_loaded = 1
endif

"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

"map Q to something useful
noremap Q gq

"make Y consistent with C and D
nnoremap Y y$

"visual search mappings
function! s:VSetSearch()
    let temp = @@
    norm! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>


"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'svn\|commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction

"spell check when writing commit logs
autocmd filetype svn,*commit* setlocal spell

"http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
"hacks from above (the url, not jesus) to delete fugitive buffers when we
"leave them - otherwise the buffer list gets poluted
"
"add a mapping on .. to view parent tree
autocmd BufReadPost fugitive://* set bufhidden=delete
autocmd BufReadPost fugitive://*
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif

"autocmd BufRead,BufNew,BufAdd * silent! call LoadTags()
autocmd BufWritePost *.[ch] call UpdateTags(expand('<afile>'))

let g:cscope_use_gtags = 0

function! LoadTags()
    let dir = expand("%:p:h") . '/'
    while isdirectory(dir)
        if has("cscope")
            if g:cscope_use_gtags == 1
                if executable("gtags-cscope") && filereadable(dir . 'GTAGS')
                    execute ':cs add ' . dir . 'GTAGS'
                endif
            elseif filereadable(dir . 'cscope.out')
                execute ':cs add ' . dir . 'cscope.out'
            endif
        endif
        if filereadable(dir . 'tags')
            execute ':set tags+=' . dir . 'tags'
        endif
        let dir = fnamemodify(dir . '../', ":p")
        echom dir
        if dir == '/'
            break
        endif
    endwhile
endfunction

function! UpdateTags(f)
    let dir = fnamemodify(a:f, ':p:h')
    if executable("global")
        execute 'silent !cd ' . dir . ' && global -u &> /dev/null &'
    endif
endfunction

function! UseGtags()
    if has("cscope")
        if executable("gtags-cscope")
            set cscopetag
            set cscopeprg=gtags-cscope
            set csto=0
            set cscopequickfix=c-,d-,e-,f-,g0,i-,s-,t-
            if filereadable("GTAGS")
                cs add GTAGS
            endif
            let g:cscope_use_gtags = 1
        endif
    endif
    call LoadTags()
endfunction

if has("cscope")
    set csprg=cscope
    set csto=0
    set cst
    set nocsverb
    set cscopequickfix=s-,c-,d-,i-,t-,e-
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
    set csverb
endif

autocmd Filetype c,cpp silent! call UseGtags()

map <C-\> :cs find c <C-R>=expand("<cword>")<CR><CR>
" map CTRL-E to end-of-line (insert mode)
imap <C-e> <esc>$i<right>
" " map CTRL-A to beginning-of-line (insert mode)
imap <C-a> <esc>0i

" Disable completion previews with function prototypes, etc.
set completeopt=menu

" UltiSnips default to TAB, conflict with YCM, use C-j instead
let g:UltiSnipsExpandTrigger="<c-j>"

let g:SuperTabDefaultCompletionType = "context"

let g:vimwiki_list = [{'path': '~/docs/my_site/',
                       \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_dir_link = 'index'

let delimitMate_expand_cr = 1

" let g:formatprg_c = 'astyle'
" let g:formatprg_args_expr_c = '"--mode=c --style=kr --max-code-length=80 -pcH".(&expandtab ? "s".&shiftwidth : "t")'
"let g:formatprg_c = 'indent'
"let g:formatprg_args_expr_c = '"-kr -nut -l80 -nfca -ncdb -npsl -nbc -di8"'

"let &equalprg = "indent -kr -nut -l80 -nfca -ncdb -npsl -nbc -di8"
" set formatprg=astyle
"set equalprg=astyle

" 显示函数原型
let OmniCpp_ShowPrototypeInAbbr = 1
let g:Gtags_Use_Tags_Format = 1
" 添加注释时添加空格
let NERDSpaceDelims = 1

" 开启标签补全引擎
set completeopt=longest,menu    "让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
autocmd InsertLeave * if pumvisible() == 0|pclose|endif "离开插入模式后自动关闭预览窗口
imap <expr> <CR>       pumvisible() ? "\<C-y>" : "<Plug>delimitMateCR"    "回车即选中当前项
"上下左右键的行为 会显示其他信息
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

"youcompleteme  默认tab  s-tab 和自动补全冲突
"let g:ycm_key_list_select_completion=['<c-n>']
"let g:ycm_key_list_select_completion = ['<Down>']
"let g:ycm_key_list_previous_completion=['<c-p>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_confirm_extra_conf=0 "关闭加载.ycm_extra_conf.py提示

" let g:ycm_collect_identifiers_from_tags_files=1 " 开启 YCM 基于标签引擎
let g:ycm_min_num_of_chars_for_completion=2 " 从第2个键入字符就开始罗列匹配项
let g:ycm_cache_omnifunc=0  " 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_seed_identifiers_with_syntax=1    " 语法关键字补全
"nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>    "force recomile with syntastic
"nnoremap <leader>lo :lopen<CR> "open locationlist
"nnoremap <leader>lc :lclose<CR>    "close locationlist
" 集成OmniCppComplete补全引擎，设置快捷键
inoremap <leader><leader> <C-x><C-o>
"在注释输入中也能补全
let g:ycm_complete_in_comments = 1
"在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
"注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 1
" 允许加载配置文件
let g:ycm_confirm_extra_conf=0
let g:ycm_rust_src_path = '/home/hawkbee/devel/rust/src'

nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR> " 跳转到定义处
nnoremap <leader>] :YcmCompleter GoToDefinitionElseDeclaration<CR> " 跳转到定义处

let g:go_disable_autoinstall = 1
let g:neocomplete#enable_at_startup = 1

let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.(git|hg|svn)|OUTPUT)$',
    \ 'file': '\v(\.(exe|so|dll|d|o|bin)|GTAGS|GRTAGS|GSYMS|GPATH|TAGS|tags)$',
    \ }

" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
"
" Note: Must allow nesting of autocmds to enable any customizations for quickfix
" buffers.
" Note: Normally, :cwindow jumps to the quickfix window if the command opens it
" (but not if it's already open). However, as part of the autocmd, this doesn't
" seem to happen.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
