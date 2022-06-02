" save
command! -nargs=0 -bar Update if &modified
  \|    if empty(bufname('%'))
  \|        browse confirm write
  \|    else
  \|        confirm write
  \|    endif
  \|end
nnoremap <C-s> <cmd>w<cr>
inoremap <C-s> <cmd>w<cr>
vnoremap <C-s> <cmd>w<cr>
cnoremap <C-s> <cmd>w<cr>

" terminal
silent! set termwinkey=<C-q>
silent! tnoremap <silent> <C-q><C-q> <C-q>:try<bar>hide<bar>catch<bar>quit!<bar>endtry<CR>
silent! tnoremap <C-q><C-[> <C-q>N

" disable EX-mode
nnoremap  Q <Nop>
nnoremap gQ <Nop>

" Go to the starting position after visual modes
vnoremap <ESC> o<ESC>

" Escape from Select mode to Normal mode
snoremap <ESC> <C-c>


noremap <leader>ms :<C-u>source $MYVIMRC<CR>


" nnoremap <S-Tab>        gT
" nnoremap <Tab>          gt
nnoremap <silent> <S-t> :tabnew<CR>
nnoremap <F4>           :bd<CR>



" 互换 最高化 和 变矮一点的快捷键，还是最高化更好用一点
noremap <C-w>- <C-w>_
noremap <C-w>_ <C-w>-

" 关闭 window
noremap <M-c> :<C-u>close<cr>
noremap <M-q> :<C-u>quit<cr>
noremap <M-C> :<C-u>close!<cr>
noremap <M-Q> :<C-u>quit!<cr>

" copy (and modify) from https://vim.fandom.com/wiki/Moving_lines_up_or_down
nnoremap <A-Down> :m .+1<CR>==
nnoremap <A-Up> :m .-2<CR>==
inoremap <A-Down> <Esc>:m .+1<CR>==gi
inoremap <A-Up> <Esc>:m .-2<CR>==gi
vnoremap <A-Down> :m '>+1<CR>gv=gv
vnoremap <A-Up> :m '<-2<CR>gv=gv

nnoremap <Leader>c :

noremap <C-z> <Esc>u
inoremap <C-z> <Esc>ui

"  vnoremap zf :<c-u>call <SID>add_fold_marker()<cr>
