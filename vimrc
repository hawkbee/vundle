let mapleader = "\<Space>"
let maplocalleader = ","

" let g:python_host_skip_check=1
" let g:loaded_python3_provider=1

let g:flow#enable = 0

let g:has_async = v:version >= 800 || has('nvim')
let g:python_host_prog = $HOME . '/.virtualenvs/neovim2/bin/python'
let g:python3_host_prog = $HOME . '/.virtualenvs/neovim/bin/python'
let $RUST_SRC_PATH = $HOME . '/cloud/devel/rust/src'

source ~/.vim/plugrc

source ~/.vim/vimrc.default

call plug#begin()

Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['javascript', 'jsx', 'css']

Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

Plug 'Yggdroot/indentLine'

" Ack
Plug 'mileszs/ack.vim'

if g:has_async
  Plug 'w0rp/ale'
else
  Plug 'scrooloose/syntastic'
endif

Plug 'roxma/nvim-completion-manager'
if !has('nvim')
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'Shougo/neco-syntax'
Plug 'fgrsnau/ncm-otherbuf'
Plug 'roxma/ncm-clang', {'for': ['c', 'cpp']}
Plug 'roxma/nvim-cm-tern', {'for': ['javascript'], 'do': 'npm install'}
" Plug 'roxma/nvim-cm-racer', {'for': 'rust'}
" Plug 'roxma/ncm-flow', {'for': ['javascript']}

if executable('gtags')
Plug 'whatot/gtags-cscope.vim'
let g:Gtags_Auto_Update = 1
let g:GtagsCscope_Auto_Load = 1
let g:GtagsCscope_Quiet = 1
let g:Gtags_Use_Tags_Format = 1
map <C-\>c:cs find c <C-R>=expand("<cword>")<CR><CR>
set cscopetag
endif

" Really nice prompt
" if !exists('g:airline_symbols')
  " let g:airline_symbols = {}
" endif
" let g:airline_symbols.linenr = '¶'
" let g:airline_powerline_fonts = 1
" let g:airline_theme='dark'
" let g:airline_left_sep=''
" let g:airline_right_sep=''
" let g:airline_section_z=''
" Plug 'bling/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim'
set laststatus=2

Plug 'jparise/vim-graphql'
"
" " Press v over and over again to expand selection
Plug 'terryma/vim-expand-region'
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

Plug 'jiangmiao/auto-pairs'
Plug 'rhysd/conflict-marker.vim'
Plug 'Chiel92/vim-autoformat'
Plug 'fleischie/vim-styled-components'

Plug 'Yggdroot/LeaderF', {'do': './install.sh'}
map <Leader>pf :LeaderfFile<cr>
map <Leader>bb :LeaderfBuffer<cr>

" Plug 'Shougo/denite.nvim'
" map <Leader>pf :Denite file<cr>
" map <Leader>bb :Denite buffer<cr>
" Plug 'ctrlpvim/ctrlp.vim'
" map <Leader>pf :CtrlP<cr>
" map <Leader>bb :CtrlPBuffer<cr>

"Editorconfig
if executable('editorconfig') && has('python')
Plug 'editorconfig/editorconfig-vim'
else
Plug 'sgur/vim-editorconfig'
endif

Plug 'scrooloose/nerdtree'
let g:NERDTreeMouseMode = 2
let g:NERDTreeWinSize = 40
" map <leader>0 :NERDTreeToggle<CR>
Plug 'scrooloose/nerdcommenter'
" 添" 加注释时添加空格
let g:NERDSpaceDelims = 1

Plug 'majutsushi/tagbar'
" set focus to TagBar when opening it
let g:tagbar_autofocus = 1

" Ranger
if executable('ranger')
if has('nvim')
Plug 'rbgrouleff/bclose.vim'
map <Leader>bd :Bclose<cr>
endif
Plug 'francoiscabrol/ranger.vim'
let g:ranger_map_keys = 0
map <leader>ar :Ranger<CR>
let g:NERDTreeHijackNetrw = 0
let g:ranger_replace_netrw = 1
endif


Plug 'altercation/vim-colors-solarized'
Plug 'vim-scripts/peaksea'

" Allow to :Rename files
Plug 'danro/rename.vim'

Plug 'flowtype/vim-flow'

