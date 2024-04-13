" REQUIRED FOR VUNDLE
set nocompatible              " be iMproved, required
filetype off                  " required
syntax on
" set background=dark
" color gruvbox8_hard
" color notelight
" color rizzle
color nord
set encoding=utf-8
set noarabicshape
" color gruvbox8_hard

" set rtp+=~/.vim/bundle/Vundle.vim 
" call vundle#begin()

" let Vundle manage Vundle, required
" Plugin 'VundleVim/Vundle.vim'
" Plugin 'preservim/nerdtree'
" PUT THE NAME OF PLUGINS YOU'VE 
" DOWNLOADED, OR ABOUT TO, HERE:

" end of plugins
" call vundle#end()            " required
" filetype plugin indent on    " required
" end of vundle wankery

" customisations:
" note: to use the system's default, use peachpuff , not default!
" color peachpuff
" set t_Co=256
" highlight Normal ctermbg=NONE
" highlight nonText ctermbg=NONE
" highlight LineNr ctermfg=white
set noexpandtab 
set ts=2 sw=2 ai
" set list

" uncomment the next line for a fixed vim window
" set lines=50 columns=150

set guifont=Monospace\ 8
set number
set clipboard=unnamed
set clipboard=unnamedplus
inoremap <C-v> <ESC>"+pa
vnoremap <C-c> "+y
vnoremap <C-d> "+d
map <Tab> <C-W>w
map <C-g> :NERDTreeFocus <ENTER> 

" treating comments based on the language:
" add anything you want in here
function Comment()
  let pattern="\(\s*\)\(.*\)"
  if &filetype == "vim"
    " for some reason the pattern saving doesn't work. here's to debug:
    " let command='s:'.pattern.':\1\" \2'
    " execute command
    s:\(\s*\)\(.*\):\1\" \2
  elseif &filetype == "java"
    s:\(\s*\)\(.*\):\1// \2
  elseif &filetype == "c"
    s:\(\s*\)\(.*\):\1// \2
  elseif &filetype == "cpp"
    s:\(\s*\)\(.*\):\1// \2
  elseif &filetype == "h"
    s:\(\s*\)\(.*\):\1// \2
  elseif &filetype == "php"
    s:\(\s*\)\(.*\):\1# \2
  elseif &filetype == "js"
    s:\(\s*\)\(.*\):\1// \2
  elseif &filetype == "python"
    s:\(\s*\)\(.*\):\1# \2
  elseif &filetype == "py"
    s:\(\s*\)\(.*\):\1# \2
  elseif &filetype == "perl"
    s:\(\s*\)\(.*\):\1# \2
  elseif &filetype == "js"
    s:\(\s*\)\(.*\):\1// \2
  elseif &filetype == "ts"
    s:\(\s*\)\(.*\):\1// \2
  elseif &filetype == "vue"
    s:\(\s*\)\(.*\):\1// \2
  endif
endfunction

" treating comments based on the language:
" add anything you want in here
function Uncomment()
  if &filetype == "vim"
    s:" :
  elseif &filetype == "java"
    s:// :
  elseif &filetype == "cpp"
    s:// :
  elseif &filetype == "h"
    s:// :
  elseif &filetype == "c"
    s:// :
  elseif &filetype == "php"
    s:# :
  elseif &filetype == "js"
    s:// :
  elseif &filetype == "vue"
    s:// :
  elseif &filetype == "python"
    s:# :
  elseif &filetype == "py"
    s:# :
  elseif &filetype == "php"
    s:# :
  elseif &filetype == "perl"
    s:# :
  endif
endfunction

" mapping the function to combinations with k in normal mode
map <C-k> :call Comment() <ENTER>
map <S-K> :call Uncomment() <ENTER>

" changing tabs back and forth
map <S-TAB> :tabprevious <ENTER>
map <TAB> :tabnext <ENTER>
imap <C-TAB> :tabnext <ENTER> <i>

" go to end of line without explicit shit
imap <C-8> j <ENTER>
imap <C-9> k <ENTER>

" note: <C-j> acts like enter! and <C-h> like backspace and <C-i> like tab!
" this is useful for keyboards who don't have those things

" for xml and html like tags, closes the tag"
imap <C-e> <ESC>:s:<\(\w\+\)\(\s\)\?\(.*\)>:<\1\2\3><\/\1><ENTER> ^ :call search('>','',line('.')) <ENTER> i
let mapleader="`"

" for django/jinja
imap <C-r> <ESC>a{% %}<ESC>^/%<ENTER>a 
imap <C-f> <ESC>a{{ }}<ESC>bhi 

"set ignorecase \"mostly during a search"
let NERDTreeIgnore=['.gch','^node_modules$','^__pycache__$']

" syntax wank
autocmd BufNewFile,BufRead *.tpp,*.h set syntax=cpp

" java - getter setter 
function! Jgs(type, name)
  :call  append(search('^}\s*')-1,"\tpublic ".a:type." get".toupper(a:name[0]).a:name[1:]."(){return this.".a:name.";}")
  :call  append(search('^}\s*')-1,"\tpublic void set".toupper(a:name[0]).a:name[1:]."(".a:type." ".a:name."){this.".a:name."=".a:name.";}")
endfunction

" setting the commands to it
:command! -nargs=+ Jgs :call Jgs(<f-args>)

" set javafx's fxml syntax similar to xml
au BufNewFile,BufRead,BufReadPost *.fxml set syntax=xml

" hide unwanted shitwanklord 
set wildignore+=*__pycache__*
set wildignore+=LICENSE

