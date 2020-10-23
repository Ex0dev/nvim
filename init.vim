" vim:foldmethod=marker:foldlevel=0

" Vim Settings {{{
behave mswin
set shiftwidth=4
set softtabstop=4
set expandtab
set nu
" set cursorline
filetype plugin indent on
set wildmenu
set lazyredraw
set showmatch
set backspace=2

set incsearch
set hlsearch

set nocompatible
set modelines=1
set modeline
set foldenable
set foldlevelstart=10
set foldnestmax=10
" }}}

" Plugin Install {{{
call plug#begin('~/.config/nvim/plugged')

" Color Schemes
Plug 'chriskempson/base16-vim'
Plug 'flazz/vim-colorschemes'

" Airline Stuff
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Utilities
Plug 'sjl/gundo.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'mileszs/ack.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'wokalski/autocomplete-flow'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neoinclude.vim'
Plug 'tpope/vim-repeat'
Plug 'w0rp/ale'
Plug 'dbeniamine/cheat.sh-vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'tpope/vim-fugitive'

" Languages
Plug 'rust-lang/rust.vim'
Plug 'Omnisharp/omnisharp-vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'leshill/vim-json'

call plug#end()
" }}}

" Plugin Settings {{{
let g:python3_host_prog = 'python3'
let g:ackprg='ag --vimgrep'
" let g:tagbar_ctags_bin='C:\Vim\ctags\ctags.exe'

" Javascript Settings {{{
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0

let g:ale_completion_enabled = 1
let g:ale_linters_explicit = 1
let g:ale_fixers = {
\   'javascript': ['eslint', 'flow']
\}
" }}}

" Deoplete Config {{{
let g:deoplete#enable_on_startup=1
" set completeopt-=preview
let g:deoplete#sources#clang#libclang_path='/usr/lib/x86_64-linux-gnu/libclang-11.so.1'
let g:deoplete#sources#clang#clang_header='/usr/lib/clang/11/include'
" }}}

" NERDTree Settings {{{
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
" }}}

" CtrlP Settings {{{
let g:ctrlp_match_window='bottom,order:ttb'
let g:ctrlp_switch_buffer=0
let g:ctrlp_working_path_mode=0
let g:ctrlp_user_command='ag %s -l --nocolor --hidden -g ""'
" }}}

" Airline Settings {{{
set encoding=utf-8
let g:airline_powerline_fonts = 1
let g:airline_theme = 'base16_atelierdune'
" colorscheme base16-atelier-dune

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#ale#enabled = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
" }}}

" AsyncRun Config {{{
let g:airline_section_error = airline#section#create_right(['%{g:asyncrun_status}'])
nnoremap <F9> :call asyncrun#quickfix_toggle(8)<cr>
augroup QuickfixConfig
    autocmd QuickFixCmdPost * call asyncrun#quickfix_toggle(8, 1)
augroup END
" }}}

" Omnisharp Config {{{
let g:Omnisharp_server_path = 'C:\Development\C#\Omnisharp\Omnisharp.exe'
let g:syntastic_cs_checkers = ['code_checker']
let g:Omnisharp_selector_ui = 'ctrlp'

augroup omnisharp
    autocmd!

    autocmd FileType cs nnoremap <buffer> <leader>b :wa!<cr>:OmniSharpBuildAsync<cr>
    autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck
    autocmd BufWritePost *.cs call OmniSharp#AddToProject()
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<cr>
    autocmd FileType cs nnoremap <buffer> <leader>fi :OmniSharpFindImplementations<cr>
    autocmd FileType cs nnoremap <buffer> <leader>fs :OmniSharpFindSymbol<cr>
    autocmd FileType cs nnoremap <buffer> <leader>fu :OmniSharpFindUsages<cr>
    autocmd FileType cs nnoremap <buffer> <leader>fm :OmniSharpFindMembers<cr>
    autocmd FileType cs nnoremap <buffer> <leader>x :OmniSharpFixIssue<cr>
    autocmd FileType cs nnoremap <buffer> <leader>fs :OmniSharpFixUsings<cr>
    autocmd FileType cs nnoremap <buffer> <leader>tt :OmniSharpTypeLookup<cr>
    autocmd FileType cs nnoremap <buffer> <leader>dc :OmniSharpDocumentation<cr>
    autocmd FileType cs nnoremap <buffer> <leader><C-k> :OmniSharpNavigateUp<cr>
    autocmd FileType cs nnoremap <buffer> <leader><C-k> :OmniSharpNavigateDown<cr>
augroup END

nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
xnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>
nnoremap <leader>nm :OmniSharpRename<cr>
nnoremap <f2> :OmniSharpRename<cr>
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")
nnoremap <leader>rl :OmniSharpReloadSolution<cr>
nnoremap <leader>cf :OmniSharpCodeFormat<cr>
nnoremap <leader>tp :OmniSharpAddToProject<cr>
nnoremap <leader>ss :OmniSharpStartServer<cr>
nnoremap <leader>sp :OmniSharpStopServer<cr>
nnoremap <leader>th :OmniSharpHighlightTypes<cr>
" }}}
" }}}

" Key Mappings {{{
let mapleader="-"

nnoremap <leader><space> :nohlsearch<cr>
nnoremap <space> za
nnoremap gV `[v`]
nnoremap / /\v

nnoremap B ^
nnoremap E $
nnoremap $ <nop>
nnoremap ^ <nop>

nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

nnoremap <leader>ev :vs $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>s :mksession<cr>

inoremap jk <esc>
inoremap <esc> <nop>

nnoremap <leader>u :GundoToggle<cr>
nnoremap <leader>a :Ack
nnoremap <F10> :NERDTreeToggle<cr>
nnoremap <F8> :TagbarToggle<cr>
" }}}

" Functions {{{
" Toggle between number and relativenumber
function! ToggleNumber()
    if(&relativenumber==1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc
" }}}

" Autocmd Groups {{{
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80\ -T4
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
augroup END
" }}}
