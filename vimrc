" Header and Notes {
"
"   vim: set foldenable foldmarker={,} foldlevel=0 nospell:
"
"   vi/vim: dot.vimrc
"   mvf: ferreira.mv[ at ]gmail.com
"   based on http://vi-improved.org/vimrc.php
"
" }

" PATHogen {
    "filetype off
    " Use pathogen to easily modify the runtime path to include all
    " plugins under the ~/.vim/bundle directory
    "call pathogen#helptags()
    "call pathogen#runtime_append_all_bundles()
" }

" General {
    set nocompatible

    syntax on
    filetype plugin indent on

    " vi compatible options {
    set cpoptions=aABcefFmqs
    "             |||||||||+-- Set buffer options when entering the buffer
    "             ||||||||+-- When joining lines, leave the cursor between joined lines
    "             |||||||+-- When a new match is created (showmatch) pause for .5
    "             ||||||+-- :write command updates current file name
    "             |||||+-- :read command updates current file name
    "             ||||+-- Automatically add <CR> to the last line when using :@r
    "             |||+-- Searching continues at the end of the match at the cursor position
    "             ||+-- A backslash has no special meaning in mappings
    "             |+-- :write updates alternative file name
    "             +-- :read updates alternative file name
    set cpoptions+=#
    "              |
    "              +-- A count before "D", "o" and "O" has no effect.
    set cpoptions-=n
    "              +-- column for 'number' does not show wrapped text
    " }

    set nobackup                    " [donot] make backup files
    set backupdir=/tmp              " where to put backup files
    set noswapfile                  " do not use swap files (brave mode on!)
    set directory=/tmp              " directory to place swap files in
    set clipboard+=unnamed          " yy, D, p: share OS clipboard
    set encoding=utf-8 nobomb       " BOM often causes trouble
    set fileformats=unix,dos,mac    " support all three, in this order
    set history=300                 " history size
    set modeline                    " modeline on
    set paste                       " terminal vim: does not detect paste from typing
    set timeoutlen=5000             " time in ms to complete a mapped key combination
    set writeany                    " write on readonly files

"    set undofile                    " keep a permanent undofile (vide :wundo/:rundo)
"    set undodir=/tmp

    set linebreak                   " when wrapping, uses chars listed in breakt
    set breakat=\ ^I!@*-+;:,./?     " when wrapping, break at these characters
    set showbreak=…                 " what to show at the start of a wrapped line

    set iskeyword+=48-57,192-255
    set iskeyword+=_,$,@,%,#        " none of these are word dividers

    set showcmd                 " show command line
    set wildmenu                " turn on command line completion wild style
    set wildmode=list:longest   " turn on wild mode huge list
    set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png,*~,*.lo
                                " ignore these list file extensions

    set grepprg=ack
    set grepformat=%f:%l:%m

    " what to save via :mksession {
    set sessionoptions=blank,buffers,curdir,folds,globals,options,resize,tabpages,winsize
    "                  |     |       |      |     |       |       |      |        +-- size of windows
    "                  |     |       |      |     |       |       |      +-- tabs opened
    "                  |     |       |      |     |       |       +- size of line/columns
    "                  |     |       |      |     |       +-- options set
    "                  |     |       |      |     +-- globals set
    "                  |     |       |      +-- state of folds
    "                  |     |       +-- current dir
    "                  |     +-- hidden/unloaded buffers
    "                  +-- empty windows
    set viminfo='100,f1,<500,:50,@50,/50,h,%
    "           |    |  |    |   |   |   | +-- save/restore buffer list
    "           |    |  |    |   |   |   +-- disable hlsearch
    "           |    |  |    |   |   +-- search-line history
    "           |    |  |    |   +-- input-line history
    "           |    |  |    +-- command line history
    "           |    |  +-- lines saved by each register
    "           |    +-- store file marks
    "           +-- number of files for which marks are kept
    set viminfo='100,f1,<500,:50,@50,/50,h
    " }
" }

" Mappings {

    " http://items.sjbach.com/319/configuring-vim-right
    " scroll viewpoint by 'n' lines
    nnoremap <C-j> 5<C-e>
    nnoremap <C-k> 5<C-y>

    " Avoid accidental hits of <F1> while aiming for <Esc>
    map! <F1> <Esc>
    " inoremap <F1> <ESC>
    " nnoremap <F1> <ESC>
    " vnoremap <F1> <ESC>


    " Increase/Decrease: <C-A>/<C-X>
    " Omni completion: <C-n>
    " Complete whole filenames/lines with a quicker shortcut key in insert mode
    imap <C-f> <C-x><C-f>
    imap <C-l> <C-x><C-l>


    " Tab moving

    " space / shift-space scroll in normal mode
