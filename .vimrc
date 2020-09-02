set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()


Plugin 'gmarik/Vundle.vim'

Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'

" Optional:
Plugin 'honza/vim-snippets'
" let Vundle manage Vundle, required

Plugin 'terryma/vim-multiple-cursors'
Plugin 'vim-scripts/DrawIt'

Plugin 'scrooloose/nerdtree'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


let mapleader="\\"


"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

tnoremap <C-J> <C-W><C-J>
tnoremap <C-K> <C-W><C-K>
tnoremap <C-H> <C-W><C-H>

" Fast buffer switch
noremap <C-Q> :bn<cr>
tnoremap <C-Q> <c-w>:bn<cr>

" Enable folding
set foldmethod=manual

" Space modes for macros and folding
noremap <F2> :call ToggleSpaceMode()<cr>
nnoremap <space> za
let g:space_mode = 0
function! ToggleSpaceMode()
    if g:space_mode == 0
        nnoremap <space> @@
        let g:space_mode = 1
        echo "Repeat Macro"
    else
        nnoremap <space> za
        let g:space_mode = 0
        echo "Toggle Fold"
    endif
endfunction

" Hex mode
noremap <F6> :call ToggleHexMode()<cr>
function! ToggleHexMode()
    if exists("b:hex_mode")
        if b:hex_mode == 0
            execute "%!xxd"
            let b:hex_mode = 1
            echo "Hex mode ON"
        else
            execute "%!xxd -r"
            let b:hex_mode = 0
            echo "Hex mode OFF"
        endif
    else
        execute "%!xxd"
        let b:hex_mode = 1
        echo "Hex mode ON"
    endif
endfunction

" Autosave folds
"autocmd BufWritePost,BufLeave,WinLeave ?* mkview
"autocmd BufWinEnter ?* silent loadview



" Autocomplete
" set autoindent
set encoding=utf-8

set hidden

let python_highlight_all=1
syntax on

" Build for everything
nmap <F7> :w<cr>: !clear; ./"%"<cr>
nmap <F8> @@

" colorscheme dracula

" Highlight extra whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Fast file search
" map ; :Buffers<CR>

" Fast save
nnoremap <c-s> :w<CR>
vmap <c-s> <Esc><c-s>gv
imap <c-s> <Esc><c-s>

" Remove trailing spaces
autocmd BufWritePre * %s/\s\+$//e

" Tweaks for browsing
let g:netrw_banner = 0        " disable annoying banner
let g:netrw_browse_split = 4  " open in prior window
let g:netrw_winsize = 25
let g:netrw_altv = 1          " open splits to the right
let g:netrw_liststyle = 3     " tree view
let g:netrw_keepdir = 0
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" Tab menu completion
set wildmenu
set wildmode=longest:full,full

" Insert line without modechange
" nnoremap <cr> O<Esc>j

" Some binds with Backspace
nnoremap <Bs> X

" Toggle Vexplore with Ctrl-O
function! ToggleVExplorer()
    if exists("t:expl_buf_num")
        let expl_win_num = bufwinnr(t:expl_buf_num)
        let cur_win_num = winnr()

        if expl_win_num != -1
            while expl_win_num != cur_win_num
                exec "wincmd w"
                let cur_win_num = winnr()
            endwhile

            let buf = winbufnr(expl_win_num)
            close
            exec "bw ".buf
        endif

        unmap <c-a>
        unlet t:expl_buf_num
    else
        exec "set nohid"
        Vexplore
        let t:expl_buf_num = bufnr("%")
        " Open file, but keep focus in Explorer
        nmap <c-a> <cr>:wincmd W<cr>
    endif
endfunction

" nmap <silent> <c-o> :call ToggleVExplorer()<CR>

" Russian language support
" set keymap=russian-jcukenwin    " русская раскладка
" set iminsert=0                  " но по-умолчанию - английская
" set imsearch=0                  " и при поиске — английская

" Change lang with Ctrl-q
" imap <C-q> <C-^>
" cmap <C-q> <C-^>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Navigate visual lines, not logical
nmap j gj
nmap k gk

" Close buffer, but keep window open
command! BD :bn|:bd#
if has("gui_running")
    nmap <a-w> :BD<cr>
    imap <a-w>  <esc>:BD<cr>
else
    nmap w :BD<cr>
    imap w <esc>:BD<cr>

endif

" Set current dir for buffer
set autochdir

" Better handle for long lines
set linebreak
set display+=lastline

" Press F4 to toggle highlighting on/off, and show current value.
noremap <F4> :set hlsearch! hlsearch?<CR>

" Press F3 to toggle highlighting on/off, and show current value.
noremap <F3> :set paste! paste?<CR>

" Higlight TODO: and FIXME:
"highlight myTODO ctermbg=green guibg=green
"match myTODO /.*\(TODO\|FIXME\):.*/

" Enable POSIX regex
nnoremap / /\v
vnoremap / /\v
cnoremap %s/ %smagic/
cnoremap \>s/ \>smagic/

" Faster mode change
set timeoutlen=1000 ttimeoutlen=100

" Better navigation in insert mode
inoremap <c-e> <c-o>de
inoremap <c-h> <c-o>b
inoremap <c-j> <c-o>gj
inoremap <c-k> <c-o>gk
inoremap <c-l> <c-o>w

" Wrap moves
set whichwrap+=<,>,h,l,[,]

autocmd BufNewFile,BufRead *.hla :set filetype=asm
set bs=2

set tags=tags;/
" command Ctags !ctags -R --c++-kinds=+p --fields=+iaS --extra=+q $PWD
nnoremap <C-]> g<C-]>

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

map <c-d> <esc>:sh<cr>


set colorcolumn=80
highlight ColorColumn ctermbg=gray

for [key, code] in [["<F2>", "\eOQ"],
                   \["<F3>", "\eOR"],
                   \["<F4>", "\eOS"]]
    execute "set" key."=".code
endfor

set noswapfile
set incsearch

" Tabs as spaces
set expandtab softtabstop=4 tabstop=4 shiftwidth=4

if has("gui_running")
    map <a-q> :NERDTreeToggle<CR>
else
    map q :NERDTreeToggle<CR>
endif

command -nargs=1 Find :!clear;grep -In <args> * 2>/dev/null
set mouse=a

set ignorecase
set smartcase


" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif


set ruler

set lazyredraw

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> <leader>n :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> <leader>p :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

nnoremap <silent> # *
nnoremap <silent> * #

map 0 ^

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction


" Quickly open a buffer for scribble
map <leader>q :e ~/buffer.md<cr>

vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

nnoremap <leader>~ :e ~/.vimrc<cr>

vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P

nmap <Leader>[ gg
vmap <Leader>[ gg
nmap <Leader>] G
vmap <Leader>] G

nnoremap <Leader>a ggVG

xnoremap <leader>p :w !python<cr>

nmap <leader>x :!chmod +x %; fg<cr>
nnoremap <c-u> <c-o>u
set shellcmdflag=-ic