" Automatically find root project directory
Plug 'airblade/vim-rooter'
let g:rooter_resolve_links = 1
let g:rooter_disable_map = 1
let g:rooter_silent_chdir = 1

" Expand / wrap hashes etc.
Plug 'AndrewRadev/splitjoin.vim'
nmap sj :SplitjoinSplit<cr>
nmap sk :SplitjoinJoin<cr>

Plug 'rust-lang/rust.vim', {'for': 'rust'}
let g:rustfmt_autosave = 1
Plug 'racer-rust/vim-racer', {'for': 'rust'}
autocmd FileType rust nmap gd <Plug>(rust-def)

Plug 'tpope/vim-speeddating', {'for': ['markdown', 'vimwiki']}
Plug 'jceb/vim-orgmode', {'for': 'org'}
Plug 'vimwiki/vimwiki', {'for': 'vimwiki'}
let g:vimwiki_dir_link = 'index'

Plug 'fatih/vim-go', { 'for': 'go' }
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
" Plug 'nsf/gocode', { 'rtp': g:editor, 'do': '~/.vim/plugged/gocode/vim/symlink.sh', 'for': 'go' }

Plug 'davidhalter/jedi-vim', {'for': 'python'}
let g:jedi#completions_command = "<C-N>"
let g:jedi#rename_command = ""
autocmd Filetype python setlocal equalprg=yapf
autocmd FileType python nmap gd :call jedi#goto()<CR>

Plug 'klen/python-mode', { 'branch': 'develop'}
let g:pymode_rope = 0
let g:pymode_lint_checkers = ['pyflakes']
let g:pymode_run_bind = '<LocalLeader>r'
let g:pymode_breakpoint_bind = '<LocalLeader>b'

Plug 'alvan/vim-closetag'
Plug 'mattn/emmet-vim', {'for': ['html', 'xml', 'xslt']}

Plug 'calebeby/ncm-css'
" Plug 'posva/vim-vue'
Plug 'moll/vim-node', { 'for': 'javascript' }
Plug 'othree/javascript-libraries-syntax.vim'
" Plug 'othree/yajs.vim', {'for': ['javascript'], 'tag': '1.6'}
" Plug 'neoclide/vim-jsx-improve'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
" Plug 'maxmellon/vim-jsx-pretty'
autocmd BufRead,BufNewFile *.vue,*.wpy setf javascript.jsx

Plug 'vim-scripts/po.vim--Jelenak', {'for': 'po'}

" Nice column aligning with <Enter>
Plug 'junegunn/vim-easy-align'
vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)

" ii / ai
Plug 'michaeljsmith/vim-indent-object'

" For more reliable indenting and performance
set foldmethod=indent
set fillchars="fold: "

" Set nice 80-characters limiter
" execute "set colorcolumn=" . join(range(81,335), ',')
" hi ColorColumn guibg=#262626 ctermbg=235

Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<c-j>"
Plug 'honza/vim-snippets'

call plug#end()

vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
nmap <Leader><Leader> V
nnoremap <Leader><Tab> <C-^>
nnoremap <Leader>y :!annotate expand('%:p') " what?

vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" nnoremap <CR> G
nnoremap <BS> gg
nnoremap <Leader>w :w<CR>
nnoremap <Leader>s :wq<CR>
nnoremap <Leader>v V
nnoremap <Leader>g gf

" Remove trailing whitespaces
nnoremap <silent> <Leader><Space> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>:w<CR>

" nnoremap <F1> :CtrlPBuffer<CR>
" nnoremap <F2> :CtrlP<CR>
nnoremap <F1> :LeaderfBuffer<CR>
nnoremap <F2> :LeaderfFile<CR>
nnoremap <F3> :NERDTreeToggle<CR>
nnoremap <F4> :TagbarToggle<CR>
nnoremap <F5> :Ranger<CR>
" nnoremap <Leader><Tab> :b#<CR>
nnoremap <Leader>/ :Ack<Space><C-R><CR><CR>

nnoremap H 0
nnoremap L $

silent! colorscheme wombat256mod
silent! colorscheme solarized
set background=light
set wildmenu
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gbk,gb18030,big5,latin1
set fileformat=unix
set fileformats=unix,dos,mac
set autoread

" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
