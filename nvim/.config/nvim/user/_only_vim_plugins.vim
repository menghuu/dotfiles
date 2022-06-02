" 这里的插件只用于vim中，一般而言是因为nvim不需要，或者vim有更好的插件来实现类似的功能


" 给全文鼠标放在的单词出现的那些单词都加上下划线
" Plug 'itchyny/vim-cursorword'
Plug 'dominikduda/vim_current_word'
" Twins of word under cursor:
let g:vim_current_word#highlight_twins = 1
" The word under cursor:
let g:vim_current_word#highlight_current_word = 1
" hi link CurrentWordTwins Search

Plug 'Yggdroot/indentLine'


" 彩虹括号
Plug 'luochen1990/rainbow'
" 自动配对括号 (|)"hello world" 光标位于|时按下 alt-e 将会变成 ("hello world")
Plug 'jiangmiao/auto-pairs'
augroup autopairs_config
  autocmd!
  autocmd autopairs_config Filetype TelescopePrompt,TelescopeResults let b:AutoPairs={} endif
augroup END



" 欢迎页面
Plug 'mhinz/vim-startify'


" icon 支持，需要nerdfont支持
Plug 'ryanoasis/vim-devicons'


" statusline tabline {{{
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" Plug 'itchyny/lightline.vim'

" tabline
" Plug 'bagrat/vim-buffet'
" }}}


" git 支持。还支持其他的 version control system
" https://github.com/mhinz/vim-signify
if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif
omap ih <plug>(signify-motion-inner-pending)
xmap ih <plug>(signify-motion-inner-visual)
omap ah <plug>(signify-motion-outer-pending)
xmap ah <plug>(signify-motion-outer-visual)
" 还有一个类似的老牌插件 https://github.com/airblade/vim-gitgutter 但是只支持git
"  Plug 'airblade/vim-gitgutter'
" ih/ah 来进行 hunk 选择
" Plug 'gilligan/textobj-gitgutter'
" 好像gitgutter 本身就支持 类似的功能，只是需要重新映射一下，毕竟ic ac 还是挺常用的
" omap ih <Plug>(GitGutterTextObjectInnerPending)
" omap ah <Plug>(GitGutterTextObjectOuterPending)
" xmap ih <Plug>(GitGutterTextObjectInnerVisual)
" xmap ah <Plug>(GitGutterTextObjectOuterVisual)


Plug 'liuchengxu/vim-which-key' ", { 'on': ['WhichKey', 'WhichKey!'] }
" TODO: 探索更多的设置
let g:loaded_config_which_key = 1
autocmd VimEnter * call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
nnoremap <silent> ] :<c-u>WhichKey ']'<CR>
nnoremap <silent> [ :<c-u>WhichKey '['<CR>
nnoremap <silent> z :<c-u>WhichKey 'z'<CR>
" Define prefix dictionary
let g:which_key_map =  {}
" Second level dictionaries:
" 'name' is a special field. It will define the name of the group, e.g., leader-f is the "+file" group.
" Unnamed groups will show a default empty string.
" =======================================================
" Create menus based on existing mappings
" =======================================================
" You can pass a descriptive text to an existing mapping.
let g:which_key_map.f = { 'name' : '+file' }
nnoremap <silent> <leader>fs :update<CR>
let g:which_key_map.f.s = 'save-file'
nnoremap <silent> <leader>fd :e $MYVIMRC<CR>
let g:which_key_map.f.d = 'open-vimrc'
nnoremap <silent> <leader>oq  :copen<CR>
nnoremap <silent> <leader>ol  :lopen<CR>
let g:which_key_map.o = {
      \ 'name' : '+open',
      \ 'q' : 'open-quickfix'    ,
      \ 'l' : 'open-locationlist',
      \ }


" <leader><leader>s 查找整个可是页面上搜索的那个字符，这个得试一下才好解释。下面的快捷键不再写全了
" f 和 s一样，但是只往文档的后面搜那个字符， F往左
" t 往右； T 往左 ，不到你想要的那个字符
" b 往前跳单词，w 往后跳单词
" e往后跳 ge往前跳
" Plug 'easymotion/vim-easymotion'
" unmap <leader><leader>s
" 要在v 或者 ctrl-v模式下 <leader><leader>l 来选择这些行
" y<leader><leader>l
" Plug 'haya14busa/vim-easyoperator-line'
" 在v 或者 ctrl-v 模式下 leader leader p 来选择一个范围
" Plug 'haya14busa/vim-easyoperator-phrase'
" noremap <leader>s  <Plug>(easymotion-s)
" noremap <leader><leader>s  <Plug>(easymotion-s)
" noremap <leader>S  <Plug>(easymotion-S)
" noremap <leader><leader>S  <Plug>(easymotion-S)
"  map  / <Plug>(easymotion-n)
"  omap / <Plug>(easymotion-tn)
"  map  n <Plug>(easymotion-next)
"  map  N <Plug>(easymotion-prev)

" hi link EasyMotionTarget ErrorMsg
" hi link EasyMotionShade  Comment
" hi link EasyMotionTarget2First MatchParen
" hi link EasyMotionTarget2Second MatchParen
" hi link EasyMotionMoveHL Search
" hi link EasyMotionIncSearch Search

" https://github.com/rhysd/vim-operator-surround
" Plug 'rhysd/vim-operator-surround' " 这个也能实现和 easymotion 相同的功能，但是这个还有更多的扩展性



" fuzzy search
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
noremap <C-p> <cmd>Commands<cr>
noremap <leader>fc <cmd>Commands<cr>
noremap <leader>ff <cmd>Files<cr>
noremap <leader>fb <cmd>Buffers<cr>
noremap <leader>fo <cmd>History<cr>
noremap <leader>ft <cmd>Helptags<cr>
noremap <leader>fm <cmd>Marks<cr>
noremap <leader>fM <cmd>Maps<cr>
noremap <leader>fl <cmd>Lines<cr>
noremap <leader>ft <cmd>Tags<cr>
"  noremap <leader>fl :<C-u>Lines<CR>
" 参考自fzf.vim   https://github.com/junegunn/fzf.vim/blob/d5f1f8641b24c0fd5b10a299824362a2a1b20ae0/plugin/fzf.vim#L57
command! -bang -nargs=* Grep call fzf#vim#grep("grep --line-number --color=always -r --exclude-dir=.git -- ".shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)
if system('command -v rg') =~ '\w\+'
  noremap <leader>fg <cmd>Rg<cr>
elseif system('command -v ag') =~ '\w\+'
  noremap <leader>fg <cmd>Ag<cr>
else
  noremap <Leader>fg <cmd>Grep<cr>
endif
" 增强 vim 的自身功能
noremap q: <cmd>History:<cr>
noremap q? <cmd>History/<cr>
noremap q/ <cmd>History/<cr>


" Limelight 灰色掉其他部分的内容
Plug 'junegunn/limelight.vim'