"   noremap <S-space> <C-b>
"   noremap <space>   <C-f>

    " Quick yanking to the end of the line
    nmap Y y$

    " Yank/paste to the OS clipboard with ,y and ,p
    nmap <leader>y "+y
    nmap <leader>Y "+yy
    nmap <leader>p "+p
    nmap <leader>P "+P

    " Quickly get out of insert mode without your fingers having to leave the
    " home row (either use 'jj' or 'jk')
    inoremap jj <Esc>
    inoremap jk <Esc>

    " Quick alignment of text
    nmap <leader>al :left<CR>
    nmap <leader>ar :right<CR>
    nmap <leader>ac :center<CR>

    " NERDTree Stuff
    silent! nmap <silent> <Leader>p :NERDTreeToggle<CR>
    nnoremap <silent> <C-f> :call FindInNERDTree()<CR>

    let mapleader=","

    " edit files {
    nmap <leader>ev :e $MYVIMRC<CR>
    nmap <leader>eg :e $MYGVIMRC<CR>

    nmap <leader>sv :source $MYVIMRC<CR>
    nmap <leader>sg :source $MYGVIMRC<CR>
    " }

    " fold {
    nmap <leader>fc :foldclose<CR>
    nmap <leader>fo :foldopen<CR>

    nmap <leader>f0 :set foldlevel=0<CR>
    nmap <leader>f1 :set foldlevel=1<CR>
    nmap <leader>f2 :set foldlevel=2<CR>
    nmap <leader>f3 :set foldlevel=3<CR>
    nmap <leader>f9 :set foldlevel=9<CR>
    " }

    " Identation {
      " Normal mode:
    nmap <D-[> <<
    nmap <D-]> >>
      " Visual mode - gv: keeps selection
    vmap <D-[> <gv
    vmap <D-]> >gv
    " }

    " Shortcuts {
    nmap <leader>q  :q <CR>
    nmap <leader>q1 :q!<CR>
    nmap <leader>w  :w <CR>
    nmap <leader>wa :wa<CR>
    nmap <leader>wq :wq!<CR>
    nmap <leader>ww :w !sudo tee % >/dev/null
    nmap <leader>sa :browse confirm saveas<CR>

"   cmap w!! w !sudo tee % >/dev/null

    nmap <leader>mk :marks<CR>

    " CTRL-K:  delete so the end of line
    map  <C-K> D
    " DOES NOT WORK
    " imap <C-K> <ESC>D

    " CTRL-S for saving, also in Insert mode
    "noremap  <C-S>        :update<CR>
    "vnoremap <C-S>    <C-C>:update<CR>
    "inoremap <C-S>    <C-O>:update<CR>

    " CTRL-A is Select all
    "noremap <C-A> gggH<C-O>G
    "inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
    "cnoremap <C-A> <C-C>gggH<C-O>G
    "onoremap <C-A> <C-C>gggH<C-O>G
    "snoremap <C-A> <C-C>gggH<C-O>G
    "xnoremap <C-A> <C-C>ggVG


    nmap <leader>r  :Rehash<CR>
    nmap <leader>rg :Rehashg<CR>

    " linenumber on/off
    nmap <leader>nu  :set invnumber<CR>
    " relativenumber on/off
    nmap <leader>rnu :set invrnu   <CR>
    " set cursorcolumn/nocursorcolumn
    nmap <leader>cuc :set invcuc   <CR>
    " Highlight search on/off
    nmap <leader>h :set invhls<CR>
    nmap <leader>/ :set invhls<CR>
    " list invisibles on/off
    nmap <leader>l :set invlist  <CR>
     " }
     

    " Misc {
    " K = inverted J: join line up
    map K ddpkJ

    " row up/down if wrap active
    " http://nvie.com/posts/how-i-boosted-my-vim/
    nnoremap j gj
    nnoremap k gk

    " Underline header
    map <leader>= yypVr=
    map <leader>- yypVr-

    " Thanks to Steve Losh for this liberating tip
    " See http://stevelosh.com/blog/2010/09/coming-home-to-vim
    " Perl Regex
    nnoremap / /\v
    vnoremap / /\v
    " <TAB> for matching brackets
    nnoremap <tab> %
    vnoremap <tab> %

    nmap <C-Right> :tabnext<CR>
    nmap <C-t> :tabnew<CR>
    nmap <C-Left> :tabprevious<CR>

    " Creating underline/overline headings for markup languages
    " Inspired by http://sphinx.pocoo.org/rest.html#sections
    "nnoremap <leader>1 yyPVr=jyypVr=
    "nnoremap <leader>2 yyPVr*jyypVr*
    "nnoremap <leader>3 yypVr=
    "nnoremap <leader>4 yypVr-
    "nnoremap <leader>5 yypVr^
    "nnoremap <leader>6 yypVr"


   " http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
    nmap <leader>cd :cd <C-R>=expand("%:p:h")<CR>

     " Remove trailing spaces
    nmap <leader>remove :%s/\s*$//g   <CR>

    " dos2,nix
    nmap <leader>unix   :%s/\r$//     <CR>

   " rot all text
    nmap <leader>rot ggg?G

    " Command line map
    cmap %/ <C-R>

    " Command mode: path of the currently edited file
    cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

   " http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
    nmap <leader>cd :cd <C-R>=expand("%:p:h")<CR>

    " }


