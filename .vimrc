" A lot stolen from "The Ultimate .Vimrc file
" http://spf13.com/post/ultimate-vim-config
"
" Environment variables configuation {
"$HOME: where you can put custom config files,
"       $HOME/.vim, $HOME/.vimrc in linux
"       $HOME/vimfiles, $HOME/_vimrc in windows 
"$VIMRUNTIM: default VIM runtime files
"$MYVIMRC: the VIMRC path
"$VIM:  the VIM command path
if has('win32')
  let $VIMFILES=$VIM.'/vimfiles'
  let $V=$VIM.'/_vimrc'
else
  let $VIMFILES=$HOME.'/.vim'
  let $V=$HOME.'/.vimrc'
endif
" }

" Basic {
set visualbell  "Disble bell
set t_vb="
set nocompatible "No vi compatibility
let mapleader="," " Mapleader
set history=1000  " Keep (a lot) more history
set nobackup
set nowritebackup
" }

" General {
"call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
" Encodings {
" termencoding => input/output
" encoding     => VIM process/new file encoding
" fileencoding => storage in file system
if has("multi_byte") 
  " is the default locale already a Unicode one? if not, set UTF-8 
  if &encoding !~? '^u' 
    " avoid clobbering the keyboard encoding 
    if &termencoding == "" 
      let &termencoding= &encoding 
    endif 
    set encoding=utf-8 
  endif 
  " define heuristics for encoding detection in existing files 
  " ucs-bom (if present) must be first, then uft-8 and latin1 
  set fileencodings=ucs-bom,utf-8,gb18030,euc-jp,euc-kr,latin1 
  " set encoding & BOM for newly created files 
  setglobal bomb fileencoding=utf-8 
  " create new files with Unix (LF) EOL by default 
  set fileformats=unix,dos,mac 
  setglobal fileformat=unix 
  " set menu language
  "set langmenu=zh_CN.utf-8
  "source $VIMRUNTIME/delmenu.vim
  "source $VIMRUNTIME/menu.vim
  "language messages zh_cn.utf-8

  " warning! fileformats (plural) != fileformat (singular) 
else 
  echoerr "Error= multi-byte disabled at compile time in this Vim" 
  finish 
endif " }

if has("autocmd")  "Do this when compiled with support for autocommands.
  filetype plugin indent on  " Automatically change file types

  " Set File type to 'text' for file ending in .txt
  autocmd BufNewFile,BufRead *.txt setfiletype text

  " Enable soft-wrapping for text files
  " autocmd FileType text,html,xhtml,eruby setlocal wrap linebreak nolist

  " Put these in an autocmd group
  augroup vimrcEx
    au!
    " When editing a file, always jump to the last know cursor position
    autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \ exe "normal g`\"" |
          \ endif

    "autocmd BufWritePost .vimrc source $MYVIMRC  " Auto load .vimrc file
  augroup END

endif " has("autocmd")
" }

" Vim UI {
" Switch syntax highlighting on, when terminal has colors
if (&t_Co>256 || has("gui_running"))
  syntax on " Enable systax highlightation

  "colorscheme railscasts
  "colorscheme ir_black
  "colorscheme wombat

  "syntax enable
  set background=light   " set background=dark/light
  colorscheme solarized
endif

if has("cmdline_info")
  set ruler " Enable cursor position
  set showcmd " Show imcomplete CMDS at the bottom
  set showmode  " Display current mode
endif

set laststatus=2 "Always display the status line
if has("statusline")
  set statusline=%F%m%r%h%w%=(%Y/%{&encoding}/%{&ff})\ (%l\/%L,\%c\ %P)
endif

set showmatch  " Show matching of: () [] {}
set matchpairs+=<:>

" Searching {
set ignorecase " Case insensitive search
set smartcase  " Case sensitve when uppercase is present
set incsearch  " Search as you type
set hlsearch   " Highlight search matches
" }

set autoread  " Auto read when file is changed
set hidden    " Hide buffers, rather ehan close them
set number    " Show line number
set numberwidth=3

" GVim {
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Courier\ New\ 10   " Set the font
  else
    set guifont=Monaco:h10:cDEFAULT  " Set the font
    "set guifont=Courier_new:h11:cDEFAULT  " Set the font
    set guifontwide=NSimsun:h10:cGB2312  " Set the font
  endif

  highlight NonText guibg=#080808
  highlight Folded  guibg=#0A0A0A guifg=#9090D0

  " GVim options {
  set guioptions-=m  " Remove menu bar
  set guioptions-=T  " Remove toolbar with icons
  set guioptions-=r  " Remove scrollbars
  " }

  " Window  {
  set lines=32
  set columns=92
  winpos 200 0
  " }
endif
" }

" Formatting {
"Be smart, and awesome, about indentation
set cindent     " Set C-style indent
set autoindent  " Indent at the save leval as previous line
set smartindent " Auto indent after a {
set smarttab

set tabstop=2    " Tabs are 2 spaces
set shiftwidth=2 " Even if there are tabs, preview as spaces
set softtabstop=2
set expandtab  " Tabs are spaces
"set backspace=2 " Backspace back 2 spaces
set backspace=indent,eol,start " Allow backspacing over everything in insert mode
set wrap   " soft wrap
set colorcolumn=79 " show the vertical line to wrap the line
highlight ColorColumn ctermbg=green guibg=orange

