" Lazy loading
" From https://github.com/junegunn/vim-plug/wiki/faq#conditional-activation
function! Cond(cond, ...)
    let opts = get(a:000, 0, {})
    return a:cond ? opts : extend(opts, { 'on': [], 'for': [], 'do': 'true'})
endfunction


call plug#begin(get(g:, 'home', '~/.vim') . '/plugged')

" 只在vim中安装、启用这些插件
if is_vim
  LoadScript user/_only_vim_plugins.vim
endif

" nvim 和 vim 中安装并启用以下的插件

" vim chinese documents
Plug 'yianwillis/vimcdoc'


" 号称是应该所有人都应该统一的设置
Plug 'tpope/vim-sensible'

" 自动设置 shiftwidth expandtab tabstop textwidth endofline fileformat fileencoding bomb
Plug 'tpope/vim-sleuth', Cond(is_nvim) " vim 下会使用vim-polyglot, 其内部自带了一个版本的此插件
" editorconfig 来配置相应的 indent 和其他配置
Plug 'editorconfig/editorconfig-vim'


" 增强 . 的功能，需要其他插件的支持
Plug 'tpope/vim-repeat'


" 给 vim 的 command-line 模式 和 insert 模式增加 readline 的快捷键，noremal 模式下的快捷键未开启
" insert 模式的 C-n 和 C-p 没有被重映射
" Plug 'tpope/vim-rsi'
" https://github.com/vim-utils/vim-husk 也有类似的用法，但是已经很久没更新了


" ga 展示更多的内容
" Plug 'tpope/vim-characterize'


" :Obsess 开始持续自动记录; :Obsess! 结束记录。扩展 vim 原生 `:mksession`
Plug 'tpope/vim-obsession'
"  Plug 'tpope/vim-endwise'


" stay my cursor
" Plug 'zhimsel/vim-stay'
" set viewoptions=cursor,folds,slash,unix

" https://github.com/inkarkat/vim-ReplaceWithRegister
Plug 'inkarkat/vim-ReplaceWithRegister'
nnoremap <leader>r <Plug>ReplaceWithRegisterOperator
nnoremap <leader>rr <Plug>ReplaceWithRegisterLine
xnoremap <leader>r <Plug>ReplaceWithRegisterVisual
" https://github.com/kana/vim-operator-replace
" 相似的功能
" Plug 'kana/vim-operator-replace'
" Plug 'kana/vim-grex' " 搜索(/)后，:[range]Grey 删除这些被搜索到的行


" vim的自动fold会减慢vim的速度，因为过早的计算fold，这个插件解决这个问题
Plug 'Konfekt/FastFold'
LoadScript configure/plugins/fastfold.vim

" python 的 fold 增强
Plug 'tmhedberg/SimpylFold', {'for': 'python'}

" 自动设置paste位
Plug 'roxma/vim-paste-easy'

" 增强 quickfix 功能 TODO
Plug 'romainl/vim-qf'
let g:qf_window_bottom = 1
let g:qf_loclist_window_bottom = 1
" 在 quickfix 和 locallist window 内有如下的按键映射
let g:qf_mapping_ack_style = 1
" s - open entry in a new horizontal window
" v - open entry in a new vertical window
" t - open entry in a new tab
" o - open entry and come back
" O - open entry and close the location/quickfix window
" p - open entry in a preview window


" TODO: 更多关于此的配置
Plug 'skywind3000/vim-quickui'


" statusline {{{

" Plug 'nvim-lualine/lualine.nvim'
" If you want to have icons in your statusline choose one of these
" Plug 'feline-nvim/feline.nvim'

" Plug 'bagrat/vim-buffet'
" }}}

" template support {{{
Plug 'aperezdc/vim-template'
" let g:templates_directory = [fnamemodify(resolve(expand('<sfile>:p')), ':h') . '/../templates']
let g:templates_directory = ['~/.config/nvim/templates']
let g:username = 'Hu Meng'
let g:email = 'mail@meng.hu'
let g:host='meng.hu'
let g:templates_use_licensee=0
let g:templates_name_prefix='.vim-template='
" }}}

