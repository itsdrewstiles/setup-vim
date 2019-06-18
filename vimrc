" init pathogen
execute pathogen#infect()

" some recommended configs
set nocompatible
set modifiable
set exrc
set autoindent
set smartindent
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set number
set scrolloff=5
set colorcolumn=80
set nofoldenable

set wildignore+=node_modules,vendor,.git,.cache,.DS_STORE

syntax on
filetype plugin indent on

" insertmode by default
"au BufRead,BufNewFile * start

" configure nerdtree
autocmd StdinReadPre * let s:std_in = 1
autocmd VimEnter * if argc() == 0
  \ && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1
  \ && exists("b:NERDTree")
  \ && b:NERDTree.isTabTree()) | q | endif

let g:NERDTreeNodeDelimiter = "\u00a0"
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeCascadeSingleChildDir = 0
let g:NERDTreeRespectWildIgnore = 1
let g:NERDTreeIndicatorMapCustom = {
  \ "Modified"  : "modified",
  \ "Staged"    : "staged",
  \ "Untracked" : "untracked",
  \ "Renamed"   : "renamed",
  \ "Unmerged"  : "unmerged",
  \ "Deleted"   : "deleted",
  \ "Dirty"     : "dirty",
  \ "Clean"     : "clean",
  \ 'Ignored'   : 'ignored',
  \ "Unknown"   : "?"
  \ }

" configure neomake
call neomake#configure#automake('nrwi', 500)
let g:neomake_serialize = 1
let g:neomake_serialize_abort_on_error = 1

" configure whitespace linter
let g:better_whitespace_enabled = 1
let g:strip_whitespace_on_save = 1
