" Configuration file for vim
syntax on          " enable syntax highlighting
set modeline
set number         " enable line numbering
set relativenumber " Line numbers on left hand of screen are relative to current line
set confirm        " confirm if :q or :e entered w/out save
set textwidth=78   " Keep textwidth to 78 characters on all files
set colorcolumn=80 " vertical line at 80 chars

" Setting this on Terminal.app makes everything blink like hell.
set t_Co=256

" font config for gvim
set guifont=Ubuntu\ Mono:h10

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup       " do not keep a backup file

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  " NOTE:  I'm already doing this above
  " autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif

augroup END

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
      \ | wincmd p | diffthis
endif

" Change special characters that can be set in search patterns
set magic

" Screw you, error flash!
set noerrorbells
set novisualbell
set t_vb=

" Command timeout length in ms
set tm=500

try
  lang en_US
catch
endtry

" Replace tab with spaces
" To insert a real tab, type <C-v><Tab>
set expandtab

" # spaces to use for each step of (auto)indent
" set shiftwidth=2
set shiftwidth=4
set shiftround

" # spaces a tab uses
set tabstop=4
set softtabstop=4

" <Tab> at the start of a line inserts <shiftwidth> spaces - set by default
" set smarttab

set smartindent " Do smart indenting when starting a new line
"set wrap
set nowrap

