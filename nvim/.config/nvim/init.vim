" mongoose's nvim/vim configure file
" 参考
" - https://github.com/skywind3000/vim-init/blob/master/init.vim
" -

" 防止重复加载
if get(s:, 'loaded', 0) != 0
	finish
else
	let s:loaded = 1
endif


" 一些有关于平台的判断
let g:is_vim = !has('nvim')
let g:is_nvim = has('nvim')
let g:is_osx = has('macunix')
let g:is_linux = has('unix') && !has('macunix') && !has('win32unix')
let g:is_windows = (has('win16') || has('win32') || has('win64'))
let g:is_unixlike = !is_windows
let s:uname = system("uname -s")
let g:is_freebsd = (match(s:uname, 'FreeBSD') >= 0)


"  exec 'source '.s:home.'init/init-source.vim'

" 取得本文件所在的目录
let g:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')

" 定义一个命令用来加载文件
command! -nargs=1 LoadScript exec 'so '.g:home.'/'.'<args>'


"----------------------------------------------------------------------
" 模块加载
"----------------------------------------------------------------------

" 加载基础配置
LoadScript user/basic.vim
LoadScript user/keymaps.vim
" let g:colors_name = 'desert'
" let g:colors_name = 'evening'
" let g:colors_name = 'industry'
" let g:colors_name = 'koehler'
" let g:colors_name = 'murphy'
" let g:colors_name = 'pablo'
" let g:colors_name = 'slate'
let g:colors_name = 'torte'
LoadScript user/install-plugins.vim
" call plug#begin(get(g:, 'home', '~/.vim') . '/plugged')
  " Plug 'neoclide/coc.nvim', {'branch': 'release'}
" call plug#end()


if is_nvim
lua require 'core.options'
lua require 'core.settings'
lua require 'core.plugins'

" packadd packer.nvim
" lua << EOF
"   return require('packer').startup(function()
" EOF

endif


" 某些情况下本地需要调整一些设置，不需要加入git中，但是确实有很重要，比如vim-template中的 user 和 email

if filereadable('localconfigs.vim')
  LoadScript localconfigs.vim
endif


" 有些主题需要配置其他的东西，这里只在最后添加一个
exe 'colorscheme ' . g:colors_name