" }


" Commands {

    command! W  :w
    command! WW :browse confirm saveas
    command! WQ :wq
    command! Q  :q

    command! Rehash     source $MYVIMRC
    command! Rehashg    source $MYGVIMRC
    command! Helptags   helptags ~/.vim/doc

    command! Color      echo g:colors_name

    " start/stop sharing OS clipboard
    command! Clipon     set clipboard+=unnamed
    command! Clipoff    set clipboard-=unnamed

" }

" Vim-UI {
    set title           " set window name as titlestring
    set titlestring=%F\ [%R%H%M%w]\ %{v:servername}

    " set ruler           " show cursor line/col position
    " set rulerformat=[col:%c\ lin:%-7.(%l/%L%)]\ %P

    set number              " linenumber
    set numberwidth=5       " linenumber width
    "et relativenumber      " relative number

    set cursorline          " horizontal highlight
    set cursorcolumn        " vertical highlight

    set virtualedit=block   " allow moving past end of line in block selection mode

    set nostartofline       " keep cursor in same column where moving up/down
    set scrolloff=3         " keep 3 lines scrolling up/down
    set sidescrolloff=10    " keep 10 lines scrolling left/right

    set report=0            " report all changes via ':' commands

    set winaltkeys=no       " wak: no ALT keys for menus

    set incsearch           " Highlight dynamically as they are typed.
    set nohlsearch          " Highlight search terms: off on start

    set errorbells          " Bells error messagens
    set visualbell          " no sound bells

    set nolist              " [no]list invisible chars
    set listchars=tab:▸\ ,trail:·,eol:¬,extends:>,precedes:<
    "             |       |       |     |         +-- line befor left margin: <
    "             |       |       |     +-- line beyond right margin: >
    "             |       |       +-- EOF: _
    "             |       +-- trailing spaces: ....
    "             +-- each tab: >----

    "et formatoptions=rq                    " default: tcq vide 'help fo-table'
    set formatoptions=tcqrn
    "                 ||||+- recognize numbered lists
    "                 |||+-- insert comment leader after <Enter> in Insert mode
    "                 ||+--- allow formatting using gq
    "                 |+---- auto-wrap comments
    "                 +----- auto-wrap text
" }

" GUI Settings {

    set bg=dark

    map <leader>c1 :colorscheme ir_black3<CR>
    map <leader>c2 :colorscheme torte    <CR>
    map <leader>c3 :colorscheme desert   <CR>
    map <leader>c0 :echo g:colors_name   <CR>

    " Terminal vim theme
    colorscheme torte

    " Gvim theme
    if has("gui_running")
        if filereadable(expand("~/.vim/colors/ir_black3.vim"))
        colorscheme ir_black3
        endif

        set cursorcolumn
        set mouse=a
        set mousehide

        set guiheadroom=5       " nr of pixels subtracter from screen to fit GUI
        set guifont="Monaco 10"
        set tabpagemax=100      " tpm: max nro of tab windows
        set gtl=%t gtt=%F       " guitablabel/guitabtooltip

        "set colorcolumn=+1,+2,+3
        set columns=178
        set lines=44
        "set transp=4


        set browsedir=buffer    " open filebrowser on directory of curent buffer

    endif

    " Terminal has 256 colors
    " if &t_Co >= 256 || has("gui_running")
    "     colorscheme mustang
    " endif

    " Terminal has colors
    " if &t_Co > 2 || has("gui_running")
    "     syntax on
    " endif