set listchars=tab:»\ ,trail:-,eol:¶
if has("folding")
  set foldenable
  "set foldmethod=syntax  " Set Fold method as (indent,syntax,manual)
  set foldlevel=1
  set foldnestmax=2
endif

" Tab completion
"set completeopt=longest, menu
"set wildmode=list:longest, list:full
"set complete=,.t

" }

" Key Mapping {
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l
map <C-H> <C-W>h

map <C-S> :w! <CR>

" Enable global COPY and PASTE
nmap <C-V> "+P
imap <C-V> <ESC><C-V>i
vmap <C-C> "+y

" Use <space> to PageDown
nmap <Space> <C-f>

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e  $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Quick escaping
imap jj <ESC>

" Clean whitespace at the line bottom
nmap <leader>rs :%s/\s\+$//g<CR>
nmap <leader>rb :g/^[ \|\t]*$/d<CR>

" Hide search highlighting
map <leader>h :set invhls<CR>

" Open an edit command with the path of current edited file
map <leader>e :e <C-R>=expand("%:p:h") <CR>
map <leader>vs :vsp <C-R>=expand("%:p:h") <CR>

" launch the currently edited file with external application that is
" associated with it
"nmap <leader>x :silent ! start "1" "%:p"<CR>
nmap <leader>x :silent !start cmd /c "ruby %:p" & pause <CR>
"nmap <leader>x :silent !start /min cmd /c "ruby %:p" & pause <CR>

" Insert current file name
imap <C-F> <C-R>=expand("%")<CR>

" Map autocomplete to tab
imap <Tab> <C-N>

" }

" }

" Plugin {

" NERDTree toggle {
nmap <silent><F7> :NERDTreeToggle<CR>
nmap <leader>` :NERDTreeToggle<CR>
" }

" BufExplorer {
"nmap <silent><F8> :BufExplorer<CR>
let g:bufExplorerShowRelativePath=1
nmap <leader>1 :BufExplorer<CR>
" }

" MRU(Most Recently Used){
let MRU_Max_Entries=100
let MRU_Exclude_Files='^/tmp/.*\|^/var/tmp/.*'  " For Linux
let MRU_Exclude_Files='^c:\\temp\\.*'  " For MS-Windows
"let MRU_Window_Height=10
let MRU_Auto_Close=1
nmap <leader>2 :MRU<cr>
" }

" SuperTab {
let g:SuperTabDefaultCompletionType = "context"
" }


" VIM-Align {
vmap <leader>t : Align
" }

" Vimwiki {
"
if has("win32")
  let vimwiki_path='d:/udisk/Dropbox/vimwiki/'
else
  let vimwiki_path=$HOME.'/vimwiki/'
endif

let vimwiki_src_path=vimwiki_path.'/src/'
let vimwiki_html_path=vimwiki_path.'/html/'
let g:vimwiki_list=[{
      \'path': vimwiki_src_path, 
      \'path_html': vimwiki_html_path,
      \'auto_export': 1,
      \'html_header': vimwiki_path.'/template/header.tpl',
      \'html_footer': vimwiki_path.'/template/footer.tpl' }]
let g:vimwiki_camel_case=0
"let g:vimwiki_hl_cb_checked=1
let g:vimwiki_menu=''
let g:vimwiki_CJK_length=1  " enable lenght counting for CJK
let g:vimwiki_valid_html_tags='b,i,s,u,sub,sup,kbd,br,hr,div,code,del,h1'

nmap <S-F4> :VimwikiAll2HTML<CR>
nmap <F4> :Vimwiki2HTML<CR>
nmap <leader>wd :VimwikiDeletelink<CR>
nmap <leader>wr :VimwikiRenamelink<CR>
"nmap <F3> :Calendar<CR> " shortcut for Calendar plugin

" } end Vimwiki

" Zen coding {
"let g:user_zen_expandabbr_key = "<c-e>"
"let g:user_zen_complete_tag=1
" }

" Omni Completion
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" }

" Ctags {
" Add current directory's generated tags file to available tags
set tags =./tags,tags
"map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR><CR>
" update ctags automatically when saving js file
autocmd BufWritePost *.js silent! !eval 'ctags -R -o newtags; mv newtags tags' &

" }

" Taglist {
let Tlist_Ctags_Cmd='/usr/bin/ctags'
let Tlist_Show_One_File=1
"let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window=1
"let Tlist_WinWidth='auto'
nmap <leader>3 :TlistToggle<CR>
nmap <leader>ru :TlistUpdate<CR>

"let g:tlist_javascript_settings='javascript;s:string;a:array;o:object;f:function;c:closure'
let g:tlist_javascript_settings='js;o:object;f:function;c:closure;a:array;s:string;n:number;b:boolean'
" }
" }

" Custom funciton {
" Append the single step to config.pro file
function! APPEND_TRAIL_CONFIG()
  call append(line('$'), 'set_trail_single_step yes')
endfunction
nmap <leader>rt :call APPEND_TRAIL_CONFIG()<CR>

" Toggle whitespace visibility
function! TOGGLE_LIST()
  if &list 
    set nolist
  else
    set list
  endif
endfunction
nmap <leader>rl :call TOGGLE_LIST()<CR>

" Toggle background 
function! TOGGLE_BACKGROUND()
  let match_flag = match(&background, 'light')
  if match_flag > -1
    set background=dark
  else
    set background=light
  endif
endfunction
nmap <leader>rg :call TOGGLE_BACKGROUND()<CR>
" }
" }
