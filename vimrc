"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible
filetype off

if has('win32')
    set rtp+=$VIM/vimfiles/bundle/vundle/
    call vundle#rc('$VIM/vimfiles/bundle/')
else
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
endif

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-markdown'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'majutsushi/tagbar'
Bundle 'SirVer/ultisnips'
Bundle 'mileszs/ack.vim'
Bundle 'Raimondi/delimitMate'
Bundle 'ervandew/supertab'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tomasr/molokai'
Bundle 'klen/python-mode'
Bundle 'jnwhiteh/vim-golang'
Bundle 'Chiel92/vim-autoformat'
Bundle 'vimwiki/vimwiki'
Bundle 'bufexplorer.zip'
Bundle 'OmniCppComplete'
Bundle 'pangloss/vim-javascript'
Bundle 'bling/vim-airline'
Bundle 'wookiehangover/jshint.vim'
Bundle 'mattn/emmet-vim'
Bundle 'digitaltoad/vim-jade'
Bundle 'kchmck/vim-coffee-script'

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
if has('gui_running')
    set background=light
else
    set background=dark
endif
"let g:solarized_termtrans=1
"let g:solarized_termcolors=256
"let g:solarized_contrast="high"
"let g:solarized_visibility="high"
colorscheme desert
colorscheme solarized

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
if has('win32')
    source $VIMRUNTIME/mswin.vim
    behave mswin
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    language messages zh_CN.utf-8
    "set fileformats=unix
    set guifont=Lucida_Console:h12:cANSI
endif

autocmd FileType ruby,javascript,css,html
      \	set expandtab | set softtabstop=2 | set shiftwidth=2
autocmd FileType c,cpp set expandtab

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

autocmd BufRead,BufNew,BufAdd * silent! call LoadTags()
function! LoadTags()
    let dir = expand("%:p:h") . '/'
    let i = 0
    while isdirectory(dir) && i < 5
        echom dir
        if has("cscope") && filereadable(dir . 'cscope.out')
            execute ':cs add ' . dir . 'cscope.out'
            let i = 6
        endif
        if filereadable(dir . 'tags')
            execute ':set tags=' . dir . 'tags'
            let i = 6
        endif
        let dir = dir . '../'
        let i = i + 1
    endwhile
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

map <C-\> :cs find c <C-R>=expand("<cword>")<CR><CR>
" map CTRL-E to end-of-line (insert mode)
imap <C-e> <esc>$i<right>
" " map CTRL-A to beginning-of-line (insert mode)
imap <C-a> <esc>0i

" Disable completion previews with function prototypes, etc.
set completeopt=menu

autocmd FileType c,cpp let g:UltiSnipsSnippetDirectories=["snippets"]

" UltiSnips default to TAB, conflict with YCM, use C-j instead
let g:UltiSnipsExpandTrigger="<c-j>"

" youcompleteme is still crappy for C++ if no ycm_extra_conf.py is used
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_confirm_extra_conf = 0

"VimOrganizer
autocmd! BufRead,BufWrite,BufWritePost,BufNewFile *.org
autocmd  BufEnter *.org call org#SetOrgFileType() | set wrap
let g:SuperTabDefaultCompletionType = "context"

let g:vimwiki_list = [{'path': '~/my_site/',
                       \ 'syntax': 'markdown', 'ext': '.md'}]

let delimitMate_expand_cr = 1

let g:formatprg_c = 'astyle'
let g:formatprg_args_expr_c = '"--mode=c --style=kr --max-code-length=80 -pcH".(&expandtab ? "s".&shiftwidth : "t")'
"let g:formatprg_c = 'indent'
"let g:formatprg_args_expr_c = '"-kr -nut -l80 -nfca -ncdb -npsl -nbc -di8"'

"let &equalprg = "indent -kr -nut -l80 -nfca -ncdb -npsl -nbc -di8"