" 这两个是为了 wilder 这个插件，这个依赖实在是太多了，而且各个都有自己的特殊依赖，太麻烦了
Plug 'romgrk/fzy-lua-native'
Plug 'nixprime/cpsm'
if has('nvim')
  function! UpdateRemotePlugins(...)
    " Needed to refresh runtime files
    let &rtp=&rtp
    UpdateRemotePlugins
  endfunction
  Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
else
  Plug 'gelguy/wilder.nvim'
  " To use Python remote plugin features in Vim, can be skipped
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
function s:config_wilder()
  call wilder#setup({'modes': [':', '/', '?']})
  call wilder#set_option('pipeline', [
        \   wilder#branch(
        \     wilder#python_file_finder_pipeline({
        \       'file_command': {_, arg -> stridx(arg, '.') != -1 ? ['fd', '-tf', '-H'] : ['fd', '-tf']},
        \       'dir_command': ['fd', '-td'],
        \       'filters': ['cpsm_filter'],
        \     }),
        \     wilder#substitute_pipeline({
        \       'pipeline': wilder#python_search_pipeline({
        \         'skip_cmdtype_check': 1,
        \         'pattern': wilder#python_fuzzy_pattern({
        \           'start_at_boundary': 0,
        \         }),
        \       }),
        \     }),
        \     wilder#cmdline_pipeline({
        \       'fuzzy': 2,
        \       'fuzzy_filter': has('nvim') ? wilder#lua_fzy_filter() : wilder#vim_fuzzy_filter(),
        \     }),
        \     [
        \       wilder#check({_, x -> empty(x)}),
        \       wilder#history(),
        \     ],
        \     wilder#python_search_pipeline({
        \       'pattern': wilder#python_fuzzy_pattern({
        \         'start_at_boundary': 0,
        \       }),
        \     }),
        \   ),
        \ ])

  let s:highlighters = [
        \ wilder#pcre2_highlighter(),
        \ has('nvim') ? wilder#lua_fzy_highlighter() : wilder#cpsm_highlighter(),
        \ ]

  let s:popupmenu_renderer = wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
        \ 'border': 'rounded',
        \ 'empty_message': wilder#popupmenu_empty_message_with_spinner(),
        \ 'highlighter': s:highlighters,
        \ 'left': [
        \   ' ',
        \   wilder#popupmenu_devicons(),
        \   wilder#popupmenu_buffer_flags({
        \     'flags': ' a + ',
        \     'icons': {'+': '', 'a': '', 'h': ''},
        \   }),
        \ ],
        \ 'right': [
        \   ' ',
        \   wilder#popupmenu_scrollbar(),
        \ ],
        \ }))

  let s:wildmenu_renderer = wilder#wildmenu_renderer({
        \ 'highlighter': s:highlighters,
        \ 'separator': ' · ',
        \ 'left': [' ', wilder#wildmenu_spinner(), ' '],
        \ 'right': [' ', wilder#wildmenu_index()],
        \ })

  call wilder#set_option('renderer', wilder#renderer_mux({
        \ ':': s:popupmenu_renderer,
        \ '/': s:wildmenu_renderer,
        \ 'substitute': s:wildmenu_renderer,
        \ }))
endfunction
augroup config_wilder
  autocmd!
  autocmd config_wilder VimEnter * call s:config_wilder()
augroup END