" }

" Buffers {
    set hidden                  " hide buffer instead of closing
    "et nohidden                " close buffer

    nmap <leader>ls :ls<CR>

" }

" Windows {

    set splitbelow          " sb: split new window below current window
    set splitright          " spr: split new window to the right
    set noequalalways       " ea: resize all windows to same size to fit a new one

    nmap <leader>s  :split<CR>
    nmap <leader>v  :vsplit<CR>
    nmap <leader>o  :only <CR>

    nmap <leader>sb  :set scrollbind<CR>
    nmap <leader>nsb :set noscrollbind<CR>

    map <C-j> <C-W>j
    map <C-k> <C-W>k
    map <C-h> <C-W>h
    map <C-l> <C-W>l

    map <down>  <C-W>j
    map <up>    <C-W>k
    map <left>  <C-W>h
    map <right> <C-W>l

    " }

" Windows Tabs {
    " tab: D  : command key
    "      D-S: command+shift key
    "map <D-S-]> gt
    "map <D-S-[> gT

    map <leader>tb :tabs<CR>
    map <leader>tf :tabfirst<CR>
    map <leader>tl :tablast<CR>
    map <leader>to :tabonly<CR>

" }

" Status Line {
    " My status line
    " --------------
     set laststatus=2   " always show statusline

     set statusline =\ %f\                          " filename
"    set statusline+=%h%m%r                         " flags
     set statusline+=[
     set statusline+=%n:                            " buffer number
     set statusline+=%{strlen(&ft)?&ft:'none'}      " filetype
"    set statusline+=,%{&encoding}                  " encoding
"    set statusline+=,%{&fileformat}                " file format
     set statusline+=]
