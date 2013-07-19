" Configuration file for vim
set nocompatible  " Use Vim defaults instead of 100% vi compatibility
set modelines=0   " Don't check any lines for set commands
set backspace=2   " more powerful backspacing
set ruler         " show the cursor position all the time
set number        " enable line numbering
syntax on         " enable syntax highlighting
set confirm       " confirm if :q or :e entered w/out save

" Setting this on Terminal.app makes everything blink like hell.
set t_Co=256

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Set hlsearch on - highlights search terms
set hlsearch

set nobackup      " do not keep a backup file
set history=1000  " keep 1000 lines of command line history
set showcmd       " display incomplete commands
set incsearch     " do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" Keep textwidth to 78 characters on all files
set textwidth=78

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

set encoding=utf8
try
  lang en_US
catch
endtry

" Replace tab with spaces
" To insert a real tab, type <C-v><Tab>
set expandtab

" # spaces to use for each step of (auto)indent
set shiftwidth=2

" # spaces a tab uses
set tabstop=2

" <Tab> at the start of a line inserts <shiftwidth> spaces
set smarttab

set si " Do smart indenting when starting a new line
" This is gvim - always use a scrollbar and never wrap lines
set nowrap guioptions+=b

" Pathogen
" Greatly eased Vim plugin management
call pathogen#infect()