" surround + text-object {{{
" 增加更多的 文本对象，准确来说，是增加了 surround文本对象
" cs'" 会将 'hello world' 变成 "hello world". s' 就是surround the 单引号，最前面的 c 是 vim 原生的 change 命令
" 新增一个 ys 的 动作、文本对象，Hel|lo world! 执行 ysiw] 将会 变成 [hello] world!, yss] 将会编程 [hello world!]
Plug 'tpope/vim-surround'
" 更多的文本对象
Plug 'kana/vim-textobj-user'
" https://github.com/kana/vim-textobj-user/wiki
" die/dae 删除整个buffer
Plug 'kana/vim-textobj-entire'
" dil/dal 删除整行
Plug 'kana/vim-textobj-line'
" dif/daf 删除函数，nvim中可以使用 nvim-treesitter-textobjects 的 @function.inner 和 @function.outer
" 但是此插件只支持 vim c java 这三个语言，直接不用了
" Plug 'kana/vim-textobj-function'
" di_/da_ 使用 targets.vim 来实现了这个功能
" Plug 'kana/vim-textobj-underscore'
" dic/dac nvim 中可以使用 nvim-treesitter-textobjects 的 @comment.outer
" 但是这个插件目测支持的更好一些
Plug 'glts/vim-textobj-comment'
" di<Space>/da<Space> 删除这一行往下的空白行 删除这一行网上的空白行
Plug 'deathlyfrantic/vim-textobj-blanklines'
" az/iz
Plug 'kana/vim-textobj-fold'
" dib 删除 ()[]{}<>''""`` 这个实际上覆盖了 vim 的原生设置
Plug 'rhysd/vim-textobj-anyblock'
" diy 删除 syntax 内的内容， 感觉没用啊
" Plug 'kana/vim-textobj-syntax'
" 实际上拓展了vim自身的 is as 功能，但是没看明白到底扩展了啥
" Plug 'preservim/vim-textobj-sentence'
" difa 会删除 axxyfdfa 之间的内容 即 删除 xxyfdf
" 这个与 nvim-treesitter-textobjects 的 @function.inner 冲突
" Plug 'thinca/vim-textobj-between'
" json text object
"  Plug 'tpope/vim-jdaddy'
" }}}
" 此插件更多在乎 括号、引号 或者类似的逗号这样的分隔符的操作，比如 di, 会删除 两个逗号之间的内容
" 除此之外，还能实现 n(next下一个)括号中的内容的操作比如 din) 会删除下一个括号内的内容， 或者 d2iN) 会删除前面第二个
" 注意 N 是修改后的，原始是 l，但是与 textobj-line 的冲突了
" https://github.com/wellle/targets.vim/blob/master/cheatsheet.md
Plug 'wellle/targets.vim'
" let g:targets_seekRanges = 'cc cr cb cB lc ac Ac lr rr lb ar ab lB Ar aB Ab AB rb rB bb bB BB'
let g:targets_nl = 'nN'
" 有点像 textobj-user，这个用来定义方向，而不是前者的 textobj
" Plug 'kana/vim-operator-user'