"    set statusline+=%0                             " break
"    set statusline+=asc:[%3.(%b%)\ %3.(x%B%)]      " current char (ga)
     if filereadable(expand("~/.vim/plugin/fugitive.vim"))
         set statusline+=\ %{fugitive#statusline()}
     endif
"    if filereadable(expand("~/.vim/plugin/taglist.vim"))
"        set statusline+=%(tag:[%{Tlist_Get_Tagname_By_Line()}]%)
"    endif
     set statusline+=\ [col:%2.(%c%)\ lin:%-7.(%l/%L%)]\ %P
"    if filereadable(expand("~/.vim/plugin/vimbuddy.vim"))
"       set statusline+=\ %{VimBuddy()} " vim buddy
"    endif
"   if has("perl")
"       set statusline+=\ perl
"   endif
"   if has("ruby")
"       set statusline+=\ ruby
"   endif

" }

" Coding Rules {

    set completeopt=menu,preview,longest    " <C-N>/acp: completion popup menu options

    set gdefault            " global search/replace by default

    set showmatch           " show matching brackets
    set matchtime=5         " ms blinking showmatch

    set ignorecase          " case insensitive
    set infercase           " if there are caps adjust auto-completion
    set smartcase           " if there are caps go insensitive

    " set ts=4 sts=4 sw=4 et   sta   nolist - spaces
    " set ts=8 sts=0 sw=8 noet nosta list   - tabs
    set tabstop=4           " real tabs will show 8 spaces
    set softtabstop=4       " how many spaces in a tabstop
    set shiftwidth=4        " sw: indent size
    set expandtab           " no tabs - space in place of tabstops
    set smarttab            " sta: space in place of tabs in a new line

    set autoindent          " ai: pre-req for si
    set copyindent          " ci: copy same character used in previous indent line
    set smartindent         " si: on
    set shiftround          " round indent to shiftwidth

    set backspace=indent,eol,start      " make backspace a more flexible

    set nrformats=alpha,octal,hex   " C-A/C-X: increment/decrement
    
    au  FileType ruby setl sw=2 sts=2 et

    " wrap {
    set nowrap sidescroll=1         " [no] wrap long lines
    "et whichwrap=b,s,h,l,<,>,~,[,] " everything wraps
    "             | | | | | | | | |
    "             | | | | | | | | +-- "]" Insert and Replace
    "             | | | | | | | +-- "[" Insert and Replace
    "             | | | | | | +-- "~" Normal
    "             | | | | | +-- <Right> Normal and Visual
    "             | | | | +-- <Left> Normal and Visual
    "             | | | +-- "l" Normal and Visual (not recommended)
    "             | | +-- "h" Normal and Visual (not recommended)
    "             | +-- <Space> Normal and Visual
    "             +-- <BS> Normal and Visual
    " }

" }

" Folding {
    set foldenable              " Turn on folding
    set foldmarker={,}          " Fold C style code (only use this as default
                                " if you use a high foldlevel)
    set foldmethod=marker       " Fold on the marker
    set foldlevel=100           " Don't autofold anything (but I can still fold manually)
    set foldopen=block,hor,mark,percent,quickfix,tag " what movements open folds

    " Fold HTML tags
    nnoremap <leader>ft Vatzf

    function! SimpleFoldText() " {
        return getline(v:foldstart).' '
    endfunction " }

    set foldtext=SimpleFoldText() " Custom fold text function (cleaner than default)

" }

" FileTypes {

    " all files {
        " Strip white space
        " autocmd BufWritePre *  :%s/\s\+$//e

        " Come back to last position
        autocmd BufReadPost *   if line("'\"") > 0
                              \ && line("'\"") <= line("$") |
                              \    exe "normal! g'\""       |
                              \ endif
    " }

    " Text {
        autocmd BufNewFile,BufRead *.txt set tw=78 cc=+1 ts=4 sts=4 sw=4 et wrap
        autocmd BufNewFile,BufRead *.txt set fo+=t2n colorscheme torte
        "                                        ||+- recognize numbered lists
        "                                        |+-- indent based on 2o. paragraph
        "                                        +--- auto-wrap text
    " }

    " LogFiles {
        " goto end of file
        autocmd BufReadPost  *.log      normal G
    " }

    " SQL*Plus {
        autocmd BufNewFile,BufRead *sql       set filetype=plsql
        " http://www.oracledba.ru/notes_vim_en.html
        autocmd BufNewFile,BufRead afiedt.buf set filetype=plsql
        "
      " autocmd BufRead *sql set makeprg=~/bin/sql_compile_vim.sh\ %\ scott/tiger@orcl
        autocmd BufRead *sql set errorformat=%E%l/%c%m,%C%m,%Z

    " }

    " Make {
        autocmd BufRead     qpx.inc     setlocal filetype=make
        autocmd FileType    make        setlocal ts=8 sts=0 sw=8 noet nosta list
    " }

    " Mail {
        autocmd BufRead     letter*     set filetype=mail
        autocmd Filetype    mail        set fo-=l autoindent spell
    " }

    " Notes {
        autocmd BufNewFile,BufRead *.notes     set filetype=notes
        autocmd BufNewFile,BufRead *.notes.txt set filetype=notes
    " }

    " git.git/contrib {
        autocmd BufNewFile,BufRead COMMIT_EDITMSG set filetype=gitcommit
    " }

    " Rehash:
    "   autocmd BufWritePost ~/Work/mv_home/dot.vimrc   so ~/.vimrc

" }

" Unicode {
        " Char  CTRL-V+u    i+CTRL-V+digit
        " ¬       ac        U+00AC          not
        " ▸     25b8        U+25B8          black right triangle
        " ☠     2620        U+2620          skull and bones
        " ❤     2764        U+2764          heavy black heart
" }

" MyLib {

    " MVF_addlinenumbers {
    "     add explict line numbers to the left
    ":function! MVF_addlinenumbers()
    ":    exec ":% !awk '{printf \"\\%3d \\%s\\n\", nr, $0}'"
    ":endfunction
    " }

    " MVF_TerminateLastLine {
    "    Last line of a file must be a \n
    "function! MVF_TerminateLastLine()
    "   " save state
    "   let _s=@/
    "   let l = line(".")
    "   let c = col(".")

    "   " last line
    "   let s:lst = line("$")
    "   let s:str = getline( s:lst )
    "   if s:str !~ '^$'
    "       " Go last line, add new, del comments
    "       normal Go
    "       normal Gd$
    "   endif
    "   echo "Line " [s:lst] [s:str]
    "   " Restore state
    "   let @/=_s
    "   call cursor(l, c)
    "endfunction

    "if exists( 'MVF_TerminateLastLine()' )
    "   autocmd BufWritePre   * execute MVF_TerminateLastLine()
    "endif

    "map <leader>last :call TerminateLastLine() <CR>
    " }

    " MVF_StripTrailingWhitespaces {
    "    http://vimcasts.org/episodes/tidying-whitespace/
    "function! MVF_StripTrailingWhitespaces()
    "    " Preparation: save last search, and cursor position.
    "    let _s=@/
    "    let l = line(".")
    "    let c = col(".")
    "    " Do the business:
    "    %s/\s\+$//e
    "    " Clean up: restore previous search history, and cursor position
    "    let @/=_s
    "    call cursor(l, c)
    "endfunction
    "" }