" vim-plug
" https://github.com/junegunn/vim-plug
call plug#begin("$HOME/.config/nvim/plugged")
    "Plug 'dracula/vim'
    "Plug 'neovim/nvim-lspconfig'
    "Plug 'hrsh9th/nvim-cmp'
    Plug 'scrooloose/nerdtree'
    "Plug 'ryanoasis/vim-devicons'
    Plug 'preservim/nerdcommenter'
    Plug 'tpope/vim-surround'
    Plug 'machakann/vim-highlightedyank'
    "Plug 'romgrk/barbar.nvim'
    Plug 'preservim/tagbar'
    Plug 'preservim/vim-indent-guides'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'mhinz/vim-startify'
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" => Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Autocomplete Parentheses & Brackets
" Insert Mode:
inoremap (  ()<Left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap [ []<Left>
inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
inoremap { {}<Left>
inoremap <expr> }  strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
" Visual Mode:
vnoremap ( s()<Esc>P<Right>%
vnoremap [ s[]<Esc>P<Right>%
" vnoremap { s{}<Esc>P<Right>%

" Map ctrl-n to toggle NERDTree Plugin
nnoremap <silent> <c-n> :NERDTreeToggle<CR>

" Auto delete trailing whitespace on lines when opening or saving a file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

set wildmode=longest,full

" Make searches case-insensitive (only if searching with all lowercase)
set smartcase

" Map jj to return to Normal mode
inoremap jj <Esc>
nnoremap JJJJ <Nop>

" Remap command history to f:
nnoremap f: q:
nnoremap q: 1

" Search mappings:  These will make it so that going to the next one in a
" search will center the line it's found in.
nnoremap N Nzz
nnoremap n nzz
xnoremap N Nzz
xnoremap n nzz

" PHP short tag remapping
inoremap <??    <?php echo  ?><Left><Left><Left>
inoremap <?     <?php  ?><Left><Left><Left>

" Autocomplete menu fixing
" set dictionary-=/usr/share/dict/words dictionary+=/usr/share/dict/words
set complete-=k complete+=k
set completeopt=longest,menuone,preview

" Space will toggle folds!
nnoremap <space> za

" Use mouse
" NOTE:  For Terminal.app, a SIMBL Plugin is needed
"set mouse=nvi
"set mousemodel=popup_setpos

" Set colorscheme
"colorscheme dracula
colorscheme ir_black
let g:airline_theme = "simple"

" Comments are italic
highlight Comment cterm=italic gui='italic'

" Change the leader from \ to ,
let g:C_MapLeader  = ','
let mapleader = ","

" Set the terminal title
set title

set runtimepath+=$HOME/.config/nvim

" avoid auto-indenting pound signs
inoremap # x<C-H>#

" Always set Very Magic when searching
nnoremap / /\v
vnoremap / /\v

" OMNICOMPLETE
" Enable OmniComplete
"set completefunc=syntaxcomplete#Complete
set ofu=syntaxcomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType ruby set omnifunc=rubycomplete#Complete

" OmniCppComplete
let OmniCpp_NamespaceSearch = 2
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

" Popup menu colorscheme
highlight Pmenu ctermbg=13 guibg=LightGray
highlight PmenuSel ctermbg=7 guibg=DarkBlue guifg=White
highlight PmenuSbar ctermbg=7 guibg=DarkGray
highlight PmenuThumb guibg=Black

" cscope support
if has('cscope')
  set cscopetag cscopeverbose

  if has('quickfix')
    set cscopequickfix=s-,c-,d-,i-,t-,e-
  endif

  cnoreabbrev csa cs add
  cnoreabbrev csf cs find
  cnoreabbrev csk cs kill
  cnoreabbrev csr cs reset
  cnoreabbrev css cs show
  cnoreabbrev csh cs help

  " command -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
endif

" Set autowrite=on
" Write the contents of the file, if it has been modified, on
" each :next, :rewind, :last, :first, :previous, :stop, :suspend, :tag, :!,
" :make, CTRL-] and CTRL-^ command; and when a :buffer, CTRL-O, CTRL-I,
" '{A-Z0-9}, or `{A-Z0-9} command takes one to another file.
set autowrite

" FileType based compilation support from within vim
autocmd FileType c setlocal makeprg=gcc\ -O2\ -Wall\ -pedantic\ -o\ %<\ %
autocmd FileType ruby setlocal makeprg=ruby\ -w\ %
autocmd FileType php setlocal makeprg=php\ %
autocmd FileType python setlocal makeprg=python\ %

"""""
" c-support compilation & linking flags
" Set this when compiling >1 Object.
" Change s:ObjExtension='.o' in c.vim
" let g:C_CFlags="-Wall -O2 -c"
"
" The following settings are for when linking occurs during compilation.
" Change s:ObjExtension='' in c.vim
let g:C_CFlags="-Wall -O2"

"""""
" Added to suppress 'Press Enter' upon running make, compile, etc
function! MySuppress()
  :redraw!
  exe ":botright cwindow 7"
endfunction

autocmd QuickFixCmdPost * call MySuppress()

autocmd BufReadPost quickfix setlocal wrap | setlocal linebreak

" NOTE:  I am making omnicomplete happen either via ., ->, or ::
" Otherwise, I must use <c-x><c-o> to do it
" Supertab
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabDefaultCompletionType = "context"

" Tagbar
map <Leader>tb :TagbarToggle<CR>

set laststatus=2

" Added from https://github.com/gmarik/vimfiles/blob/master/vimrc
" Add filetype support for .markdown files from github
au BufRead,BufNewFile {*.md,*.mkd,*.markdown} set ft=markdown

" open help in vertical split if UI is wider than 156 columns
" au BufWinEnter *.txt if &ft == 'help' | wincmd H | endif
au BufWinEnter *.txt if &ft == 'help' | if &columns > 156 | wincmd H | else | wincmd J | endif | endif

" Fix some command typing mistakes
command! -bang E e<bang>
command! -bang Q q<bang>
command! -bang W w<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Wq wq<bang>
command! -bang WQ wq<bang>

" Remap Ctrl+(directions) to sane values
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Paste toggle
set pastetoggle=<F2>

" Suppress intro
set shortmess=I

" Set signature
iabbrev ssig --<cr>Matt Simpson<cr>maui@threv.net

" Clear all registers
fun! Clearregs()
  let regs = split('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ/-"', '\zs')
  for r in regs
    call setreg(r, [])
  endfor
  "let i = 0
  "while i < strlen(regs)
  "  exe "normal! q" . regs[i] . "q"
  "  let i = i+1
  "endwhile
  "unlet i
  unlet regs
endfun

command! -bar Clearregs :call Clearregs()

" Don't automatically insert comments on a new line in vim, zsh mode
au FileType vim,zsh,sh setlocal formatoptions-=r

" Persistent undo
" nvim - default is $HOME/.local/state/nvim/undo
set undofile

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" more Go syntax highlighting
let g:go_highlight_types = 1

" unhighlight search term
nnoremap <leader>h :nohlsearch<CR>

" delete to black hole register
nnoremap <leader>d "_d

" blinking bar cursor
" https://neovim.io/doc/user/faq.html
au VimEnter,VimResume * set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
    \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
    \,sm:block-blinkwait175-blinkoff150-blinkon175

" change cursor back to terminal setting on exit
" | Digit | Result                 |
" |-------|------------------------|
" | 1     | Blinking block         |
" | 2     | Steady block (default) |
" | 3     | Blinking underscore    |
" | 4     | Steady underscore      |
" | 5     | Blinking bar           |
" | 6     | Steady bar             |
au VimLeave,VimSuspend * set guicursor=a:ver25-blinkwait700-blinkoff400-blinkon250-Cursor/lCursor