" 虽然没有映射
Plug 'liuchengxu/vim-clap', { 'do': { -> clap#installer#force_download() } }


" s 搜索下面的内容， S搜索上面的内容
" 使用; ,来往下和网上继续搜索
Plug 'justinmk/vim-sneak'
" let g:sneak#label = 1 " 给sneak 增加了 类似 easymotion 的提示功能
let g:sneak#s_next = 1


Plug 'haya14busa/is.vim'
Plug 'haya14busa/incsearch.vim'
"  Plug 'haya14busa/incsearch-easymotion.vim'
" 模糊搜索，而不是傻傻的直接搜索或者还得写正则表达式
Plug 'haya14busa/incsearch-fuzzy.vim'
map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)
map zg/ <Plug>(incsearch-fuzzy-stay)

" 增强 * 这种跳转的功能
" 依赖 is.vim
Plug 'haya14busa/vim-asterisk'
map *   <Plug>(asterisk-*)<Plug>(is-nohl-1)
map #   <Plug>(asterisk-#)<Plug>(is-nohl-1)
map g*  <Plug>(asterisk-g*)<Plug>(is-nohl-1)
map g#  <Plug>(asterisk-g#)<Plug>(is-nohl-1)
map z*  <Plug>(asterisk-z*)<Plug>(is-nohl-1)
map gz* <Plug>(asterisk-gz*)<Plug>(is-nohl-1)
map z#  <Plug>(asterisk-z#)<Plug>(is-nohl-1)
map gz# <Plug>(asterisk-gz#)<Plug>(is-nohl-1)

" 展示现在搜索到第几个了
Plug 'osyo-manga/vim-anzu'
map n <Plug>(is-nohl)<Plug>(anzu-n-with-echo)
map N <Plug>(is-nohl)<Plug>(anzu-N-with-echo)

" 更聪明的f
Plug 'rhysd/clever-f.vim'


LoadScript configure/plugins/colorscheme.vim


" 使用 + 扩展当前的选择的范围， - 缩减当前的选择范围
Plug 'terryma/vim-expand-region'
map <M-w> <Plug>(expand_region_expand)
map <M-W> <Plug>(expand_region_shrink)


" Plug 'wsdjeg/vim-todo'
" Plug 'folke/todo-comments.nvim', Cond(is_nvim)
" Plug 'nvim-lua/plenary.nvim', Cond(is_nvim)
" Plug 'folke/trouble.nvim'

" :Remove :Delete :Move :Rename :Copy :Duplicate
" :Chmod :Mkdir :Cfind :Clocate :SudoWrite :SudoEdit
" :Lfind :Llocate :Wall 写入所有打开的window
Plug 'tpope/vim-eunuch', Cond(is_unixlike)
" 增加了很多好用的[ ]快捷键, 比如
" o[n 开启行号; o]h 关闭搜索高亮; o]x 关闭 cursorline cursorcolumn
" [<space> 在当前行之上添加新行
" [f 前一个文件; ]n 跳转SCM冲突的位置
Plug 'tpope/vim-unimpaired'


" git {{{
" git 命令 比如 Git / G / Git commit 之类的
Plug 'tpope/vim-fugitive'
Plug 'itchyny/vim-gitbranch'
" }}}

if has("patch-8.1.0360")
    set diffopt+=internal,algorithm:patience
endif
Plug 'chrisbra/vim-diff-enhanced'


" 使用 ALT+e 会在不同窗口/标签上显示 A/B/C 等编号，然后字母直接跳转
Plug 't9md/vim-choosewin'
let g:choosewin_overlay_enable = 1
 nmap <M-i> <Plug>(choosewin)

" gcc <virtual-mode>gc
Plug 'tpope/vim-commentary'
" noremap <c-s-/> :Commentary<cr>
" inoremap <c-s-/> <Esc>:Commentary<cr>i
" 这里实际上是 ctrl + / 我也不知道为啥需要这么做
noremap <c-_> :Commentary<cr>j
inoremap <c-_> <Esc>:Commentary<cr>ji
" https://github.com/preservim/nerdcommenter
" Plug 'preservim/nerdcommenter'

" support html/css/js {{{
Plug 'ap/vim-css-color'
" }}}


" tmux {{{
" :Tmux send tmux command
" :Tyank :Tput 访问tmux的buffer
" :Twrite 将内容发送给别的pane
" :Tattach 允许attach到非vim所在的tmux session中
Plug 'tpope/vim-tbone'


" 更好的在vim和tmux中移动 https://zhuanlan.zhihu.com/p/432256727
Plug 'christoomey/vim-tmux-navigator'
let g:tmux_navigator_no_mappings = 1
" 使用 <M-q> 也可以，这个设置来自 https://github.com/skywind3000/vim-terminal-help 的定义
" 来离开terminal的insert模式，进入normal模式
tnoremap <Esc> <C-\><C-n>
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
tnoremap <silent> <A-h> <C-\><C-N>:TmuxNavigateLeft<cr>
tnoremap <silent> <A-j> <C-\><C-N>:TmuxNavigateDown<cr>
tnoremap <silent> <A-k> <C-\><C-N>:TmuxNavigateUp<cr>
tnoremap <silent> <A-l> <C-\><C-N>:TmuxNavigateRight<cr>
tnoremap <silent> <A-=> <C-\><C-N>:TmuxNavigatePrevious<cr>
if has('nvim')
else
    " 修复一些奇奇怪怪的bug，实现：在所有模式下使用alt键了，包括insert模式
    " for i in range(65,90) + range(97,122)
    "   let c = nr2char(i)
    "   exec "map \e".c." <M-".c.">"
    "   exec "map! \e".c." <M-".c.">"

    "   exec "imap \e".c." <M-".c.">"
    "   exec "imap \e".c." <M-".c.">"
    " endfor
endif
noremap <silent> <A-h> <C-\><C-N>:TmuxNavigateLeft<cr>
noremap <silent> <A-j> <C-\><C-N>:TmuxNavigateDown<cr>
noremap <silent> <A-k> <C-\><C-N>:TmuxNavigateUp<cr>
noremap <silent> <A-l> <C-\><C-N>:TmuxNavigateRight<cr>
noremap <silent> <A-=> <C-\><C-N>:TmuxNavigatePrevious<cr>
inoremap <silent> <A-h> <C-\><C-N>:TmuxNavigateLeft<cr>
inoremap <silent> <A-j> <C-\><C-N>:TmuxNavigateDown<cr>
inoremap <silent> <A-k> <C-\><C-N>:TmuxNavigateUp<cr>
inoremap <silent> <A-l> <C-\><C-N>:TmuxNavigateRight<cr>
inoremap <silent> <A-=> <C-\><C-N>:TmuxNavigatePrevious<cr>
" }}}


Plug 'skywind3000/vim-terminal-help'
Plug 'wincent/terminus'
Plug 'voldikss/vim-floaterm'


Plug 'skywind3000/vim-dict'


Plug 'mbbill/undotree'

" 更好的 zf 创建fold marker的功能，
Plug 'dbmrq/vim-chalk'
LoadScript configure/plugins/vim_chalk.vim


" more filetype support{{{
" markdown support
Plug 'preservim/vim-markdown'
let g:vim_markdown_math = 1
" Plug 'mzlogin/vim-markdown-toc'

" toml support
Plug 'cespare/vim-toml'

" json support
Plug 'elzr/vim-json'
" }}}


"Tabular /= 通过=来对其文本
" Plug 'godlygeek/tabular'
" nmap <Leader>a= :Tabularize /=<CR>
" vmap <Leader>a= :Tabularize /=<CR>
" nmap <Leader>a: :Tabularize /:\zs<CR>
" vmap <Leader>a: :Tabularize /:\zs<CR>
" inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
" " TODO
" function! s:align()
"   let p = '^\s*|\s.*\s|\s*$'
"   if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
"     let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
"     let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
"     Tabularize/|/l1
"     normal! 0
"     call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
"   endif
" endfunction
" 这是个还是比较复杂的东西，简单来用 就是 vipga*= 在这个段落内的所有的=对齐，vipga= 对第一个=对齐，这里的=是指+= -=之类的
Plug 'junegunn/vim-easy-align'
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


Plug 'wellle/visual-split.vim'
" xmap <C-W>gr  <Plug>(Visual-Split-VSResize)
" xmap <C-W>gss <Plug>(Visual-Split-VSSplit)
" xmap <C-W>gsa <Plug>(Visual-Split-VSSplitAbove)
" xmap <C-W>gsb <Plug>(Visual-Split-VSSplitBelow)
" nmap <C-W>gr  <Plug>(Visual-Split-Resize)
" nmap <C-W>gss <Plug>(Visual-Split-Split)
" nmap <C-W>gsa <Plug>(Visual-Split-SplitAbove)
" nmap <C-W>gsb <Plug>(Visual-Split-SplitBelow)


Plug 'wesQ3/vim-windowswap'
" Navigate to the window you'd like to move
" Press <leader>ww
" Navigate to the window you'd like to swap with
" Press <leader>ww again


" 将选中的内容显示，其他的都不显示了，将注意力放在选中的文字中
" Plug 'chrisbra/NrrwRgn'


" 将你的浏览器的输入框也使用neovim来编辑
"  Plug 'glacambre/firenvim', Cond(is_nvim, { 'do': { _ -> firenvim#install(0) } })


" 类似于vscode的task，需要更加详细的配置 TODO
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'


" bookmark support {{{
" https://github.com/MattesGroeger/vim-bookmarks
" TODO
Plug 'MattesGroeger/vim-bookmarks'
let g:bookmark_auto_save = 1
" let g:bookmark_no_default_key_mappings = 1
let g:bookmark_auto_save_file = $HOME . '/.local/share/nvim_vim/bookmarks'
" nmap mm :BookmarkToggle<CR>
" nmap mi :BookmarkAnnotate<CR>
" nmap mn :BookmarkNext<CR>
" nmap mp :BookmarkPrev<CR>
" nmap ma :BookmarkShowAll<CR>
" nmap mc :BookmarkClear<CR>
" nmap mx :BookmarkClearAll<CR>
" nmap mkk :BookmarkMoveUp
" nmap mjj :BookmarkMoveDown
" }}}


" TODO:
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" TODO: 更多关于使用vim debug配置 {{{
" Plug 'mfussenegger/nvim-dap', Cond(is_nvim)
Plug 'puremourning/vimspector', Cond(is_vim && v:version>=8200)
" }}}


" https://github.com/akinsho/bufferline.nvim
"  Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }


"  Plug 'https://github.com/glepnir/lspsaga.nvim'


Plug 'sheerun/vim-polyglot'


" <leader>d
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }


