" init pathogen
execute pathogen#infect()

" some recommended configs
set nocompatible
set modifiable
set autoindent
set smartindent
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set number
set expandtab ts=2 sw=2 ai
set colorcolumn=80

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
let g:NERDTreeWinSize = 36
let g:NERDTreeWinPos = "left"
let g:NERDTreeIgnore = [
  \ 'node_modules',
  \ 'vendor',
  \ '.git',
  \ '.github',
  \ '.cache',
  \ '.cache-loader',
  \ '.DS_STORE'
  \ ]
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

" configure syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" configure whitespace linter
let g:better_whitespace_enabled = 1
let g:strip_whitespace_on_save = 1