" }

" Snippets {
    " :0 put =range(1,15)
    " :for in in range(1,15) | put ='192.168.1.'.i | endfor

    " tab to spaces: :set et|retab
    " spaces to tab: :set noet:retab!

    " define :Lorem command to dump in a paragraph of lorem ipsum
    " by Willa! http://github.com/willian/willvim/tree/master
    command! -nargs=0 Lorem :normal iLorem ipsum dolor sit amet, consectetur
            \ adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore
            \ magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation
            \ ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute
            \ irure dolor in reprehenderit in voluptate velit esse cillum dolore eu
            \ fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
            \ proident, sunt in culpa qui officia deserunt mollit anim id est
            \ laborum

    "
    "   nmap <leader>id1 <C-R>=strftime("%c")
    "   nmap <leader>ifp :e <C-R>=expand("%:p:h") .'/' <C-R>
    "   nmap <leader>ifp <C-R>=expand("%:p:h") .'/' <C-R>


    " http://github.com/nvie/vimrc/raw/master/vimrc
    " make p in Visual mode replace the selected text with the yank register
    " vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

    " Pull word under cursor into LHS of a substitute (for quick search and
    " replace)
    " nmap <leader>z :%s#\<<C-r>=expand("<cword>")<CR>\>#

    " Strip all trailing whitespace from a file, using ,w
    " nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

    " Run Ack fast (mind the trailing space here, wouldya?)
    " nnoremap <leader>a :Ack

    " Reselect text that was just pasted with ,v
    " nnoremap <leader>v V`]

    " Re-hardwrap paragraphs of text:
    " nnoremap <leader>q gqip

" }

