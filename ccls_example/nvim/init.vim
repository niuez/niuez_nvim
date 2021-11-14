if &compatible
  set nocompatible
endif

set encoding=utf8
if exists('&ambw')
  set ambiwidth=double
endif

let g:lyla_bg_is_none = v:false

set runtimepath+=/root/.vim/lyla.vim
set runtimepath+=/root/.vim/nvim-lspconfig
set runtimepath+=/root/.vim/lsp_signature.nvim

filetype plugin indent on

let g:codedark_conservative = 1

syntax enable
set number
"set cursorline
set termguicolors
"set cursorcolumn
set encoding=UTF-8
set cmdheight=2
set laststatus=2
set background=dark
set clipboard+=unnamedplus
set splitbelow
set nofoldenable
set conceallevel=0
" set relativenumber
" Disable highlight italic in Markdown
autocmd FileType markdown hi! def link markdownItalic Normal

set background=dark


colorscheme lyla_iterm2

set expandtab
set tabstop=2
set shiftwidth=2
set winblend=30
set pumblend=30


nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap s- <C-w>-
nnoremap s+ <C-w>+
nnoremap s> <C-w>>
nnoremap s< <C-w><
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nmap <C-p> <Plug>AirlineSelectPrevTab
nmap <C-n> <Plug>AirlineSelectNextTab

autocmd VimEnter * imap <Nul> <C-Space>
imap <C-Space> <ESC>zzA
nmap <C-Space> zz
tmap <C-q> <C-\><C-n>
nmap ge :CocCommand explorer<CR>
nmap gb :CocCommand explorer --sources buffer+,file-<CR>
imap <C-k> <Plug>(coc-snippets-expand)
smap <C-k> <Plug>(coc-snippets-expand)
xmap <C-k> <Plug>(coc-snippets-expand)
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>

let s:fg = "#6F8EB3"
"let s:fg = "#a4a4a4"
let s:sky1 = "#bd8840"
let s:sky2 = "#d06e3e"
let s:sky3 = "#e9a05a"
let s:fth1 = "#87bba5"
let s:fth2 = "#737fc4"
let s:blue = "#e9a05a"
let s:grey = "#6A6868"
let s:white = "#999999"
let s:none = "NONE"
let s:bg = "#242828"

function! s:h(group, fg, bg, attr)
  if a:attr != ""
    exec "hi " . a:group . " guifg=" . a:fg . " guibg=" . a:bg . " gui=" . a:attr
  else
    exec "hi " . a:group . " guifg=" . a:fg . " guibg=" . a:bg . " gui=" . s:none
  endif
endfun

function! SetStatusLine()
  if mode() =~ 'i'
    let c = 1
    let mode_name = 'INSERT'
  elseif mode() =~ 'n'
    let c = 2
    let mode_name = 'NORMAL'
  elseif mode() =~ 'R'
    let c = 3
    let mode_name = 'REPLACE'
  elseif mode() =~ 'c'
    let c = 4
    let mode_name = 'COMMAND'
  else
    let c = 5
    let mode_name = 'VISUAL'
  endif
  return '%' . c . '*' . mode_name . '%*%#UserStatusLineInner#  %{get(g:,"coc_git_status","")}  %<%F%m%r%= %{&ft}  %c:%l'
endfunction

call s:h("User1", s:sky1, s:bg, s:none)
call s:h("User2", s:fth1, s:bg, s:none)
call s:h("User3", s:sky1, s:bg, s:none)
call s:h("User4", s:fth2, s:bg, s:none)
call s:h("User5", s:sky2, s:bg, s:none)
call s:h("UserStatusLineInner", s:white, s:none, s:none)

set statusline=%!SetStatusLine()

function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

function! SynGroup()                                                            
    let l:s = synID(line('.'), col('.'), 1)                                       
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

nmap sc :call SynGroup()<CR>

let s:paren_hl_on = 0
function s:Highlight_Matching_Paren()
  if s:paren_hl_on
    match none
    let s:paren_hl_on = 0
  endif
  let pos = getpos('.')
  let [s_lnum, s_col] = searchpairpos('(', '', ')', 'nW', '', 0, 20)
  let [e_lnum, e_col] = searchpairpos('(', '', ')', 'nbW', '', 0, 20)
  call cursor(e_lnum, e_col)
  let [i_lnum, i_col] = searchpos('\i*(', 'cnbW', 0, 20)
  call setpos('.', pos)
  if e_lnum > 0 && e_lnum >= line('w0') && e_lnum <= line('w$')
    if s_lnum > 0 && s_lnum >= line('w0') && s_lnum <= line('w$')
      exe 'match MatchParen /\(\%' . s_lnum . 'l\%' . s_col . 'c'
           \ . '\)\|\(\%>'. (i_lnum - 1) . 'l\%<'. (e_lnum + 1)  . 'l\%>' . (i_col - 1) . 'c.*\%<' . (e_col + 1). 'c\)/'
      let s:paren_hl_on = 1
    else
      exe 'match MatchParen /\(\%>'. (i_lnum - 1) . 'l\%<'. (e_lnum + 1)  . 'l\%>' . (i_col - 1) . 'c.*\%<' . (e_col + 1). 'c\)/'
      let s:paren_hl_on = 1
    endif
    
  endif
endfunction

autocmd CursorMoved,CursorMovedI * call s:Highlight_Matching_Paren()
autocmd InsertEnter * match none

set signcolumn=yes
lua require('lsp_init')

set completeopt=menuone,noinsert,noselect
function! OpenCompletion()
    if !pumvisible() && ((v:char >= 'a' && v:char <= 'z') || (v:char >= 'A' && v:char <= 'Z'))
        call feedkeys("\<C-x>\<C-o>", "n")
    endif
endfunction

autocmd InsertCharPre * call OpenCompletion()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ "\<C-x>\<C-o>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