" Plug 'hrsh7th/vim-vsnip'
" Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'
Plug 'honza/vim-snippets'

" view lsp-symbols and tags in neovim/vim
Plug 'liuchengxu/vista.vim'


Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'
let $GTAGSLABEL = 'native-pygments'
let $GTAGSCONF = expand('~/.gtags.conf')
" enable gtags module
let g:gutentags_modules = ['ctags', 'gtags_cscope']
" config project root markers.
let g:gutentags_project_root =  ['.root', '.svn', '.git', '.hg', '.project']
" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/tags')
" 配置 ctags 的参数，老的 Exuberant-ctags 不能有 --extra=+q，注意
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extras=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" 如果使用 universal ctags 需要增加下面一行，老的 Exuberant-ctags 不能加下一行
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
let g:gutentags_auto_add_gtags_cscope = 0
" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1
let g:gutentags_plus_nomap = 1
" let g:gutentags_define_advanced_commands = 1
" let g:gutentags_trace = 1
" noremap <silent> <leader>gs :GscopeFind s <C-R><C-W><cr>
" noremap <silent> <leader>gg :GscopeFind g <C-R><C-W><cr>
" noremap <silent> <leader>gc :GscopeFind c <C-R><C-W><cr>
" noremap <silent> <leader>gt :GscopeFind t <C-R><C-W><cr>
" noremap <silent> <leader>ge :GscopeFind e <C-R><C-W><cr>
" noremap <silent> <leader>gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
" noremap <silent> <leader>gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
" noremap <silent> <leader>gd :GscopeFind d <C-R><C-W><cr>
" noremap <silent> <leader>ga :GscopeFind a <C-R><C-W><cr>
" noremap <silent> <leader>gz :GscopeFind z <C-R><C-W><cr>