" Plugins {

    " acp/autocomplpop {
        let g:acp_enableAtStartup        = 1
        let g:acp_mappingDriven          = 0
        let g:acp_ignorecaseOption       = 1
        let g:acp_behaviorKeywordLength  = 2
        let g:acp_behaviorFileLength     = 0

        map <leader>al :AcpLock <CR>
        map <leader>au :AcpUnlock <CR>
    " }

    " bufexplorer {
        " ,be / ,bv / ,bs
        let g:bufExplorerReverseSort     = 0
        let g:bufExplorerShowUnlisted    = 0    " Do not show unlisted buffers.
        let g:bufExplorerSortBy          ='name'
        let g:bufExplorerShowDirectories = 1    " Show directories.
    " }

    " openssl (password safe) {
        " ms: 15000 - 15s
        "     30000 - 20s
        "    300000 -  5m
        "let g:openssl_timeout = 301000
    " }

    " FuzzyFinder {
        " let g:fuzzy_ignore         = "*.log"
        " let g:fuzzy_matching_limit = 70
        " let g:fuzzy_ceiling = 95000
        " map <leader>tm   :FuzzyFinderTextMate  <CR>
        " map <leader>ffb  :FuzzyFinderBuffer    <CR> " Buffer
        " map <leader>fff  :FuzzyFinderFile      <CR> " File
        " map <leader>ffmf :FuzzyFinderMruFile   <CR> " Recent
        " map <leader>ffc  :FuzzyFinderCmd       <CR> " CoMmand
        " map <leader>ffmc :FuzzyFinderMruCmd    <CR> " Command
        " map <leader>ffd  :FuzzyFinderDir       <CR>
        " map <leader>ffbm :FuzzyFinderBookmark  <CR>
        " map <leader>fft  :FuzzyFinderTag       <CR>
        " map <leader>fftf :FuzzyFinderTaggedFile<CR>

        " let g:fuzzy_ignore         = "*.log"
        " let g:fuzzy_matching_limit = 70
        " let g:fuzzy_ceiling = 95000

        map  <leader>ffb   :FufBuffer          <CR>
        map  <leader>ffbd  :FufBookmarkDir     <CR>
        map  <leader>ffbf  :FufBookmarkFile    <CR>
        map  <leader>ffbm  :FufBookmark        <CR>
        map  <leader>ffbt  :FufBufferTag       <CR>
        map  <leader>ffcf  :FufCoverageFile    <CR>
        map  <leader>ffcl  :FufChangeList      <CR>
        map  <leader>ffd   :FufDir             <CR>
        map  <leader>fff   :FufFile            <CR>
        map  <leader>ffh   :FufHelp            <CR>
        map  <leader>ffj   :FufJumpList        <CR>
        map  <leader>ffl   :FufLine            <CR>
        map  <leader>ffmc  :FufMruCmd          <CR>
        map  <leader>ffmf  :FufMruFile         <CR>
        map  <leader>ffq   :FufQuickfix        <CR>
        map  <leader>fft   :FufTag             <CR>
        map  <leader>fftf  :FufTaggedFile      <CR>

    " }

    " LargeFile {
        " in megabytes - :Large/:Unlarge
        let g:LargeFile= 200
    " }

    " NerdCommenter {
        " Turn it off:
        " let loaded_nerd_comments=1

        let NERDCreateDefaultMappings = 1
        let NERDRemoveExtraSpaces = 1
        let NERDSpaceDelims = 1
        let NERDMenuMode = 0

    " }

    " NerdTree {
        " Turn it off:
        " let loaded_nerd_tree=1

        let NERDTreeCaseSensitiveSort = 1
        let NERDTreeChDirMode         = 0
        let NERDTreeIgnore            = ['\.[ao]$','\.sw?$','\.DS_Store','\.svn','\.CVS','\.git']
        let NERDTreeMouseMode         = 2
        let NERDTreeShowLineNumbers   = 0
        let NERDTreeWinSize           = 35
        let NERDTreeHijackNetrw       = 1

        map <leader>d  :NERDTreeToggle <CR> " Dir tree
        map <leader>dd :NERDTreeMirror <CR> " Dir tree
    " }

    " Bash-support {
        let BASH_Root = 'B&ash.'         " original
        let BASH_Root = '&Plugin.B&ash.' " mine.
    " }

    " Perl-support {
        let Perl_Root = '&Perl.'          " original
        let Perl_Root = '&Plugin.&Perl.'  " mine.
    " }

    " Align {
        let g:DrChipTopLvlMenu     = "Plugin."
        let g:alignmaps_euronumber = 1
    " }

    " dbext {
    " }

    " fugitive.vim {
        " Turn it off:
        " let g:loaded_fugitive = 1
    " }

    " increment.vim {
    " }

    " SearchComplete {
        " Turn it off:
        " let loaded_search_complete = 1
    " }

    " repeat.vim {
        " Turn it off:
        " let g:loaded_repeat = 1
    " }

    " speeddating.vim {
        " Turn it off:
        " let g:loaded_speeddating      = 1
        " 0: maps to <C-A>/<C-X>
        let g:speeddating_no_mappings = 0
    " }

    " surround.vim {
        " Turn it off:
        " let g:loaded_surround = 1
    " }

    " taglist {
        " let loaded_taglist = 1 " 0: activate / 1: do not load
        " let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
        " let Tlist_File_Fold_Auto_Close = 1
        " let Tlist_Show_Menu = 1

        " map <leader>t   :TlistToggle     <CR>
        " map <leader>ts  :TlistSessionSave ~/.tlistsession.vim.tag <CR>
        " map <leader>tl  :TlistSessionLoad ~/.tlistsession.vim.tag <CR>
    " }

    " Rainbows {
        " nmap <leader>R :RainbowParenthesesToggle<CR>
    " }

" }

" Test {
" }

" vim: set foldmarker={,} foldlevel=0 nospell:



"load pathogen managed plugins
call pathogen#runtime_append_all_bundles()

"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"store lots of :cmdline history
set history=1000

set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom

set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default

set number      "add line numbers
set showbreak=...
set wrap linebreak nolist

"mapping for command key to map navigation thru display lines instead
"of just numbered lines
vmap <D-j> gj
vmap <D-k> gk
vmap <D-4> g$
vmap <D-6> g^
vmap <D-0> g^
nmap <D-j> gj
nmap <D-k> gk
nmap <D-4> g$
nmap <D-6> g^
nmap <D-0> g^

"add some line space for easy reading
set linespace=4

"disable visual bell
set visualbell t_vb=

"try to make possible to navigate within lines of wrapped lines
nmap <Down> gj
nmap <Up> gk
set fo=l

"statusline setup
set statusline=%f       "tail of the filename

"Git
set statusline+=[%{GitBranch()}]