" Auto-reload this file when saving changes
" Breaks vim-powerline after first save
au! BufWritePost $MYVIMRC source %

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Visual Mode:  Wrap the selection in:
" &1:  Parentheses
" &2:  Square Brackets
" &3:  Curly Braces
" &4:  Indented curly brace block
" &5:  Prepend each line with ruby comments, aka '# '
" &$ or &e:  Double Quotes
" &q:  Single Quotes
vnoremap &1 <esc>`>a)<esc>`<i(<esc>
vnoremap &2 <esc>`>a]<esc>`<i[<esc>
vnoremap &3 <esc>`>a}<esc>`<i{<esc>
vnoremap &4 ><esc>`>o<BS>}<esc>`<O{<esc>
vnoremap &5 :s/^/# /<CR> :noh<CR>
vnoremap &$ <esc>`>a"<esc>`<i"<esc>
vnoremap &q <esc>`>a'<esc>`<i'<esc>
vnoremap &e <esc>`>a"<esc>`<i"<esc>

" Insert Mode:  Create the following, and begin insertion in the middle of:
" &1:  Parentheses
" &2:  Square Brackets
" &3:  Curly Braces
" &4:  Indented curly brace block
" &e:  Double Quotes
" &q:  Single Quotes
" &t:  Diagonal Brackets
inoremap &1 ()<esc>i
inoremap &2 []<esc>i
inoremap &3 {}<esc>i
inoremap &4 {<esc>o}<esc>O
inoremap &q ''<esc>i
inoremap &e ""<esc>i
inoremap &t <><esc>i

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
nmap <silent> <c-n> :NERDTreeToggle<CR>

" Auto delete trailing whitespace on lines when opening or saving a file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Cool tab completion stuff
" command-line completion operates in enhanced mode
set wildmenu
" Complete till longest common string, and start wildmenu
set wildmode=list:longest,full

" Make searches case-insensitive (only if searching with all lowercase)
set ignorecase
set smartcase

" Map jj to return to Normal mode
inoremap jj <Esc>
nnoremap JJJJ <Nop>

" Remap command history to f:
nnoremap f: q:
nnoremap q: 1
" Nifty Tab stuff
" Next Tab
nnoremap <silent> <c-h> :tabnext<CR>
" Previous Tab
nnoremap <silent> <c-l> :tabprevious<CR>
" New Tab
nnoremap <silent> <c-t> :tabnew<CR>

" Search mappings:  These will make it so that going to the next one in a
" search will center the line it's found in.
nmap N Nzz
nmap n nzz
xmap N Nzz
xmap n nzz

" PHP short tag remapping
inoremap <??    <?php echo  ?><Left><Left><Left>
inoremap <?     <?php  ?><Left><Left><Left>

" Autocomplete menu fixing
" set dictionary-=/usr/share/dict/words dictionary+=/usr/share/dict/words
set complete-=k complete+=k
set completeopt=longest,menuone,preview
" inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
" inoremap <expr> <c-n> pumvisible() ? "\<lt>c-n>" : "\<lt>c-n>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>"
" inoremap <expr> <m-;> pumvisible() ? "\<lt>c-n>" : "\<lt>c-x>\<lt>c-o>\<lt>c-n>\<lt>c-p>\<lt>c-r>=pumvisible() ? \"\\<lt>down>\" : \"\"\<lt>cr>"

" Space will toggle folds!
nnoremap <space> za

" Use mouse
" NOTE:  For Terminal.app, a SIMBL Plugin is needed
set mouse=a
set ttymouse=xterm

" Set colorscheme
colorscheme ir_black

" Yank text to the OS X clipboard
set clipboard=unnamed
noremap <leader>y "*y
noremap <leader>yy "*Y

" Preserve indentation while pasting text from the OS X clipboard
noremap <leader>p :set paste<CR>:put  *<CR>:set nopaste<CR>

" The current buffer can be put to the background without writing to disk.
" When a background buffer becomes current again, marks and undo-history are
" remembered.
set hidden

" Change the leader from \ to ,
let g:C_MapLeader  = ','
let mapleader = ","

" Set the terminal title
set title

" The % key will switch between opening and closing brackets.
" By sourcing matchit.vim, it can also switch among e.g. if/elsif/else/end, between opening and closing XML tags, and more.
runtime macros/matchit.vim

set runtimepath+=$HOME/.vim

" Line numbers on left hand of screen are relative to current line
set relativenumber

" avoid auto-indenting pound signs
inoremap # x<C-H>#

" Always set Very Magic when searching
nnoremap / /\v
vnoremap / /\v

"" OMNICOMPLETE
"" Enable OmniComplete
set ofu=syntaxcomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete

" configure tags - add additional tags here
set tags+=~/.vim/tags/c
set tags+=~/.vim/tags/cpp
setlocal dictionary+=~/.vim/tags/c
setlocal dictionary+=~/.vim/tags/cpp
setlocal complete-=k complete+=k
" build tags of your own project with ,tags
map <Leader>tags :!ctags -R --sort=yes --c++-kinds=+pl --fields=+iaS --extra=+q .<CR>
set tags=./tags;/

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
" This is overwritten by ide.vim
" I disabled it, though.
set completeopt=menuone,menu,preview

" Popup menu colorscheme
highlight Pmenu ctermbg=13 guibg=LightGray
highlight PmenuSel ctermbg=7 guibg=DarkBlue guifg=White
highlight PmenuSbar ctermbg=7 guibg=DarkGray
highlight PmenuThumb guibg=Black

" Set GUI font
" set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
set guifont=Ubuntu\ Mono\ for\ Powerline\ 12
set lines=45 columns=100

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

"""""
" Preview current file in default application
" Useful for previewing HTML pages
" Mac OS X specific
" Mapped to <Leader>pre
map <Leader>pre :!open %<CR><CR>

" Underline current word
" function! UnderlineCurrentWord()
"   let wordlen = strlen(expand("<cword>"))
"   let currft = &filetype
"   exe ":normal WB"
"   let currcol = col(".")
"   let prespace = repeat (" ", currcol - 1)
"   let understring = repeat("=", wordlen)
"   exe "setl noai nosi inde="
"   exe "setf none"
"   exe "normal o" . prespace . understring
"   exe "setl ai si inde=GetVimIndent()"
"   exe "setf " . currft
" endfunction
"
" nnoremap <Leader>uw :call UnderlineCurrentWord()<CR>

" Search google for word under the cursor
" First line:  Mac OS X specific
" Second line:  Ubuntu + Chrome specific
" Mapped to <Leader>?
function! NSearchGoogleForWord()
  let s:wordUnderCursor = expand("<cword>")
  " let s:cmd = "silent !open 'http://www.google.com/search\?\q='" . s:wordUnderCursor
  let s:cmd = "silent !chromium-browser 'http://www.google.com/search\?\q='" . s:wordUnderCursor
  execute s:cmd
endfunction

nnoremap <Leader>? :call NSearchGoogleForWord()<CR><CR>

" Git stuff
function! Typicalgit()
  exe ":!git add ."
  let s:gitmessage = input('Enter commit message:  ')
  exe ':!git commit -am "' . s:gitmessage . '"'
  exe ":!git push"
endfunction
map <Leader>git :call Typicalgit()<CR>

" NOTE:  I am making omnicomplete happen either via ., ->, or ::
" Otherwise, I must use <c-x><c-o> to do it
" Supertab
" let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabDefaultCompletionType = "context"

" Tagbar
map <Leader>tb :TagbarToggle<CR>

" Golang support
set rtp+=$GOROOT/misc/vim

" Nice statusbar
" Thanks to Enrique Santos (https://github.com/blueminder/)
" set laststatus=2
" set statusline=\ "
" set statusline+=%f\ " file name
" set statusline+=[
" set statusline+=%{strlen(&ft)?&ft:'none'}, " filetype
" set statusline+=%{&fileformat}] " file format
" set statusline+=%h%1*%m%r%w%0* " flag
" set statusline+=%= " right align
" set statusline+=%-14.(%l,%c%V%)\ %<%P " offset

set laststatus=2

" Added from https://github.com/gmarik/vimfiles/blob/master/vimrc
" Add filetype support for .markdown files from github
au BufRead,BufNewFile {*.md,*.mkd,*.markdown} set ft=markdown

" open help in vertical split if UI is wider than 156 columns
" au BufWinEnter *.txt if &ft == 'help' | wincmd H | endif
au BufWinEnter *.txt if &ft == 'help' | if &columns > 156 | wincmd H | else | wincmd J | endif | endif

" Start indent-guides on startup
" let g:indent_guides_enable_on_vim_startup = 1

" textile.vim support
" Debian
" let g:TextileOS="Linux"
" let g:TextileBrowser="/usr/bin/chromium-browser"
" OS X
let g:TextileBrowser="Google Chrome"

" gundo support
map <Leader>gun :GundoToggle<CR>

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

" Requires patched fonts for Powerline; renders nifty font images
let g:Powerline_symbols = 'fancy'

" Stops Command-T from searching VMWare host directory
set wildignore=host/**

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
iabbrev ssig --<cr>Matt Simpson<cr>msimpson.cmpe04@gtalumni.org

" Highlight current line
set cul

" Disable viminfo
" set viminfo=

"
" Smart in-line manpages with 'K' in command mode
" Thanks to users.softlab.ntua.gr/~ttsiod/myvim.html
"
fun! ReadMan()
  " Assign current word under cursor to a script variable:
  let s:man_word = expand('<cword>')
  " Open a new window:
  :exe ":wincmd n"
  " Read in the manpage for man_word (col -b is for formatting):
  :exe ":r!man " . s:man_word . " | col -b"
  " Goto first line...
  :exe ":goto"
  " and delete it:
  :exe ":delete"
  " finally set file type to 'man':
  :exe ":set filetype=man"
  " lines set to 20
  :resize 20
endfun
" Map the K key to the ReadMan function:
noremap K :call ReadMan()<CR>

" Clear all registers
fun! Clearregs()
  let regs = '0123456789abcdefghijklmnopqrstuvwxyz'
  let i = 0
  while i < strlen(regs)
    exe "normal! q" . regs[i] . "q"
    let i = i+1
  endwhile
  unlet i
  unlet regs
endfun

command! -bar Clearregs :call Clearregs()

" Format a long line of JSON in Visual Mode
" noremap <Leader>j !python -m json.tool<CR>:setf json<CR>

" Don't automatically insert comments on a new line in vim, zsh mode
au FileType vim,zsh,sh setlocal formatoptions-=r