Plug 'justinmk/vim-dirvish'
" 让 dirvish 支持 curl 和 ssh 的远程目录
Plug 'bounceme/remote-viewer'
" 显示当前目录下的文件的 git 状态
Plug 'kristijanhusak/vim-dirvish-git'
Plug 'roginfarrer/vim-dirvish-dovish', {'branch': 'main'}
let g:dirvish_dovish_map_keys = 0
function s:remap_dirvish_dovish()
  " if !exists('g:DovishCopyFile')
    " return
  " endif
  " 需要 trash 命令
  nmap <silent><buffer> dd <Plug>(dovish_delete)
  nmap <silent><buffer> r <Plug>(dovish_rename)

  nmap <silent><buffer> O <Plug>(dovish_create_file)
  nmap <silent><buffer> A <Plug>(dovish_create_directory)

  nmap <silent><buffer> Y <Plug>(dovish_yank)
  xmap <silent><buffer> Y <Plug>(dovish_yank)
  nmap <silent><buffer> Pc <Plug>(dovish_copy)
  nmap <silent><buffer> Pm <Plug>(dovish_move)
  nnoremap <buffer> <C-b> :<C-u>close<cr>
endfunction
nnoremap <C-b> :<C-u>vert split +Dirvish<cr>
augroup dirvish_config
  autocmd!
  autocmd dirvish_config Filetype dirvish call s:remap_dirvish_dovish()