"RVM
set statusline+=%{exists('g:loaded_rvm')?rvm#statusline():''}

"display a warning if fileformat isnt unix
"set statusline+=%#warningmsg#
"set statusline+=%{&ff!='unix'?'['.&ff.']':''}
"set statusline+=%*

"Display a warning if file encoding isnt utf-8
"set statusline+=%#warningmsg#
"set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
"set statusline+=%*

"set statusline+=%h      "help file flag
"set statusline+=%y      "filetype
"set statusline+=%r      "read only flag
"set statusline+=%m      "modified flag

"display a warning if &et is wrong, or we have mixed-indenting
"set statusline+=%#error#
"set statusline+=%{StatuslineTabWarning()}
"set statusline+=%*
"
"set statusline+=%{StatuslineTrailingSpaceWarning()}
"
"set statusline+=%{StatuslineLongLineWarning()}
"
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"display a warning if &paste is set
"set statusline+=%#error#
"set statusline+=%{&paste?'[paste]':''}
"set statusline+=%*

set statusline+=%=      "left/right separator

"set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight

set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2

"turn off needless toolbar on gvim/mvim
set guioptions-=T

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")
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
        let tabs = search('^\t', 'nw') != 0
        let spaces = search('^ ', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        else
            let b:statusline_tab_warning = ''
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

    let long_line_lens = []

    let i = 1
    while i <= line("$")
        let len = strlen(substitute(getline(i), '\t', spaces, 'g'))
        if len > threshold
            call add(long_line_lens, len)
        endif
        let i += 1
    endwhile

    return long_line_lens
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

"indent settings
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

"display tabs and trailing spaces
"set list
"set listchars=tab:\ \ ,extends:>,precedes:<
" disabling list because it interferes with soft wrap

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
set mouse=a
set ttymouse=xterm2

"hide buffers when not displayed
set hidden

"Command-T configuration
let g:CommandTMaxHeight=10
let g:CommandTMatchWindowAtTop=1



" PeepOpen uses <Leader>p as well so you will need to redefine it so something
" else in your ~/.vimrc file, such as:
" nmap <silent> <Leader>q <Plug>PeepOpen

silent! nmap <silent> <Leader>p :NERDTreeToggle<CR>
nnoremap <silent> <C-f> :call FindInNERDTree()<CR>

"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

"map to bufexplorer
nnoremap <leader>b :BufExplorer<cr>

"map to CommandT TextMate style finder
nnoremap <leader>t :CommandT<CR>

"map Q to something useful
noremap Q gq

"make Y consistent with C and D
nnoremap Y y$

"bindings for ragtag
inoremap <M-o>       <Esc>o
inoremap <C-j>       <Down>
let g:ragtag_global_maps = 1

"mark syntax errors with :signs
let g:syntastic_enable_signs=1

"key mapping for vimgrep result navigation
map <A-o> :copen<CR>
map <A-q> :cclose<CR>
map <A-j> :cnext<CR>
map <A-k> :cprevious<CR>

"snipmate setup
try
  source ~/.vim/snippets/support_functions.vim
catch
  source ~/vimfiles/snippets/support_functions.vim
endtry
autocmd vimenter * call s:SetupSnippets()
function! s:SetupSnippets()

    "if we're in a rails env then read in the rails snippets
    if filereadable("./config/environment.rb")
        call ExtractSnips("~/.vim/snippets/ruby-rails", "ruby")
        call ExtractSnips("~/.vim/snippets/eruby-rails", "eruby")
    endif

    call ExtractSnips("~/.vim/snippets/html", "eruby")
    call ExtractSnips("~/.vim/snippets/html", "xhtml")
    call ExtractSnips("~/.vim/snippets/html", "php")
endfunction

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
    if &filetype !~ 'commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction

"define :HighlightLongLines command to highlight the offending parts of
"lines that are longer than the specified length (defaulting to 80)
command! -nargs=? HighlightLongLines call s:HighlightLongLines('<args>')
function! s:HighlightLongLines(width)
    let targetWidth = a:width != '' ? a:width : 79
    if targetWidth > 0
        exec 'match Todo /\%>' . (targetWidth) . 'v/'
    else
        echomsg "Usage: HighlightLongLines [natural number]"
    endif
endfunction

"key mapping for window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"key mapping for saving file
nmap <C-s> :w<CR>

"key mapping for tab navigation
nmap <Tab> gt
nmap <S-Tab> gT

"Key mapping for textmate-like indentation
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv

let ScreenShot = {'Icon':0, 'Credits':0, 'force_background':'#FFFFFF'}