augroup END

Plug 'jdhao/better-escape.vim'


Plug 'francoiscabrol/ranger.vim'
let g:ranger_map_keys = 0
let g:ranger_command_override = 'ranger --cmd "set show_hidden=true"'

" 重新实现bdelete bwipepout，关闭buffer但是并不改变layout
" https://github.com/moll/vim-bbye
Plug 'moll/vim-bbye'
nnoremap \c <cmd>Bdelete<cr>
nnoremap \q <cmd>Bwipeout<cr>
nnoremap \C <cmd>Bdelete!<cr>
nnoremap \Q <cmd>Bwipeout!<cr>


" 大工程！
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_snippet_next = '<tab>'
function s:setup_coc_on_support_filetype()
  " 使用 vim 内置的 format 功能吧
  setl formatexpr=CocAction('formatSelected')
  " 映射成vscode的快捷键
  noremap <buffer> <F8> <Plug>(coc-diagnostic-next)
  noremap <buffer> <S-F8> <Plug>(coc-diagnostic-prev)
  noremap <buffer> <F2> <Plug>(coc-rename)
  noremap <buffer> <S-M-f> <Plug>(coc-format)
  noremap <buffer> <F12> <Plug>(coc-definition)
  noremap <buffer> <C-F12> <Plug>(coc-implementation)
  noremap <buffer> <S-F12> <Plug>(coc-references)
  noremap <buffer> <c-space> <Plug>(coc-fix-current)
  noremap <buffer> <c-i> <Plug>(coc-fix-current)

  " noremap <buffer> <leader>ln <Plug>(coc-diagnostic-next)
  " noremap <buffer> <leader>lp <Plug>(coc-diagnostic-prev)
  " noremap <buffer> <leader>lr <Plug>(coc-rename)
  " noremap <buffer> <leader>lf <Plug>(coc-format)
  " noremap <buffer> <leader>ld <Plug>(coc-definition)
  " noremap <buffer> <leader>li <Plug>(coc-implementation)
  " noremap <buffer> <leader>lr <Plug>(coc-references)
  " noremap <buffer> <leader>li <Plug>(coc-fix-current)
  noremap <buffer> <leader>lc <Plug>(coc-codeaction-cursor)
  noremap <buffer> <leader>ll <Plug>(coc-codeaction-line)
  noremap <buffer> <leader>la <Plug>(coc-codeaction)
  noremap <buffer> <leader>ls <Plug>(coc-codeaction-selected)

	xmap <buffer> if <Plug>(coc-funcobj-i)
	omap <buffer> if <Plug>(coc-funcobj-i)
	xmap <buffer> af <Plug>(coc-funcobj-a)
	omap <buffer> af <Plug>(coc-funcobj-a)
	xmap <buffer> ik <Plug>(coc-classobj-i)
	omap <buffer> ik <Plug>(coc-classobj-i)
	xmap <buffer> ak <Plug>(coc-classobj-a)
	omap <buffer> ak <Plug>(coc-classobj-a)


  inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction
endfunction
augroup configcoc
  autocmd!
  autocmd configcoc Filetype json,python,vim,sh,bash,ts,md,markdown,lua,go call s:setup_coc_on_support_filetype()
  autocmd configcoc Filetype markdown noremap <buffer> <S-M-f> :CocCommand markdownlint.fixAll<cr>
augroup END

call plug#end()
finish
" source ~/.vim/plugin/config.tabularize.vim
